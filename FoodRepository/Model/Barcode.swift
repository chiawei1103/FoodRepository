//
//  Barcode.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import Foundation

// MARK: - Barcode
struct Barcode: Decodable {
    let addedTime, modifiedTime, title: String
    let description, brand: String
    let manufacturer, msrp: String?
    let category, categories: String
    let stores: String?
    let barcode: String
    let success: Bool
    let timestamp: Int
    let images: String?
    let metanutrition: Metanutrition

//    enum CodingKeys: String, CodingKey {
//        case addedTime = "added_time"
//        case modifiedTime = "modified_time"
//        case title, description, brand, manufacturer, msrp
//        case category, categories, stores, barcode, success, timestamp, images, metanutrition
//    }
}

// MARK: - Metanutrition
struct Metanutrition: Decodable {
    let fat, salt, fiber, energy: String
    let sodium, sugars, fat100G, fatUnit: String
    let proteins, fatValue, salt100G, saltUnit: String
    let fiber100G, fiberUnit, saltValue, energyKcal: String
    let energy100G, energyUnit, fiberValue, sodium100G: String
    let sodiumUnit, sugars100G, sugarsUnit, energyValue: String
    let sodiumValue, sugarsValue, carbohydrates, proteins100G: String
    let proteinsUnit, saturatedFat, proteinsValue, energyKcal100G: String
    let energyKcalUnit, energyKcalValue, carbohydrates100G, carbohydratesUnit: String
    let saturatedFat100G, saturatedFatUnit, carbohydratesValue, saturatedFatValue: String

//    enum CodingKeys: String, CodingKey {
//        case fat, salt, fiber, energy, sodium, sugars
//        case fat100G = "fat_100g"
//        case fatUnit = "fat_unit"
//        case proteins
//        case fatValue = "fat_value"
//        case salt100G = "salt_100g"
//        case saltUnit = "salt_unit"
//        case fiber100G = "fiber_100g"
//        case fiberUnit = "fiber_unit"
//        case saltValue = "salt_value"
//        case energyKcal = "energy-kcal"
//        case energy100G = "energy_100g"
//        case energyUnit = "energy_unit"
//        case fiberValue = "fiber_value"
//        case sodium100G = "sodium_100g"
//        case sodiumUnit = "sodium_unit"
//        case sugars100G = "sugars_100g"
//        case sugarsUnit = "sugars_unit"
//        case energyValue = "energy_value"
//        case sodiumValue = "sodium_value"
//        case sugarsValue = "sugars_value"
//        case carbohydrates
//        case proteins100G = "proteins_100g"
//        case proteinsUnit = "proteins_unit"
//        case saturatedFat = "saturated-fat"
//        case proteinsValue = "proteins_value"
//        case energyKcal100G = "energy-kcal_100g"
//        case energyKcalUnit = "energy-kcal_unit"
//        case energyKcalValue = "energy-kcal_value"
//        case carbohydrates100G = "carbohydrates_100g"
//        case carbohydratesUnit = "carbohydrates_unit"
//        case saturatedFat100G = "saturated-fat_100g"
//        case saturatedFatUnit = "saturated-fat_unit"
//        case carbohydratesValue = "carbohydrates_value"
//        case saturatedFatValue = "saturated-fat_value"
//    }
}
