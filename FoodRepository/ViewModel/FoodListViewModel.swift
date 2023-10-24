//
//  FoodListViewModel.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import Foundation

@MainActor
protocol BarcodeLookUpDelegate {
    func barcodeLookup(barcode: String)
}

@MainActor
class FoodListViewModel: ObservableObject, BarcodeLookUpDelegate {
    @Published var viewState = ViewState.loading
    @Published var foodList: [FoodCoreData] = []
    @Published var isSheetPresented = false
    @Published var isEditing = false
    
    @Published var foodItem: FoodCoreData?
    @Published var name: String = ""
    @Published var expirationDate = Date()
    @Published var quantity: String = ""
    @Published var unit: String = ""
    @Published var barcode: String = ""
    
    let webService: APIImplement
    init(webService: APIImplement) {
        self.webService = webService
    }
    
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
                                        expirationDate: expirationDate,
                                        purchasedDate: Date.now,
                                        quantity: Int64(quantity) ?? 0,
                                        unit: unit)
                foodList.append(food)
                try await CoreDataManager.shared.addFood(food: food)
            } catch {
                print(error)
            }
        }
    }
    
    func deleteFoodItem(food: FoodCoreData) throws {
        Task {
            do {
                try await CoreDataManager.shared.deleteFood(id: food.id ?? UUID())
                foodList.removeAll(where: { $0.id == food.id })
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
                    food.expirationDate = self.expirationDate
                    try await CoreDataManager.shared.editFoodItem(food: food)
                    try fetchFoodList()
                    self.foodItem = nil
                }
            } catch {
                print(error)
            }
        }
    }
    
    func barcodeLookup(barcode: String) {
        print("barcode: \(barcode)")
        Task {
            let networkRequest = NetworkRequest(baseUrl: Constants.baseBarcodeUrl, path: "", params: [Constants.apiKey], type: .GET, headers: [:])
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: Barcode.self)
                
                if let result = result {
                    if result.category == "Food" {
                        self.name = result.title
                        self.barcode = result.barcode
                        self.viewState = .loaded
                    } else {
                        self.viewState = .error
                    }
                } else {
                    self.viewState = .error
                }
            } catch {
                print(error)
                print(error.localizedDescription)
                self.viewState = .error
            }
        }
    }
}
