//
//  CoreData_learingDEMOApp.swift
//  CoreData_learingDEMO
//
//  Created by mac on 3/18/25.
//

import SwiftUI

@main
struct CoreData_learingDEMOApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            UserListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
