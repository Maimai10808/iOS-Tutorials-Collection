//
//  PersonNavigationView.swift
//  SheetsandNavigationself
//
//  Created by mac on 7/26/25.
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
