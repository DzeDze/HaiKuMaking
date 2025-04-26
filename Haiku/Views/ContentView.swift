//
//  ContentView.swift
//  Haiku
//
//  Created by Vince P. Nguyen on 2025-04-25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel
    @State private var showPicker = false
    private var haikuGenerator: HaikuGenerator
    
    init(haikuGenerator: HaikuGenerator) {
        self.haikuGenerator = haikuGenerator
        self._viewModel = StateObject(wrappedValue: ViewModel(haikuGenerator: haikuGenerator))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if let picked = viewModel.pickedImage {
                Image(uiImage: picked.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
            }
            
            if viewModel.isLoadingHaiku {
                ProgressView()
                    .padding()
            } else {
                Text(viewModel.haiku)
                    .frame(alignment: .center)
                    .padding()
            }
            Spacer()
            Button("Pick Image") {
                showPicker = true
            }
        }
        .padding()
        .sheet(isPresented: $showPicker) {
            PhotoPicker { image in
                if let image = image {
                    viewModel.processImage(image)
                    Task {
                        await viewModel.getHaiku()
                    }
                }
            }
        }
        .overlay {
            if let errorString = viewModel.errorString {
                Text(errorString)
            }
        }
    }
}

#Preview {
    ContentView(haikuGenerator: RemoteHaikuGenerator(apiKey: "", endpoint: URL(string: "https://37ca-198-84-224-217.ngrok-free.app/v1/chat/completions")!))
}
