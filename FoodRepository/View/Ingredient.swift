//
//  Ingredient.swift
//  FoodRepository
//
//  Created by Lawrence on 10/12/23.
//

import SwiftUI

struct Ingredient: View {
    @State var icon: String = "💦"
    @State var ingredient: String
    @State var measure: String
    var body: some View {
        HStack {
            Rectangle()
                .fill(.white)
                .clipShape(.rect(cornerRadius: 10))
                .frame(width: 52, height: 52)
                .overlay(alignment: .center, content: {
                    Text(icon)
                        .font(.system(size: 28))
                })
                .padding(.leading, 16)
                .padding(.vertical, 12)
                
            Text(ingredient)
                .fontWeight(.semibold)
                .font(.system(size: 16))
                .foregroundStyle(.neutral90)
            Spacer()
            Text(measure)
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
    Ingredient(ingredient: "water", measure: "200g")
}
