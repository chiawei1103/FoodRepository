//
//  FoodListView.swift
//  FoodRepository
//
//  Created by Lawrence on 10/9/23.
//

import SwiftUI

struct FoodListView: View {
    @State var isSheetPresented = false
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
                        isSheetPresented.toggle()
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
                    FoodItem()
                        .listRowSeparator(.hidden)
                        .listRowSpacing(6)
                    FoodItem()
                        .listRowSeparator(.hidden)
                        .listRowSpacing(6)
                    FoodItem()
                        .listRowSeparator(.hidden)
                        .listRowSpacing(6)
                    FoodItem()
                        .listRowSeparator(.hidden)
                        .listRowSpacing(6)
                    FoodItem()
                        .listRowSeparator(.hidden)
                        .listRowSpacing(6)
                    FoodItem()
                        .listRowSeparator(.hidden)
                        .listRowSpacing(6)
                    FoodItem()
                        .listRowSeparator(.hidden)
                        .listRowSpacing(6)
                }
                
                
                .listStyle(.plain)
            }
        }
        .sheet(isPresented: $isSheetPresented, content: {
            AddFood()
        })
    }
}

#Preview {
    FoodListView()
}


