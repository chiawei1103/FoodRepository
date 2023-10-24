//
//  FavoriteRecipeListView.swift
//  FoodRepository
//
//  Created by Lawrence on 10/17/23.
//

import SwiftUI

struct FavoriteRecipeListView: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Text("Favorite Recipes")
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                    .foregroundStyle(.neutral90)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)

                if !recipeViewModel.favoriteRecipeList.isEmpty {
                    List {
                        ForEach(recipeViewModel.favoriteRecipeList) { recipe in
                            ZStack {
                                RecipeItem(recipe: recipe.convertingToRecipe())
                                NavigationLink(
                                    destination: RecipeDetailView(
                                    recipeViewModel: recipeViewModel,
                                    recipe: recipe.convertingToRecipe())) {
                                }
                                .buttonStyle(PlainButtonStyle())
                                .opacity(0)
                            }
                            .listRowSeparator(.hidden)
                            .listRowSpacing(6)
                        }
                    }
                    .listStyle(.plain)
                } else {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                        .progressViewStyle(CircularProgressViewStyle(tint: .neutral20))
                        .scaleEffect(1.5, anchor: .center) // Makes the spinner larger
                          .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                              // Simulates a delay in content loading
                              // Perform transition to the next view here
                            }
                          }
                }
            }
        }
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    FavoriteRecipeListView(recipeViewModel: RecipeViewModel(webService: WebService()))
}
