//
//  NoteView.swift
//  MyNotes
//
//  Created by mac on 3/7/25.
//

import SwiftUI

struct NoteView: View {
    @State var title = ""
    @State var noteText = ""
    
    var body: some View {
        
        TextEditor(text: $noteText)
        
    }
}

#Preview {
    NoteView()
}
