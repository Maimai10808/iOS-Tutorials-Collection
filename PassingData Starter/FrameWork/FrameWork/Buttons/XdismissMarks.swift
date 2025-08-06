//
//  XdismissMarks.swift
//  FrameWork
//
//  Created by mac on 3/6/25.
//

import SwiftUI

struct XdismissMarks: View {
    
    @Binding var isShowingDetailView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                isShowingDetailView = false
                
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color(.label))
                    .imageScale(.large)
                    .frame(width: 44,height: 44)
            }
        }
        .padding()
    }
}

struct XdismissMarks_Previews: PreviewProvider {
    static var previews: some View {
        XdismissMarks(isShowingDetailView: .constant(false))
    }
}
