//
//  SheetItemView.swift
//  SheetsandNavigationself
//
//  Created by mac on 7/26/25.
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
