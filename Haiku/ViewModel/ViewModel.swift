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
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let base64 = imageData.base64EncodedString()
        pickedImage = PickedImage(image: image, base64String: base64)
    }
}
