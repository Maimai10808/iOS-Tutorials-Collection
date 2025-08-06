//
//  FrameworkGridViewModel.swift
//  FrameWork
//
//  Created by mac on 3/6/25.
//

import SwiftUI

final class FrameworkGridViewModel: ObservableObject {
    
    var selectedFramework: Framework? {
        didSet {
            isShowingDetailView = true
        }
    }
 

    @Published var isShowingDetailView = false
    
    let columns: [GridItem] = [
        
        GridItem(.flexible()),
                               
        GridItem(.flexible()),
        
        GridItem(.flexible())
    ]
}


