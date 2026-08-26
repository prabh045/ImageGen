//
//  ImageButtonsView.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 24/08/26.
//

import SwiftUI
import ImagePlayground

struct ImageButtonsView: View {
    @Environment(AppManager.self) private var appManager
    @State private var showImagePlayground: Bool = false
    var displayForMenu = false
    
    
    var body: some View {
        @Bindable var imageGenerator = appManager.imageGenerator
        
        Group {
            if displayForMenu {
                Group {
                    regenerateButton
                    shareButton
                }
            } else {
                regenerateButton
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            shareButton
                        }
                    }
            }
        }
        .imagePlaygroundSheet(
            isPresented: $showImagePlayground,
            concepts: imageGenerator.concepts,
            sourceImage: appManager.currentImage.map(Image.init),
            onCompletion: { url in
                if let data = try? Data(contentsOf: url), let nsImage = NSImage(data: data) {
                    appManager.currentImage = nsImage
                    appManager.createdImageURL = url
                }
        })
        .imagePlaygroundGenerationStyle(imageGenerator.style)
    }
    
    private var regenerateButton: some View {
        Button("Regenerate", systemImage: "arrow.clockwise") {
            showImagePlayground = true
        }
        .buttonStyle(.plain)
        .font(.footnote)
        .disabled(!appManager.showKitchen)
    }
    
    @ViewBuilder
    private var shareButton: some View {
        if let image = appManager.currentImage {
            let preview = SharePreview("My Recipe", image: image)
            ShareLink(item: image, preview: preview) {
                Label("Share the image", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ImageButtonsView()
}
