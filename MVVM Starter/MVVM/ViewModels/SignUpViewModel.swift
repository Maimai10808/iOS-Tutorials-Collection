//
//  SignUpUsernameEmailViewModel.swift
//  MVVM
//
//  Created by Gwinyai Nyatsoka on 27/1/2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    @Published var showAlertInUsernameEmailView = false
    @Published var showAlertInPasswordView = false
    @Published var showNextPage = false
    @Published var confirmPassword = ""
    
    
    func handlePasswordViewAlert() {
        if password == confirmPassword {
            showNextPage = false
        }
    }
    
    func confirmSignup() {
        guard !password.isEmpty && !confirmPassword.isEmpty else {
            alertTitle = "Password Required"
            alertMessage = "Please provide a Password"
            showAlertInPasswordView = true
            return
        }
        
        if password == confirmPassword {
            alertTitle = "Success!"
            alertMessage = "Please check your email for the activation link."
        } else {
            alertTitle = "Password Mismatch!"
            alertMessage = "Please check passwords."
            password = ""
            confirmPassword = ""
        }
        showAlertInPasswordView = true
    }
    
    func validate() {
        guard validateEmail() && validateUsername() else { return }
        showNextPage = true
    }
    
    private func validateUsername() -> Bool {
        guard !username.isEmpty else {
            alertTitle = "Username Required"
            alertMessage = "Please provide a username"
            showAlertInUsernameEmailView = true
            return false
        }
        return true
    }
    
    private func validateEmail() -> Bool {
        guard !email.isEmpty else {
            alertTitle = "Email Required"
            alertMessage = "Please provide a email"
            showAlertInUsernameEmailView = true
            return false
        }
        return true
    }
    
}
