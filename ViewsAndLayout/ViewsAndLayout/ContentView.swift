//
//  ContentView.swift
//  ViewsAndLayout
//
//  Created by mac on 5/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    @State var showAlert = false
    @State var showUsernameError = false
    @State var showemailError = false
    @State var showpasswordError = false
    
    
    var body: some View {
        ZStack {
            Color.primaryTheme
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                
                    Text("Sign Up")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(.white)
                    
                Text("Username")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                
                TextField("UserName", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                
                if showUsernameError {
                    Text("Username is required")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.red)
                }
                
                
                Text("Email")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                if showemailError {
                    Text("Email is required")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.red)
                }
                
                Text("Password")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                if showpasswordError {
                    Text("Password is required")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.red)
                }
                
                Button {
                    
                    showUsernameError = false
                    showemailError = false
                    showpasswordError = false
                    
                    guard !username.isEmpty else {
                        showUsernameError = true
                        return
                    }
                    
                    guard !email.isEmpty else {
                        showemailError = true
                        return
                    }
                    
                    guard !password.isEmpty else {
                        showpasswordError = true
                        return
                    }
                    
                    username = ""
                    email = ""
                    password = ""
                    
                    showAlert = true
                    
                } label: {
                    Text("Submit")
                        .foregroundStyle(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                }
                
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top)
                
                
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .alert("Sign Up Completed!", isPresented: $showAlert) {
            Button("OK", action: {
                showAlert = false
            })
        } message: {
            Text("Thanks for signing up!")
        }
        
        
    }
}

#Preview {
    ContentView()
}
