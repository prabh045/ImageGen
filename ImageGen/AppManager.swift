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
        guard let createdImageURL else {
            return
        }
        currentImage = NSImage(contentsOf: createdImageURL)
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
    
    func add(ingredient: String) {
        imageGenerator.ingredients.append(ingredient)
        generateImage()
    }
    
    func remove(ingredient: String) {
        if let index = imageGenerator.ingredients.firstIndex(of: ingredient) {
            imageGenerator.ingredients.remove(at: index)
        }
        generateImage()
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
