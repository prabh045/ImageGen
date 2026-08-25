//
//  SwiftUIView.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 21/08/26.
//

import SwiftUI

struct KitchenView: View {
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Refine Your Dish")
                .font(.largeTitle.weight(.semibold))
            imageArea
            ImageButtonsView()
            IngredientListView()
            Spacer()
            if let error = appManager.error {
                Text(error.localizedDescription)
                    .foregroundStyle(Color.red)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("Start Over", systemImage: "chevron.left") {
                    appManager.reset()
                }
            }
        }
    }
    
    private var imageArea: some View {
        Group {
            if let url = appManager.createdImageURL, let image = NSImage(contentsOf: url) {
                let _ = appManager.currentImage = image
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.2))
            }
        }
        .frame(width: ImageGenerator.imageSize, height: ImageGenerator.imageSize)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

