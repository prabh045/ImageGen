//
//  StartView.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 20/08/26.
//

import SwiftUI
import ImagePlayground

struct StartView: View {
    @Environment(AppManager.self) private var appManager
    @Environment(\.supportsImagePlayground) private var supportsImagePlayground
    @State private var showImagePlayground = false
    
    
    var body: some View {
        @Bindable var imageGenerator = appManager.imageGenerator
        
        VStack(alignment: .leading, spacing: 16) {
            Text("Create a unique Dish")
                .font(.largeTitle.weight(.semibold))
            
            Label("Choose a dish", systemImage: "fork.knife")
                .padding(.top, 8)
            Picker("Recipes", selection: $imageGenerator.recipe) {
                ForEach(ImageGenerator.recipes, id: \.description) { recipe in
                    Text(recipe)
                }
            }
            
            Label("Choose a Image Style", systemImage: "paintpalette.fill")
                .padding(.top, 8)
            Picker("Styles", selection: $imageGenerator.style) {
                ForEach(ImageGenerator.styles) { style in
                    Text(style.id.capitalized)
                        .tag(style)
                }
            }
            
            Spacer()
        }
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                Button("Generate Image") {
                    if supportsImagePlayground {
                        showImagePlayground = true
                    } else {
                        print("❌ Image Playground unavailable \(supportsImagePlayground)")
                    }
                }
                .buttonStyle(.glassProminent)
                .disabled(imageGenerator.style == nil)
            }
        })
        .imagePlaygroundSheet(isPresented: $showImagePlayground, concept: imageGenerator.recipe, onCompletion: { url in
            appManager.createdImageURL = url
            print("Generated image:", url)
        })
        .pickerStyle(.segmented)
        .labelsHidden()
        .frame(width: ImageGenerator.imageSize)
        .padding()
        
    }
}

#Preview {
    StartView()
        .previewEnvironment()
}
