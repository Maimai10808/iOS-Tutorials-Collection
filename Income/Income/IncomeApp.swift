//
//  IncomeApp.swift
//  Income
//
//  Created by mac on 7/27/25.
//

import SwiftUI
import CoreData

@main
struct IncomeApp: App {
    
    let dataManager = DataManager.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, dataManager.container.viewContext)
        }
    }
}
