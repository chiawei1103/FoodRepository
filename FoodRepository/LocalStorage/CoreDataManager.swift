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
        let foodCoreData = Food(context: managedContext)
        
        foodCoreData.id = food.id
        foodCoreData.name = food.name
        foodCoreData.barcode = food.barcode
        foodCoreData.expirationDate = food.expirationDate
        foodCoreData.purchasedDate = food.puchasedDate
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
        let fetchRequest: NSFetchRequest<Food>
        fetchRequest = Food.fetchRequest()
        do {
            let objects = try self.managedContext.fetch(fetchRequest)
            if !objects.isEmpty {
                objects.forEach { food in
//                    result.append(food)
                }
            }
        } catch {
            
        }
        return result
    }
    
}
