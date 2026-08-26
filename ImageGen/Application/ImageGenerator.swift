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
    var ingredients: [String] = []
    
    //ImagePlaygroundConcept - provide text to incorporate into the image-creation process.
    var concepts: [ImagePlaygroundConcept] {
        var playgroundConcepts = [ImagePlaygroundConcept.text(recipe)]
        for ingredient in ingredients {
            playgroundConcepts.append(.text(ingredient))
        }
        return playgroundConcepts
    }
        
    func resetGenerator() {
        recipe = ImageGenerator.defaultRecipe
        style = ImageGenerator.defaultStyle
        ingredients.removeAll()
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
