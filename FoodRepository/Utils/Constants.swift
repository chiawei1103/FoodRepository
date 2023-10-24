//
//  Constants.swift
//  FoodRepository
//
//  Created by Lawrence on 10/11/23.
//

import Foundation

struct Constants {
    static let baseSearchRecipeUrl = "https://www.themealdb.com/api/json/v1/1/search.php"
    static let baseRandomRecipeUrl = "https://www.themealdb.com/api/json/v1/1/random.php"
    static let baseIngredientRecipeUrl = "https://www.themealdb.com/api/json/v1/1/filter.php"
    static let baseBarcodeUrl = "https://api.upcdatabase.org/product/"
    static let apiKey = URLQueryItem(name: "apikey", value: "THISISALIVEDEMOAPIKEY19651D54X47")
    
}
