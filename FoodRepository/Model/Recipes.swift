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
    var id: String
    var title: String
    var category: String?
    var area: String?
    var thumbnail: String?
    var tags: [String]?
    var video: String?
    var ingredients: [String: String]
    var instruction: String?
    var isFavorite: Bool = false
    
    init(id: String, title: String, ingredients: [String : String], isFavorite: Bool) {
        self.id = id
        self.title = title
        self.ingredients = ingredients
        self.isFavorite = isFavorite
    }
}
