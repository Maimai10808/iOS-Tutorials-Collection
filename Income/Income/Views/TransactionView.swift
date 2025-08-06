//
//  TransactionView.swift
//  Income
//
//  Created by mac on 7/29/25.
//

import SwiftUI

struct TransactionView: View {
    let transaction: TransactionItem
    @AppStorage("currency") var currency: Currency = .usd
    
    private func formatAmount(_ amount: Double, currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00"
    }
    
    
    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Text(transaction.wrappedDate, style: .date)
                    .font(.system(size: 14))
                
                Spacer()
                
            }
            .padding(.vertical, 5)
            .background(Color.lightGrayShade.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            HStack {
                Image(systemName: transaction.wrappedType == .income ?
                      "arrow.up.forward" :
                        "arrow.down.forward")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(transaction.wrappedType == .income ?
                                 Color.green :
                                    Color.red)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    HStack {
                        Text(transaction.wrappedTitle)
                            .font(.system(size: 15, weight: .bold))
                        Spacer()
                        Text(formatAmount(transaction.wrappedAmount, currency: currency))
                            .font(.system(size: 15, weight: .bold))
                    }
                    Text("Completed")
                        .font(.system(size: 14))
                    
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}


