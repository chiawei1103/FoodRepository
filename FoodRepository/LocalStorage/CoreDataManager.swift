//
//  CoreDataManager.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container = NSPersistentContainer(name: "FoodRepository")
    lazy var managedContext: NSManagedObjectContext = self.container.viewContext
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            print("Core Data Description: \(description)")
        }
    }
    
    func addFood(food: FoodCoreData) async throws {
        let foodCoreData = FoodItems(context: managedContext)
        
        foodCoreData.id = food.id
        foodCoreData.name = food.name
        foodCoreData.barcode = food.barcode
        foodCoreData.expirationDate = food.expirationDate
        foodCoreData.purchasedDate = food.purchasedDate
        foodCoreData.quantity = food.quantity
        foodCoreData.unit = food.unit
        do {
            try managedContext.save()
            print("food item created")
        } catch {
            fatalError("Unable to create food item in Core Data: \(error.localizedDescription) ")
        }
    }
    
    func getFoods() async throws -> [FoodCoreData] {
        var result = [FoodCoreData]()
        let fetchRequest: NSFetchRequest<FoodItems> = FoodItems.fetchRequest()
        do {
            let objects = try self.managedContext.fetch(fetchRequest)
            if !objects.isEmpty {
                objects.forEach { food in
                    result.append(FoodCoreData(foodCoreData: food))
                }
            }
        } catch {
            fatalError("Unable to get food items from Core Data: \(error.localizedDescription)")
        }
        return result
    }
    
    func deleteFood(id: UUID) async throws {
        let fetchRequest: NSFetchRequest<FoodItems> = FoodItems.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
        do {
            let matchingEntities = try managedContext.fetch(fetchRequest)
            for foodItem in matchingEntities {
                managedContext.delete(foodItem)
            }
            try managedContext.save()
            print("Food Items with id: \(id) are deleted")
        } catch {
            fatalError("Error deleting food items: \(error.localizedDescription)")
        }
    }
    
    func editFoodItem(food: FoodCoreData) async throws {
        let fetchRequest: NSFetchRequest<FoodItems> = FoodItems.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == \(food.id ?? UUID())")
        do {
            let matchingFoodItems = try managedContext.fetch(fetchRequest)
            guard let foodItem = matchingFoodItems.first else { return }
            foodItem.name = food.name
            foodItem.expirationDate = food.expirationDate
            foodItem.quantity = food.quantity
            foodItem.unit = food.unit
            
            try managedContext.save()
            print("Food Item with name: \(food.name ?? "") is deleted")
        } catch {
            fatalError("Error editing food item: \(error.localizedDescription)")
        }
    }
    
}
