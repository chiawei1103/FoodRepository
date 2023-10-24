//
//  RecipeSearchView.swift
//  FoodRepository
//
//  Created by Lawrence on 10/9/23.
//

import SwiftUI

struct RecipeSearchView: View {
    @State var query = ""
    @StateObject var viewModel = RecipeViewModel(webService: WebService())
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Recipe")
                        .fontWeight(.semibold)
                        .font(.system(size: 40))
                        .foregroundStyle(.neutral90)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Button(action: {
                        print("show my saved recipes")
                        try? viewModel.fetchRecipeList()
                        viewModel.isSheetPresented.toggle()
                    }, label: {
                        HStack(alignment: .center, spacing: 9) {
                            Image(systemName: "bookmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.white)
                            Text("My Recipes")
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        .frame(height: 28)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 6)
                        .background(.primary50)
                        .clipShape(.rect(cornerRadius: 12))
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 22)
            .padding(.top, 20)
            
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.neutral20)
                    .padding(.vertical, 20)
                    .padding(.leading, 16)
                TextField("",
                          text: $query,
                          prompt:
                            Text("Search recipes")
                                .foregroundColor(.neutral30)
                )
                .onChange(of: query){ newquery in
                    viewModel.searchRecipes(query: newquery)
                }
                .fontWeight(.regular)
                .foregroundStyle(.neutral90)
                .font(.system(size: 16))
                .padding(.trailing, 16)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.neutral20, lineWidth: 1)
                    .frame(height: 44)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 23)
            
            Text("Recommendations")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            if !viewModel.recipes.isEmpty {
                List {
                    ForEach(viewModel.recipes) { recipe in
                        ZStack {
                            RecipeItem(recipe: recipe)
                            NavigationLink(destination: RecipeDetailView(recipeViewModel: viewModel, recipe: recipe)) {
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
        .onAppear {
            viewModel.getMainIngredient()
            if query == "" || viewModel.recipes.count < 10 {
                viewModel.getRandomRecipes()
            }
        }
        .sheet(isPresented: $viewModel.isSheetPresented, content: {
            FavoriteRecipeListView(recipeViewModel: viewModel)
        })
    }
}

#Preview {
    RecipeSearchView()
}
