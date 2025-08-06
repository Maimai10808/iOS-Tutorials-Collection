//
//  SheetView.swift
//  SheetsAndNavigation
//
//  Created by Gwinyai Nyatsoka on 22/1/2024.
//

import SwiftUI

struct SheetView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var showSheet: Bool
    
    var body: some View {
        Text("Brand new view shown as a sheet!")
        Button(action: {
            dismiss()
        }, label: {
            Text("Dismiss With @Environment dismiss")
        })
        Button(action: {
            showSheet = false
        }, label: {
            Text("Dismiss with Binding")
        })
    }
}

#Preview {
    SheetView(showSheet: .constant(true))
}
