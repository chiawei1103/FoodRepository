//
//  FoodListViewModel.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import Foundation

@MainActor
class FoodListViewModel: ObservableObject {
    @Published var foodList: [FoodCoreData]?
    @Published var isSheetPresented = false
    @Published var isEditing = false
    
    @Published var foodItem: FoodCoreData?
    @Published var name: String = ""
    @Published var expirationDate = ""
    @Published var quantity: String = ""
    @Published var unit: String = ""
    @Published var barcode: String = ""
    
    func fetchFoodList() throws {
        Task {
            do {
                self.foodList = try await CoreDataManager.shared.getFoods()
            } catch {
                print("Fetch Food List Failed: \(error.localizedDescription)")
            }
        }
    }
    
    func addNewFood() throws {
        Task {
            do {
                let food = FoodCoreData(id: UUID(),
                                        barcode: barcode,
                                        name: name,
                                        expirationDate: Date.now,
                                        purchasedDate: Date.now,
                                        quantity: Int64(quantity) ?? 0,
                                        unit: unit)
                try await CoreDataManager.shared.addFood(food: food)
                foodList?.append(food)
            } catch {
                print(error)
            }
        }
    }
    
    func deleteFoodItem(food: FoodCoreData) throws {
        Task {
            do {
                try await CoreDataManager.shared.deleteFood(id: food.id ?? UUID())
                foodList?.removeAll(where: { $0.id == food.id })
            } catch {
                print(error)
            }
        }
    }
    
    func editFoodItem() throws {
        Task {
            do {
                if var food = self.foodItem {
                    food.name = self.name
                    food.quantity = Int64(self.quantity) ?? 0
                    food.unit = self.unit
                    food.expirationDate = Date.now      //self.expirationDate
                    try await CoreDataManager.shared.editFoodItem(food: food)
                    try fetchFoodList()
//                    if let foodItemIndex = foodList?.firstIndex(where: { $0.id == food.id}) {
//                        foodList?.remove(at: foodItemIndex)
//                        foodList?.append(food)
//                        print(foodList)
//                    }
                }
            } catch {
                print(error)
            }
            
        }
    }
}
