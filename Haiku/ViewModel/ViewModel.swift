//
//  ViewModel.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import Foundation
import PhotosUI

class ViewModel: ObservableObject {
    @Published var pickedImage: PickedImage?
    @Published var haiku: String = ""
    @Published var isLoadingHaiku = false
    @Published var errorString: String?
    
    private var haikuGenerator: HaikuGenerator
    
    init(haikuGenerator: HaikuGenerator) {
        self.haikuGenerator = haikuGenerator
    }
    
    func processImage(_ image: UIImage) {
        let resized = ImageHelpers.resizeImage(image: image, targetSize: CGSize(width: 512, height: 512))
        guard let imageData = resized.jpegData(compressionQuality: 0.8) else { return }
        let base64 = imageData.base64EncodedString()
        pickedImage = PickedImage(image: image, base64String: base64)
    }
    
    @MainActor
    func getHaiku() async {
        
        if isLoadingHaiku { return }
        
        isLoadingHaiku = true
        errorString = nil
        
        defer { isLoadingHaiku = false }
        
        guard let base64String = pickedImage?.base64String else { return }
        
        do {
            self.haiku = try await haikuGenerator.generateHaiku(base64ImageData: base64String)
        } catch(let error as NetworkError){
            self.errorString = error.description
        } catch {
            self.errorString = error.localizedDescription
        }
    }
}
