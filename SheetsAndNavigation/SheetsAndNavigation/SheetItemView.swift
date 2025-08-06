//
//  SheetItemView.swift
//  SheetsAndNavigation
//
//  Created by Gwinyai Nyatsoka on 22/1/2024.
//

import SwiftUI

struct SheetItemView: View {
    
    let person: Person
    
    var body: some View {
        Text("The name of the person presented is \(person.name)")
    }
}

#Preview {
    SheetItemView(person: Person(name: "Paul"))
}
