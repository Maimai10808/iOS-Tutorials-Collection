//
//  ContentView.swift
//  ListScrollViews
//
//  Created by mac on 7/27/25.
//

import SwiftUI

struct ExampleListView: View {
    
    @State private var shoppingItems: [ShoppingModel] = [
            ShoppingModel(title: "Apple AirPods Pro", price: "$249"),
            ShoppingModel(title: "Nike Running Shoes", price: "$129"),
            ShoppingModel(title: "Samsung Galaxy Watch", price: "$199"),
            ShoppingModel(title: "Sony WH-1000XM5 Headphones", price: "$349"),
            ShoppingModel(title: "MacBook Air M2", price: "$999")
    ]
    
    var body: some View {
        VStack {
            
            List {
                
                ForEach(shoppingItems) { shoppingItem in
                    HStack {
                            Text(shoppingItem.title)
                            Spacer()
                            Text(shoppingItem.price)
                                    }
                }
                Text("ShoppingItems")
                
                ForEach(shoppingItems) { shoppingItem in
                    HStack {
                            Text(shoppingItem.title)
                            Spacer()
                            Text(shoppingItem.price)
                                    }
                }
                
            }
            
            
//            List(shoppingItems) { shoppingItem in
//                HStack {
//                    Text(shoppingItem.title)
//                    Spacer()
//                    Text(shoppingItem.price)
//                }
//            }
        }
    }
}

#Preview {
    ExampleListView()
}
