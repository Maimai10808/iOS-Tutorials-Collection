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



    @IBAction func createAccountButtonTapped(_ sender: Any) {
        showLoadingView()
        checkIfExists(username: username) { [weak self] usernameExists in
            guard let strongSelf = self else { return }
            if !usernameExists {
                strongSelf.createUser(username: username, email: email, password: password) { result, error in

                    if let error = error {

                        DispatchQueue.main.async {
                            strongSelf.presentErrorAlert(title: "Create Account Failed", message: error)
                        }

                        return
                    }

                    guard let result = result else {
                        strongSelf.presentErrorAlert(title: "Create Account Failed", message: "Please try again later.")
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
            } else {
                strongSelf.presentErrorAlert(title  : "Usename In Use",
                                       message: "Please enter a different name to continue.")
                strongSelf.removeLoadingView()
            }
        }

    }


    func checkIfExists(username: String, completion: @escaping (_ result: Bool) -> Void ) {

        Database.database().reference().child("usernames").child(username)
            .observeSingleEvent(of: .value) { snapshot in

                guard !snapshot.exists() else {
                   completion(true)
                    return
                }

                completion(false)
          }

    }

    func createUser(username: String, email: String, password: String, completion: @escaping (_ result: AuthDataResult?, _ error: String?) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else { return }
            strongSelf.removeLoadingView()
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
                completion(nil, errorMessage)
                return
            }
            guard let result = result else {
                completion(nil, "Something went wrong. Please try again later.")
                return
            }
            completion(result, nil)
        }
    }


}



