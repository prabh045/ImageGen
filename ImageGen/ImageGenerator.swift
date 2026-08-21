//
//  ImageGenerator.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 20/08/26.
//

import SwiftUI
import ImagePlayground

@Observable
class ImageGenerator {
    var recipe = ImageGenerator.defaultRecipe
    var style = ImageGenerator.defaultStyle
    
    //ImagePlaygroundConcept - provide text to incorporate into the image-creation process.
    var concepts: [ImagePlaygroundConcept] {
        [ImagePlaygroundConcept.text(recipe)]
    }
    
    func generateImage() async throws -> ImageCreator.CreatedImage {        
        let imageCreator = try await ImageCreator()
        let images = imageCreator.images(for: concepts, style: style, limit: 1)
        
        for try await image in images {
            return image
        }
        
        throw ImageCreator.Error.creationFailed
    }
}

extension ImageGenerator {
    static let recipes = ["Salad", "Sandwich", "Ice cream"]
    // determines appeaance of generated Images
    static let styles: [ImagePlaygroundStyle] = [
        .animation,
        .illustration,
        .sketch
    ]
    static let imageSize: CGFloat = 256
    private static let defaultRecipe = recipes[0]
    private static let defaultStyle = styles[0]
}
