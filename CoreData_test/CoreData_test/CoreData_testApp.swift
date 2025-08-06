//
//  CoreData_testApp.swift
//  CoreData_test
//
//  Created by mac on 3/16/25.
//

import SwiftUI

@main
struct CoreData_testApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
