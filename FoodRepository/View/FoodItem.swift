//
//  FoodItem.swift
//  FoodRepository
//
//  Created by Lawrence on 10/10/23.
//

import SwiftUI

struct FoodItem: View {
    @State var foodItem: FoodCoreData
    @State var thumbnail = "🍞"
    var body: some View {
        HStack {
            Rectangle()
                .fill(.white)
                .clipShape(.rect(cornerRadius: 10))
                .frame(width: 52, height: 52)
                .overlay(alignment: .center, content: {
                    Text(thumbnail)
                        .font(.system(size: 28))
                })
                .padding(.leading, 16)
                .padding(.vertical, 12)
                
            Text(foodItem.name ?? "")
                .fontWeight(.semibold)
                .font(.system(size: 16))
                .foregroundStyle(.neutral90)
            Spacer()
            
            VStack {
                HStack {
                    Text("Exp")
                    Text(":")
                    Text("\(foodItem.expirationDate?.formatted(.dateTime.day(.twoDigits).month(.twoDigits)) ?? "")")
                }
                
                HStack {
                    Text("Qty")
                    Text(":")
                    Text("\(foodItem.quantity) " + "\(foodItem.unit ?? "")")
                }
            }
            .foregroundStyle(.neutral40)
            .padding(.trailing, 16)
            
            
        }
        .background {
            Color.neutral10
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    FoodItem(foodItem: FoodCoreData(id: nil, barcode: nil, name: "Bread", expirationDate: nil, purchasedDate: nil, quantity: 200, unit: "g"))
}
