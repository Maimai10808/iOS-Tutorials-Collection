//
//  LetterView.swift
//  ScrambledWords
//
//  Created by mac on 7/25/25.
//

import SwiftUI


struct LetterView: View {
    
    @State var letter: Letter
    var body: some View {
        Text(letter.text)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.white)
                .frame(width: 30, height: 30)
                .background(Color.white.opacity(0.4))
                .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}


