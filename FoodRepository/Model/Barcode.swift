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
}
