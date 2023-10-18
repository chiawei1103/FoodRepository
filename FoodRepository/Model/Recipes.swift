//
//  Recipes.swift
//  FoodRepository
//
//  Created by Lawrence on 10/11/23.
//

import Foundation

struct RawRecipes: Decodable {
    let meals: [[String: String?]]
}

class Recipe: Identifiable, ObservableObject {
    var id: Int64
    var title: String
    var category: String?
    var area: String?
    var thumbnail: String?
    var tags: [Tag]?
    var video: String?
    var ingredients: [String: String]
    var instruction: String?
    var isFavorite: Bool = false
    
    init(id: Int64, title: String, ingredients: [String : String], isFavorite: Bool) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.isFavorite = isFavorite
    }
}

struct Tag: Hashable, Identifiable {
    var id: UUID
    var tag: String
}
extension Tag {
    init(tagCoreData: Tags) {
        self.id = tagCoreData.id ?? UUID()
        self.tag = tagCoreData.tag ?? ""
    }
}

struct IngredientCoreData: Hashable, Identifiable {
    var id: UUID
    var ingredient: String
    var measure: String
}
extension IngredientCoreData {
    init(ingredientCoreData: Ingredients) {
        self.id = ingredientCoreData.id ?? UUID()
        self.ingredient = ingredientCoreData.ingredient ?? ""
        self.measure = ingredientCoreData.measure ?? ""
    }
}
struct RecipeCoreData: Identifiable {
    var id: Int64
    var title: String?
    var category: String?
    var area: String?
    var thumbnail: String?
    var tags: Tags?
    var video: String?
    var ingredients: Ingredients?
    var instruction: String?
    
}

extension RecipeCoreData {
    init(recipeCoreData: Recipes) {
        self.id = recipeCoreData.id
        self.title = recipeCoreData.title ?? ""
        self.category = recipeCoreData.category
        self.area = recipeCoreData.area
        self.thumbnail = recipeCoreData.thumbnail
        self.tags = recipeCoreData.tags
        self.video = recipeCoreData.video
        self.ingredients = recipeCoreData.ingredients
        self.instruction = recipeCoreData.instruction
    }
    
    func convertingToRecipe() -> Recipe {
        let ingredient = self.ingredients
        print("In: \(ingredient)")
        print("tag: \(self.tags)")
        let recipe = Recipe(id: self.id,
                            title: self.title ?? "",
                            ingredients: ["ingredient" : "measure"],
                            isFavorite: true)
        recipe.category = self.category
        recipe.area = self.area
        recipe.thumbnail = self.thumbnail
        recipe.video = self.video
        recipe.instruction = self.instruction
        return recipe
    }
}
