//
//  FoodRepositoryTests.swift
//  FoodRepositoryTests
//
//  Created by Lawrence on 10/9/23.
//

import XCTest
@testable import FoodRepository

struct MockWebServie: APIImplement {
    func fetchData<T>(request: Requestable, modelType: T.Type) async throws -> T? where T : Decodable {
        let nutrition = Metanutrition(fat: "", salt: "", fiber: "", energy: "", sodium: "", sugars: "", fat100G: "", fatUnit: "", proteins: "", fatValue: "", salt100G: "", saltUnit: "", fiber100G: "", fiberUnit: "", saltValue: "", energyKcal: "", energy100G: "", energyUnit: "", fiberValue: "", sodium100G: "", sodiumUnit: "", sugars100G: "", sugarsUnit: "", energyValue: "", sodiumValue: "", sugarsValue: "", carbohydrates: "", proteins100G: "", proteinsUnit: "", saturatedFat: "", proteinsValue: "", energyKcal100G: "", energyKcalUnit: "", energyKcalValue: "", carbohydrates100G: "", carbohydratesUnit: "", saturatedFat100G: "", saturatedFatUnit: "", carbohydratesValue: "", saturatedFatValue: "")
        let mockBarcodeData = Barcode(addedTime: "", modifiedTime: "", title: "", description: "", brand: "", manufacturer: "", msrp: "", category: "", categories: "", stores: "", barcode: "", success: true, timestamp: 0, images: "", metanutrition: nutrition)
        return (mockBarcodeData as! T)
    }
}

final class FoodRepositoryTests: XCTestCase {
    @MainActor
    let foodListViewModel = FoodListViewModel(webService: MockWebServie())
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor 
    func testFetchFoodList() {
        Task {
            do {
                try foodListViewModel.fetchFoodList()
                
                guard let actualOutput = foodListViewModel.foodList?.count else { return }
                let expectedOutput = try await CoreDataManager.shared.getFoods().count
                XCTAssertEqual(actualOutput, expectedOutput)
            } catch {
                
            }
        }
    }
    
    @MainActor
    func testAddNewFood() {
        Task {
            do {
                foodListViewModel.foodList = []
                foodListViewModel.name = "TestOriginal"
                foodListViewModel.expirationDate = Date.now
                foodListViewModel.quantity = "10"
                foodListViewModel.unit = "tps"
                foodListViewModel.barcode = "1234"
                let originalListCount = foodListViewModel.foodList!.count
                try foodListViewModel.addNewFood()
                let expectedOutput = originalListCount + 1
                let actualOutput = foodListViewModel.foodList!.count
                XCTAssertEqual(actualOutput, expectedOutput)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func testDeleteFoodItem() {
        Task {
            do {
                foodListViewModel.foodList = []
                let food = FoodCoreData(id: UUID(),
                                        barcode: "1234",
                                        name: "TestOriginal",
                                        expirationDate: Date.now,
                                        purchasedDate: Date.now,
                                        quantity: 10,
                                        unit: "tps")
                foodListViewModel.foodList?.append(food)
                try await CoreDataManager.shared.addFood(food: food)
                let originalOutput = foodListViewModel.foodList!.count
                try foodListViewModel.deleteFoodItem(food: food)
                let actualOutput = foodListViewModel.foodList!.count
                let expectOutput = originalOutput - 1
                XCTAssertEqual(actualOutput, expectOutput)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    func testEditFoodItem() {
        Task {
            do {
                foodListViewModel.foodList = []
                var food = FoodCoreData(id: UUID(),
                                        barcode: "1234",
                                        name: "TestOriginal",
                                        expirationDate: Date.now,
                                        purchasedDate: Date.now,
                                        quantity: 10,
                                        unit: "tps")
                foodListViewModel.foodList?.append(food)
                try await CoreDataManager.shared.addFood(food: food)
                food.name = "TestItem"
                foodListViewModel.foodItem = food
                try foodListViewModel.editFoodItem()
                let foodItems = try await CoreDataManager.shared.getFoods()
                let foodItem = foodItems.first(where: { $0.id == food.id })!
                XCTAssertEqual("TestItem", foodItem.name)
            } catch {
                
            }
        }
    }
}
