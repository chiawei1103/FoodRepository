//
//  FoodCoreData.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import Foundation

struct FoodCoreData: Identifiable, Hashable {
    var id: UUID?
    var barcode: String?
    var name: String?
    var expirationDate: Date?
    var purchasedDate: Date?
    var quantity: Int64
    var unit: String?
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
