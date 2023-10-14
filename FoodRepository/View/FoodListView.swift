//
//  FoodListView.swift
//  FoodRepository
//
//  Created by Lawrence on 10/9/23.
//

import SwiftUI

struct FoodListView: View {
    @StateObject var viewModel = FoodListViewModel()
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Food")
                        .h3Style()
                        .foregroundStyle(.neutral90)
                    Text("Repository")
                        .h3Style()
                        .foregroundStyle(.neutral90)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack {
                    Button(action: {
                        print("add new food")
                        viewModel.isSheetPresented.toggle()
                    }, label: {
                        HStack(alignment: .center, spacing: 9) {
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundStyle(.white)
                            Text("Add new food")
                                .fontWeight(.semibold)
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        .frame(height: 28)
                        .padding(.horizontal, 9)
                        .padding(.vertical, 6)
                        .background(.primary50)
                        .clipShape(.rect(cornerRadius: 12))
                    })
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 22)
            .padding(.top, 20)
            .padding(.bottom, 0)
            
            NavigationStack {
                List {
                    if let foodList = viewModel.foodList {
                        ForEach(foodList) { food in
                            FoodItem(foodItem: food)
                                .listRowSeparator(.hidden)
                                .listRowSpacing(6)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        try? viewModel.deleteFoodItem(food: food)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    
                    
                    //                    FoodItem()
                    //                        .listRowSeparator(.hidden)
                    //                        .listRowSpacing(6)
                    //                    FoodItem()
                    //                        .listRowSeparator(.hidden)
                    //                        .listRowSpacing(6)
                    //                    FoodItem()
                    //                        .listRowSeparator(.hidden)
                    //                        .listRowSpacing(6)
                    //                    FoodItem()
                    //                        .listRowSeparator(.hidden)
                    //                        .listRowSpacing(6)
                    //                    FoodItem()
                    //                        .listRowSeparator(.hidden)
                    //                        .listRowSpacing(6)
                    //                    FoodItem()
                    //                        .listRowSeparator(.hidden)
                    //                        .listRowSpacing(6)
                }
                
                
                .listStyle(.plain)
            }
        }
        .onAppear {
            try? viewModel.fetchFoodList()
        }
        .sheet(isPresented: $viewModel.isSheetPresented, content: {
            AddFood(foodListViewModel: viewModel)
        })
    }
}

#Preview {
    FoodListView()
}


