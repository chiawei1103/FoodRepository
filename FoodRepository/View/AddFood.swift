//
//  AddFood.swift
//  FoodRepository
//
//  Created by Lawrence on 10/13/23.
//

import SwiftUI

struct AddFood: View {
    @ObservedObject var foodListViewModel: FoodListViewModel
    @State var name: String = ""
    @State var expirationDate = ""
    @State var quantity: String = ""
    @State var unit: String = ""
    @State var barcode: String = ""
    var body: some View {
        VStack(spacing: 20) {
            HStack(alignment: .top) {
                Text("Add New Food")
                    .fontWeight(.semibold)
                    .font(.system(size: 24))
                    .foregroundStyle(.neutral90)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
                
                Button(action: {
                    print("scanning barcode")
                }, label: {
                    Image(systemName: "barcode.viewfinder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.primary50)
                        .background {
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                                .shadow(
                                    color: Color(red: 0.13, green: 0.13, blue: 0.13)
                                        .opacity(0.15),
                                    radius: 12.5,
                                    x: 0,
                                    y: 8)
                        }
                })
            }
            
            AddFoodTextField(inputText: $foodListViewModel.name, promptText: "Food name")
            
            AddFoodTextField(inputText: $expirationDate, promptText: "Expiration Date")
            
            //            DatePicker(selection: $expirationDate, displayedComponents: .date) {
            //                Text("Expiration Date")
            //            }
            
            HStack(spacing: 12){
                AddFoodTextField(inputText: $foodListViewModel.quantity, promptText: "Quantity")
                AddFoodTextField(inputText: $foodListViewModel.unit, promptText: "Unit")
            }
            
            Spacer()
            
            Button(action: {
                print("Save")
                //                let food = FoodCoreData(id: UUID(),
                //                                        barcode: barcode, name: name, expirationDate: Date.now, purchasedDate: Date.now, quantity: Int64(quantity) ?? 0, unit: unit)
                do {
                    if foodListViewModel.foodItem != nil {
                        try foodListViewModel.editFoodItem()
                    } else {
                        try foodListViewModel.addNewFood()
                    }
                    
                    foodListViewModel.isSheetPresented.toggle()
                } catch {
                    print(error)
                }
            }, label: {
                Text("Save")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity)
            })
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.primary50)
            }
        }
        .padding(.top, 30)
        .padding(.bottom, 10)
        .padding(.horizontal, 20)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    AddFood(foodListViewModel: FoodListViewModel())
}

struct AddFoodTextField: View {
    @Binding var inputText: String
    @State var promptText: String
    var body: some View {
        TextField("",
                  text: $inputText,
                  prompt:
                    Text(promptText)
            .foregroundStyle(.neutral30)
        )
        .fontWeight(.regular)
        .foregroundStyle(.neutral90)
        .font(.system(size: 16))
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.neutral20, lineWidth: 1)
                .frame(height: 44)
        }
    }
}
