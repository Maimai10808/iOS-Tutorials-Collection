//
//  AddTransactionView.swift
//  Income
//
//  Created by mac on 7/30/25.
//

import SwiftUI
import CoreData

struct AddTransactionView: View {
    
    @State private var amount = 0.0
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    
    var transactionToEdit: TransactionItem?
    
    @AppStorage("currency") var currency: Currency = .usd
    
    @State private var alertTitle   = ""
    @State private var alertMessage = ""
    @State private var showaAlert   = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Rectangle()
                .fill(Color(uiColor: UIColor.lightGray))
                .frame(height: 0.5)
                .padding(.horizontal, 30)
            
            
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            
            TextField("title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button(action: {
                
                guard transactionTitle.count >= 2 else {
                    alertTitle   = "Invaild Title"
                    alertMessage = "Title must be 2 or more characters long."
                    showaAlert   = true
                    return
                }
                
               
                // 获取transactionToEdit在transactions中的位置，以便更新或替换。
//                let index = transactions.firstIndex { transaction in
//                    self.transactionToEdit?.id == transaction.id
//                }
                
                if let transactionToEdit = transactionToEdit {
                    // 更新现有的交易
                    transactionToEdit.title = transactionTitle
                    transactionToEdit.type = Int16(selectedTransactionType.rawValue)
                    transactionToEdit.amount = amount
                    
                    do {
                        try viewContext.save()
                    } catch {
                        alertTitle   = "Something went wrong"
                        alertMessage = "Can't update this transaction right now."
                        showaAlert   = true
                        return
                    }
                    
                } else {
                    
                    let transaction        = TransactionItem(context: viewContext)
                    
                        transaction.id     = UUID()
                        transaction.title  = transactionTitle
                        transaction.type   = Int16(selectedTransactionType.rawValue)
                        transaction.amount = amount
                        transaction.date   = Date()
                    
                    do {
                        
                        try viewContext.save()
                        
                    } catch {
                        alertTitle   = "Something went wrong"
                        alertMessage = "Can't update this transaction right now."
                        showaAlert   = true
                    }
                  
//                    transactions.append(trans action)
                }
                
                dismiss()
                
            }, label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            })
            .padding(.top)
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                selectedTransactionType = transactionToEdit.wrappedType
                transactionTitle        = transactionToEdit.wrappedTitle
                amount                  = transactionToEdit.wrappedAmount
            }
            
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showaAlert) {
            Button {
                
                
            } label: {
                Text("OK")
            }
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    AddTransactionView()
}
