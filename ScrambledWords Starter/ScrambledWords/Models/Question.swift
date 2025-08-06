//
//  Question.swift
//  ScrambledWords
//
//  Created by mac on 7/25/25.
//

import Foundation

struct Question {
    let image: String
    var scrambledletters: [Letter]
    let Answer: String
}


// MARK: Generates Questions
extension Question {
    
    static func generateQuestion() -> [Question] {
        return [
            Question(image: "orange", scrambledletters: [
                Letter(id: 0, text: "A"),
                Letter(id: 1, text: "O"),
                Letter(id: 2, text: "E"),
                Letter(id: 3, text: "R"),
                Letter(id: 4, text: "N"),
                Letter(id: 5, text: "G")
            ], Answer: "ORANGE"),
            Question(image: "banana", scrambledletters: [
                Letter(id: 0, text: "A"),
                Letter(id: 1, text: "A"),
                Letter(id: 2, text: "N"),
                Letter(id: 3, text: "B"),
                Letter(id: 4, text: "N"),
                Letter(id: 5, text: "A")
            ], Answer: "BANANA"),
            Question(image: "apple", scrambledletters: [
                Letter(id: 0, text: "A"),
                Letter(id: 1, text: "L"),
                Letter(id: 2, text: "E"),
                Letter(id: 3, text: "P"),
                Letter(id: 4, text: "P")
            ], Answer: "APPLE")
            
        ]
    }
}
