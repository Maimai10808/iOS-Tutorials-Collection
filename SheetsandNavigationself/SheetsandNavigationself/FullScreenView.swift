//
//  FullScreenView.swift
//  SheetsandNavigationself
//
//  Created by mac on 7/26/25.
//

import SwiftUI

struct FullScreenView: View {
    
    @Binding var showFullScreen: Bool
    
    var body: some View {
        VStack {
            
            Button(action: {
                showFullScreen = false
            }, label: {
                Image(systemName: "xmark")
            })
            Text("This takes up the entire screen!!!")
        }
    }
}

#Preview {
    FullScreenView(showFullScreen: .constant(true))
}
