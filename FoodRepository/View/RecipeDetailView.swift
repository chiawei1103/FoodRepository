//
//  RecipeDetailView.swift
//  FoodRepository
//
//  Created by Lawrence on 10/12/23.
//

import SwiftUI
import AVKit

struct RecipeDetailView: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    @ObservedObject var recipe: Recipe
    
    @State var tags = ["Tart", "Baking", "Fruit", "Dessert", "British"]
    @State var instruction = "Preheat the oven to 200C/180C Fan/Gas 6.\r\nPut the biscuits in a large re-sealable freezer bag and bash with a rolling pin into fine crumbs. Melt the butter in a small pan, then add the biscuit crumbs and stir until coated with butter. Tip into the tart tin and, using the back of a spoon, press over the base and sides of the tin to give an even layer. Chill in the fridge while you make the filling.\r\nCream together the butter and sugar until light and fluffy. You can do this in a food processor if you have one. Process for 2-3 minutes. Mix in the eggs, then add the ground almonds and almond extract and blend until well combined.\r\nPeel the apples, and cut thin slices of apple. Do this at the last minute to prevent the apple going brown. Arrange the slices over the biscuit base. Spread the frangipane filling evenly on top. Level the surface and sprinkle with the flaked almonds.\r\nBake for 20-25 minutes until golden-brown and set.\r\nRemove from the oven and leave to cool for 15 minutes. Remove the sides of the tin. An easy way to do this is to stand the tin on a can of beans and push down gently on the edges of the tin.\r\nTransfer the tart, with the tin base attached, to a serving plate. Serve warm with cream, fraiche or ice cream."
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("How to make...")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                            .foregroundStyle(.neutral90)
                        Text(recipe.title)
                            .fontWeight(.semibold)
                            .font(.system(size: 32))
                            .foregroundStyle(.neutral90)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if let url = recipe.thumbnail {
                        AsyncImage(url: URL(string: url)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                // Displays the loaded image.
                            } else if phase.error != nil {
                                Color.red // Indicates an error.
                            } else {
                                Color.blue // Acts as a placeholder.
                            }
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(height: 100)
                    }
                    
//                    Image("recipe1")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .clipShape(.rect(cornerRadius: 10))
//                        .frame(height: 100)
                }
                
//                if let url = URL(string: recipe.video ?? "") {
//                    VideoPlayer(player: AVPlayer(url: url))
//                        .clipShape(.rect(cornerRadius: 12))
//                        .frame(height: 200)
//                }
                
                if let tags = recipe.tags {
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(tags) { tag in
                                TagItem(tagName: tag.tag)
                            }
                        }
                        .padding(.leading, 1)
                    }
                    .scrollIndicators(.hidden)
                    .frame(maxWidth: .infinity)
                }
                
                HStack(alignment: .center) {
                    Text("Ingredients")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundStyle(.neutral90)
                    Spacer()
                    Text("\(recipe.ingredients.count) items")
                        .fontWeight(.regular)
                        .font(.system(size: 14))
                        .foregroundStyle(.neutral40)
                    
                }
                
                VStack(spacing: 12) {
                    ForEach(recipe.ingredients.sorted(by: <), id: \.key) { key, value in
                        Ingredient(icon: "🍞", ingredient: key, measure: value)
                    }
                }
                
                if let instruction = recipe.instruction {
                    Text("Instruction")
                        .fontWeight(.semibold)
                        .font(.system(size: 20))
                        .foregroundStyle(.neutral90)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 16)
                    
                    Text(instruction)
                        .fontWeight(.regular)
                        .font(.system(size: 16))
                        .foregroundStyle(.neutral90)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(7)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 20)
            .toolbar(.visible, for: .navigationBar)
            .toolbar(content: {
                Button(action: {
                    recipe.isFavorite.toggle()
                    recipeViewModel.favoriteRecipe = self.recipe
                    
                    if recipeViewModel.favoriteRecipeList.contains( where: { $0.id == self.recipe.id } ) {
                        try? recipeViewModel.removeFavoriteItem()
                    } else {
                        try? recipeViewModel.addFavorite()
                    }
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
                .padding(.trailing, 20)
            })
        }
    }
}

#Preview {
    RecipeDetailView(recipeViewModel: RecipeViewModel(webService: WebService()), recipe: Recipe(id: 1234, title: "Apple Pie", ingredients: ["water": "200g", "yellow pepper": "500g"], isFavorite: false))
}

struct TagItem: View {
    @State var tagName: String
    var body: some View {
        Text(tagName)
            .fontWeight(.semibold)
            .font(.system(size: 14))
            .foregroundStyle(.primary50)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.primary50, lineWidth: 1)
                    
            }
            .frame(height: 36)
    }
}
