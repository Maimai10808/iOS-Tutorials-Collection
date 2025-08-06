//
//  ContentView.swift
//  SheetsandNavigationself
//
//  Created by mac on 7/26/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet = false
    @State private var showPresentationDetent = false
    @State private var presentFullScreen = false
    @State private var person: Person?
    @State private var navigationPerson: Person?
    
    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading) {
                Button(action: {
                    showSheet = true
                }, label: {
                    Text("Sheet Presented with Boolean")
                })
                
                Divider()
                
                Button(action: {
                    person = Person(name: "Paul")
                }, label: {
                    Text("Sheet Presented with Item")
                })
                
                Divider()
                
                Button(action: {
                    showPresentationDetent = true
                }, label: {
                    Text("Sheet Presented with PresentationDetent")
                })
                
                Divider()
                
                Button(action: {
                    presentFullScreen = true
                }, label: {
                    Text("Sheet Presented with PresentFullScreen")
                })
                
                Divider()
                
                NavigationLink {
                    NavigationView()
                } label: {
                    Text("NavigationView")
                }
                
                Divider()
                
                Button("Navigation Destination with item") {
                            navigationPerson = Person(name: "Alice")
                        }
                
                Divider()
                
                NavigationLink(value: Person(name: "Bill")) {
                                   Text("Go to Bill")
                               }

                NavigationLink(value: Person(name: "Laura")) {
                                   Text("Go to Laura")
                               }
                
                Divider()
                
                
                
                
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 40)
            .fullScreenCover(isPresented: $presentFullScreen, content: {
                FullScreenView(showFullScreen: $presentFullScreen)
            })
            .sheet(isPresented: $showSheet, content: {
                SheetView(showSheet: $showSheet)
            })
            .sheet(item: $person) { person in
                SheetItemView(person: person)
            }
            .sheet(isPresented: $showPresentationDetent, content: {
                PresentationDetentView()
                    .presentationDetents([.height(250)])
                //.presentationDetents([.fraction(0.4)])
                //.presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            })
            .navigationDestination(item: $navigationPerson) { person in
                    PersonNavigationView(person: person)
                }
            
            .navigationDestination(for: Person.self) { person in
                            PersonNavigationView(person: person)
                        }
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
