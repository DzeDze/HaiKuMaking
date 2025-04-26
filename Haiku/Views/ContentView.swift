//
//  ContentView.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var showPicker = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let picked = viewModel.pickedImage {
                Image(uiImage: picked.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
            }
            
            Button("Pick Image") {
                showPicker = true
            }
        }
        .padding()
        .sheet(isPresented: $showPicker) {
            PhotoPicker { image in
                if let image = image {
                    viewModel.processImage(image)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
