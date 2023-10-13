//
//  RecipeViewModel.swift
//  FoodRepository
//
//  Created by Lawrence on 10/11/23.
//

import Foundation

enum ViewState {
    case loading
    case loaded
    case error
}

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var viewState = ViewState.loading
    @Published var recipes: [Recipe] = []
    @Published var recipeDetailViewModel: RecipeDetailViewModel?
    
    let webService: APIImplement
    init(webService: APIImplement) {
        self.webService = webService
    }
    
    func searchRecipes(query: String) {
        recipes = []
        let params: URLQueryItem = {
            if query.count > 1 {
                URLQueryItem(name: "s", value: query)
            } else {
                URLQueryItem(name: "f", value: query)
            }
        }()
        Task {
            let networkRequest = NetworkRequest(baseUrl: Constants.baseSearchRecipeUrl, path: "", params: [params], type: .GET, headers: [:])
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: RawRecipes.self)

                if let rawMeals = result?.meals {
                    for rawRecipe in rawMeals {
                        parsing(meal: rawRecipe) { recipe in
                            self.recipes.append(recipe)
                        }
                    }
                    self.viewState = .loaded
                } else {
                    self.viewState = .error
                }
                
            } catch {
                print(error)
                print(error.localizedDescription)
                self.viewState = .error
            }
        }
    }
    
    func getRandomRecipes() {
        recipes = []
        Task {
            let networkRequest = NetworkRequest(baseUrl: Constants.baseRandomRecipeUrl, path: "", params: [], type: .GET, headers: [:])
            for _ in 1...10 {
                do {
                    let result = try await webService.fetchData(request: networkRequest, modelType: RawRecipes.self)
                    if let rawMeal = result?.meals.first {
                        parsing(meal: rawMeal) { recipe in
                            self.recipes.append(recipe)
                        }
                    } else {
                        self.viewState = .error
                    }
                } catch {
                    print(error)
                    print(error.localizedDescription)
                    self.viewState = .error
                }
            }
        }
    }
    
    func parsing(meal: [String: String?], completionHandler: (Recipe) -> Void){
        guard let idMeal = meal["idMeal"] else { return }
        guard let idMeal = idMeal else { return }
        
        guard let strMeal = meal["strMeal"] else { return }
        guard let strMeal = strMeal else { return }

        var ingredients = [String: String]()
        for index in 1...20 {
            let ingredient = "strIngredient\(index)"
            let measure = "strMeasure\(index)"
            guard let ingredient = meal["\(ingredient)"] else { return }
            guard let ingredient = ingredient else { return }
            guard let measure = meal["\(measure)"] else { return }
            guard let measure = measure else { return }
            if ingredient != "" && measure != "" {
                ingredients.updateValue(measure, forKey: ingredient)
            }
        }
        
        var recipe = Recipe(id: idMeal, title: strMeal, ingredients: ingredients,isFavorite: false)
        
        guard let strInstructions = meal["strInstructions"] else { return }
        recipe.instruction = strInstructions
        
        guard let strCategory = meal["strCategory"] else { return }
        recipe.category = strCategory
        if let category = recipe.category {
            recipe.tags?.append(category)
        }
        
        guard let strArea = meal["strArea"] else { return }
        recipe.area = strArea
        if let area = recipe.area {
            recipe.tags?.append(area)
        }
        
        guard let strMealThumb = meal["strMealThumb"] else { return }
        recipe.thumbnail = strMealThumb
        
        guard let strTags = meal["strTags"] else { return }
        if let strTags = strTags {
            let tags = strTags.components(separatedBy: ",")
            recipe.tags = tags
        }
        
        guard let strYoutube = meal["strYoutube"] else { return }
        recipe.video = strYoutube
 
        completionHandler(recipe)
    }
}
