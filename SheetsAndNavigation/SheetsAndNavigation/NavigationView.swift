//
//  NavigationView.swift
//  SheetsAndNavigation
//
//  Created by Gwinyai Nyatsoka on 23/1/2024.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        VStack {
            Text("Presented using navigation stack")
            NavigationLink {
                NavigationView()
            } label: {
                Text("Next View")
            }

        }
        .navigationTitle("NavigationView")
    }
}

#Preview {
    NavigationStack {
        NavigationView()
    }
}
