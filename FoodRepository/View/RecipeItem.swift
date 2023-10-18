//
//  RecipeItem.swift
//  FoodRepository
//
//  Created by Lawrence on 10/11/23.
//

import SwiftUI

struct RecipeItem: View {
//    @State var thumbnail: URL?
//    @State var recipeName: String
    @State var isFavorited = false
    @ObservedObject var recipe: Recipe
    var body: some View {
        HStack {
//            Image("recipe1")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .clipShape(.rect(cornerRadius: 10))
//                .frame(width: 52, height: 52)
//                .padding(.leading, 16)
//                .padding(.vertical, 12)
            if let url = recipe.thumbnail {
                AsyncImage(url: URL(string: url)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        // Displays the loaded image.
                    } else if phase.error != nil {
                        Color.red // Indicates an error.
                    } else {
                        Color.blue // Acts as a placeholder.
                    }
                }
                .clipShape(.rect(cornerRadius: 10))
                .frame(width: 52, height: 52)
                .padding(.leading, 16)
                .padding(.vertical, 12)
            }
                
            Text(recipe.title)
                .lineLimit(2)
                .fontWeight(.semibold)
                .font(.system(size: 16))
                .foregroundStyle(.neutral90)
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    recipe.isFavorite.toggle()
                    print("recipe.isFavorite: \(recipe.isFavorite)")
                }, label: {
                    Image(systemName: recipe.isFavorite ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.neutral90)
                        .frame(width: 18, height: 18)
                        .background {
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                        }
                        .shadow(color: Color(.neutral95).opacity(0.15),
                            radius: 12.5, x: 0, y: 8)
                })
                    
                Image(systemName: "arrow.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.neutral90)
                    .frame(width: 16, height: 16)
            }
            .padding(.horizontal, 20)

            
        }
        .background {
            Color.neutral10
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    RecipeItem(recipe: Recipe(id: 1234, title: "Recipe1", ingredients: ["water": "200g"], isFavorite: false))
}
