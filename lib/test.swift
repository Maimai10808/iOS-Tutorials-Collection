//
//  CreateAccountViewController.swift
//  ChatApp
//
//  Created by Gwinyai Nyatsoka on 21/7/2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController {

    // ...view...

    @IBAction func createAccountButtonTapped(_ sender: Any) {

        guard let username = usernameTextField.text else {
            presentErrorAlert(title  : "Username Required",
                              message: "Please enter a username to continue.")
            return
        }

        guard username.count >= 1 && username.count <= 15 else {
            presentErrorAlert(title: "Invalid Username", message: "Username must be 1–15 characters long.")
            return
        }

        guard let email    = emailTextField   .text else{
            presentErrorAlert(title  : "Email Required",
                              message: "Please enter a Email to continue.")
            return
        }

        guard let password = passwordTextField.text else {
            presentErrorAlert(title  : "Password Required",
                              message: "Please enter a Password to continue.")
            return
        }

        showLoadingView()

        Database.database().reference().child("usernames").child(username).observeSingleEvent(of: .value) { snapshot in
                guard !snapshot.exists() else {
                    self.presentErrorAlert(title  : "Usename In Use",
                                            message: "Please enter a different name to continue.")
                    self.removeLoadingView()
                    return
                }

                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    self.removeLoadingView()
                    if let error = error {
                        print(error.localizedDescription)
                        var errorMessage = "Something went wrong. Please try again later."

                        let errorCode = (error as NSError).code

                        if let authError = AuthErrorCode(rawValue: errorCode) {
                            // 可以 switch 来区分错误类型了
                            switch authError {
                            case .emailAlreadyInUse:
                                errorMessage = "Email already in use."
                            case .invalidEmail:
                                errorMessage = "Invalid email."
                            case .weakPassword:
                                errorMessage = "Weak password. Please use at least 6 characters."
                            default:
                                break // 使用默认的 errorMessage
                            }
                        }


                        self.presentErrorAlert(title  : "Create Account Failed",
                                               message: errorMessage )
                        return
                    }


                    guard let result = result else {
                        self.presentErrorAlert(title  : "Create Account Failed",
                                               message: "Something went wrong. Please try again later.")
                        return
                    }


                    let userId = result.user.uid
                    let userData: [String: Any] = [
                        "id": userId,
                        "username": username
                    ]

                    Database.database().reference()
                        .child("users")
                        .child(userId)
                        .setValue(userData)

                    Database.database().reference()
                        .child("usernames")
                        .child(username)
                        .setValue(userData)

          }

        }
    }

     // ...function...
}



