//
//  F0lderView.swift
//  MyNotes
//
//  Created by mac on 3/7/25.
//

import SwiftUI

struct FolderView: View {
    
    var folderName = "Folder Name"
    var notes = testNotes
    
    var body: some View {
        
        List {
            
            ForEach(notes) { note in Text(note.title)
                
            }
        }
        .navigationTitle(folderName)
        .listStyle(InsetGroupedListStyle())
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Text("\(notes.count)" + "Note")
                Image(systemName: "square.and.pencil")
            }
        }
            }
       
    }

#Preview {
    FolderView()
}
