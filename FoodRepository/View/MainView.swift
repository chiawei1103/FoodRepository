//
//  MainView.swift
//  FoodRepository
//
//  Created by Lawrence on 10/9/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            FoodListView()
                .tabItem {
                    Label(
                        title: { Text("Food") },
                        icon: { Image(systemName: "refrigerator") }
                    )
                }
            RecipeSearchView()
                .tabItem {
                    Label(
                        title: { Text("Recipe") },
                        icon: { Image(systemName: "fork.knife") }
                    )
                }
        }
    }
}

#Preview {
    MainView()
}
