//
//  FoodCoreData.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import Foundation

struct FoodCoreData {
    let id: UUID
    let barcode: String
    let name: String
    let expirationDate: Date
    let puchasedDate: Date
    let quantity: Int64
    let unit: String
}
