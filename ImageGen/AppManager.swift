//
//  AppManager.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 20/08/26.
//

import SwiftUI
import ImagePlayground

@Observable
class AppManager {
    let imageGenerator = ImageGenerator()
    var currentImage: NSImage?
    var createdImageURL: URL?
    
    private(set) var error: Error?
    private(set) var isGenerating = false
    
    func generateImage() {
        error = nil
        isGenerating = true
        
        Task {
            do {
                let generatedImage = try await imageGenerator.generateImage()
                currentImage = NSImage(cgImage: generatedImage.cgImage, size: .zero)
                isGenerating = false
            } catch {
                self.error = error
                isGenerating = false
            }
        }
    }
    
    func reset() {
        imageGenerator.resetGenerator()
        currentImage = nil
        createdImageURL = nil
        isGenerating = false
    }
    
    var showKitchen: Bool {
        createdImageURL != nil
    }
}

extension View {
    func previewEnvironment(generateImage: Bool = true) -> some View {
        let appManager = AppManager()
        return environment(appManager)
            .onAppear {
                if generateImage {
                    appManager.imageGenerator.style = .animation
                    appManager.generateImage()
                }
            }
    }
}
