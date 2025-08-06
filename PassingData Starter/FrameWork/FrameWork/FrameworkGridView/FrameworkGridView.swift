//
//  FrameworkGridView.swift
//  FrameWork
//
//  Created by mac on 3/6/25.
//

import SwiftUI

struct FrameworkGridView: View {
    
    @StateObject var viewModel = FrameworkGridViewModel()
    
   
    
    
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(MockData.frameworks) { framework in NavigationLink(destination: FrameworkDetailView(framework: framework)) {
                        FrameworkTitleView(framework: framework)
                    }
                        
                            }
                        
                        
                
            }
                }
            .navigationTitle("APPLE 🤡")
            }
            
            .navigationDestination(for: Framework.self) {framework in FrameworkDetailView(framework: framework)}
        
            }
        }
        

#Preview {
    FrameworkGridView()
        .preferredColorScheme(.dark)
}




