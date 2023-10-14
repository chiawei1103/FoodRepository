//
//  FoodCoreData.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import Foundation

struct FoodCoreData: Identifiable {
    let id: UUID?
    let barcode: String?
    let name: String?
    let expirationDate: Date?
    let purchasedDate: Date?
    let quantity: Int64
    let unit: String?
}

extension FoodCoreData {
    init(foodCoreData: FoodItems) {
        self.id = foodCoreData.id
        self.barcode = foodCoreData.barcode
        self.name = foodCoreData.name
        self.expirationDate = foodCoreData.expirationDate
        self.purchasedDate = foodCoreData.purchasedDate
        self.quantity = foodCoreData.quantity
        self.unit = foodCoreData.unit
    }
}
