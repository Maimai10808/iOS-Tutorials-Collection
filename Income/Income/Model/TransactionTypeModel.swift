//
//  TransactionTypeModel.swift
//  Income
//
//  Created by mac on 7/29/25.
//

import Foundation



enum TransactionType: Int, CaseIterable, Identifiable {
    case income
    
    case expense
    
    var id: Self { self }
    
    var title: String {
        
        switch self {
        case .income:
            return "Income"
        
            
        case .expense:
            return "Expense"
            
                
                    }
        }
}
