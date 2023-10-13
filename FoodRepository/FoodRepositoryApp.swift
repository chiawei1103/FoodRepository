//
//  FoodRepositoryApp.swift
//  FoodRepository
//
//  Created by Lawrence on 10/9/23.
//

import SwiftUI

@main
struct FoodRepositoryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
