//
//  IngredientListView.swift
//  ImageGen
//
//  Created by Prabhdeep Singh on 25/08/26.
//

import SwiftUI

struct IngredientListView: View {
    @Environment(AppManager.self) private var appManager
    @State private var newIngredient = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Add new ingedient", text: $newIngredient)
                .textFieldStyle(.roundedBorder)
                .onSubmit {
                    appManager.add(ingredient: newIngredient)
                    newIngredient = ""
                }
            
            if !appManager.imageGenerator.ingredients.isEmpty {
                Text("Added Ingredients")
                    .font(.body.bold())
                    .padding(.vertical, 8)
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(appManager.imageGenerator.ingredients, id: \.description) { ingredient in
                        field(ingredient: ingredient)
                    }
                }
            }
        }
    }
    
    private func field(ingredient: String) -> some View {
        HStack {
            Text(ingredient.capitalized)
                .lineLimit(1)
            
            Spacer()
            
            Button {
                appManager.remove(ingredient: ingredient)
            } label: {
                Image(systemName: "xmark.circle.fill")
            }
            .buttonStyle(.plain)

        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(.white)
        .background(.blue, in: Capsule())
    }
}

#Preview {
    IngredientListView()
        .previewEnvironment()
        .padding()
}
