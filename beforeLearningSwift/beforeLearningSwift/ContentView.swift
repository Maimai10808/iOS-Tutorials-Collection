//
//  ContentView.swift
//  beforeLearningSwift
//
//  Created by mac on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: beforeLearningSwiftDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(beforeLearningSwiftDocument()))
}
