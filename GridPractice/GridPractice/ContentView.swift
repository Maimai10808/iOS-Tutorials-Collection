//
//  ContentView.swift
//  GridPractice
//
//  Created by mac on 8/3/25.
//

import SwiftUI

// fixed
// flexible
// adaptive

struct ContentView: View {
    
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(0...50, id: \.self) { index in
                    Color.red
                        .frame(height: 50)
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
