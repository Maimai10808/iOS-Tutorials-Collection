//
//  MyNotes.swift
//  MyNotes
//
//  Created by mac on 3/7/25.
//

import Foundation

class MyNotes: ObservableObject {
    @Published var folders = [Folder]()
}

struct Folder: Identifiable {
    var id = UUID()
    
    var name: String
    var notes: [Note] = testNotes
    
}

struct Note: Identifiable {
    var id = UUID()
    
    var title: String
    var noteText: String = ""
}

var testFolders = [
    Folder(name: "Folder1"),
    Folder(name: "Folder2")
]

var testNotes = [
    Note(title: "Notes1"),
    Note(title: "Notes2"),
    Note(title: "Notes3"),
    Note(title: "Notes4"),
    Note(title: "Notes5"),
    
]
