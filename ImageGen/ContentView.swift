//
//  ContentView.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 20/08/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if appManager.showKitchen {
                    KitchenView()
                } else {
                    StartView()
                }
//                if let url = appManager.createdImageURL, let image = NSImage(contentsOf: url) {
//                    let _ = appManager.currentImage = image
//                    Image(nsImage: image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                } else {
//                    StartView()
//                }
            }
            .overlay {
                if appManager.isGenerating {
                    loadingView()
                }
            }
        }
    }
    
    private func loadingView() -> some View {
        HStack(spacing: 8) {
            ProgressView()
            Text("Generating image...")
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ContentView()
        .previewEnvironment()
}
