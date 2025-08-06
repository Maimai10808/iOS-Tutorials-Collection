//
//  SheetView.swift
//  SheetsandNavigationself
//
//  Created by mac on 7/26/25.
//

import SwiftUI

struct SheetView: View {
    
    @Binding var showSheet: Bool
    var body: some View {
       Button(action: {
           showSheet = false
       }, label: {
           Text("Tap To Dismiss")
       })
    }
}

#Preview {
    SheetView(showSheet: .constant(true))
}
