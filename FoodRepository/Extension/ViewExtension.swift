//
//  ViewExtension.swift
//  FoodRepository
//
//  Created by Lawrence on 10/9/23.
//

import SwiftUI

extension View {
    func h3Style() -> some View {
        modifier(H3())
    }
}

struct H3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .font(.largeTitle)
    }
}
