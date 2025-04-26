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
    
    func processImage(_ image: UIImage) {
        let resized = ImageHelpers.resizeImage(image: image, targetSize: CGSize(width: 512, height: 512))
        guard let imageData = resized.jpegData(compressionQuality: 0.8) else { return }
        let base64 = imageData.base64EncodedString()
        print("base64 = \(base64)")
        pickedImage = PickedImage(image: image, base64String: base64)
    }
}
