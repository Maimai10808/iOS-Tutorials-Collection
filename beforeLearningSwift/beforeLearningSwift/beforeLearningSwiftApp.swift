//
//  beforeLearningSwiftApp.swift
//  beforeLearningSwift
//
//  Created by mac on 3/2/25.
//

import SwiftUI

@main
struct beforeLearningSwiftApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: beforeLearningSwiftDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
