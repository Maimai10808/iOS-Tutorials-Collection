//
//  FullScreenView.swift
//  SheetsAndNavigation
//
//  Created by Gwinyai Nyatsoka on 23/1/2024.
//

import SwiftUI

struct FullScreenView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                })
            }
            Spacer()
            Text("This takes up the entire screen!")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    FullScreenView()
}
