//
//  ContentView.swift
//  SheetsAndNavigation
//
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet = false
    @State private var showPresentationDetent = false
    @State private var presentFullScreen = false
    @State private var presentViewOnNavigationStack = false
    @State private var sheetPerson: Person?
    @State private var navigationPerson: Person?
    @State private var showSettingsView = false
    
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
                    sheetPerson = Person(name: "Paul")
                }, label: {
                    Text("Sheet Presented with Item")
                })
                Divider()
                Button(action: {
                    showPresentationDetent = true
                }, label: {
                    Text("Sheet Presented As Detent")
                })
                Divider()
                Button(action: {
                    presentFullScreen = true
                }, label: {
                    Text("Full Screen")
                })
                Divider()
                NavigationLink {
                    NavigationView()
                } label: {
                    Text("Navigation Link")
                }
                Divider()
                Button(action: {
                    presentViewOnNavigationStack = true
                }, label: {
                    Text("Navigation Destination with Boolean")
                })
                Divider()
                Button(action: {
                    navigationPerson = Person(name: "Paul")
                }, label: {
                    Text("Navigation Destination with Item")
                })
                Divider()
                NavigationLink(value: Person(name: "Bill")) {
                    Text("Navigation Destination with Hashable Value")
                }
                Spacer()
            }
            .navigationTitle("Presentation")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "person.fill")
                    })
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "gearshape.fill")
                    })
                }
                ToolbarItemGroup(placement: .secondaryAction, content: {
                    Button(action: {
                        
                    }, label: {
                        Text("Logout")
                    })
                })
            }
            .padding(.horizontal)
            .padding(.top, 40)
            .sheet(isPresented: $showSheet, content: {
                SheetView(showSheet: $showSheet)
            })
            .sheet(item: $sheetPerson) { person in
                SheetItemView(person: person)
            }
            .sheet(isPresented: $showPresentationDetent, content: {
                PresentationDetentView()
                    .presentationDetents([.medium, .large])
            })
            .fullScreenCover(isPresented: $presentFullScreen, content: {
                FullScreenView()
            })
            .navigationDestination(isPresented: $presentViewOnNavigationStack) {
                NavigationView()
            }
            .navigationDestination(item: $navigationPerson) { person in
                PersonNavigationView(person: person)
            }
            .navigationDestination(for: Person.self) { person in
                PersonNavigationView(person: person)
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
    }
}

#Preview {
    ContentView()
}
