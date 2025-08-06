//
//  Excercise.swift
//  ViewBuilderPractice
//
//  Created by mac on 8/4/25.
//

import Foundation

struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let reps: Int
    let weight: Int
}
