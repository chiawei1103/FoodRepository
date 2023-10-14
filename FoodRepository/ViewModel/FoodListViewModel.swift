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
    
    func fetchFoodList() throws {
        Task {
            do {
                self.foodList = try await CoreDataManager.shared.getFoods()
            } catch {
                print("Fetch Food List Failed: \(error.localizedDescription)")
            }
        }
    }
    
    func addNewFood(food: FoodCoreData) throws {
        Task {
            do {
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
}
