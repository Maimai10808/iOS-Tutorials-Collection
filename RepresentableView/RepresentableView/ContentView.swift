//
//  ContentView.swift
//  RepresentableView
//
//  Created by mac on 8/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var value = ""
    
    
    var body: some View {
        VStack {
            
            Text(value)
            PracticetextField(value: $value)
            TextField("", text: $value)
                .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    ContentView()
}
