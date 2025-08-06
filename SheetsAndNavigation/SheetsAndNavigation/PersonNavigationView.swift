//
//  PersonNavigationView.swift
//  SheetsAndNavigation
//
//  Created by Gwinyai Nyatsoka on 23/1/2024.
//

import SwiftUI

struct PersonNavigationView: View {
    
    let person: Person
    
    var body: some View {
        VStack {
            Text("The person's name is \(person.name)")
        }
    }
}

#Preview {
    PersonNavigationView(person: Person(name: "Paul"))
}
