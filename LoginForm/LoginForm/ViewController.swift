//
//  ViewController.swift
//  LoginForm
//
//  Created by mac on 5/21/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginSuccessLabel: UILabel!
    
    let expectedUsername = "Maimai"
    let expectedPassword = "randompassword"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginSuccessLabel.text = ""
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let username = usernameTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        if username == expectedUsername && password == expectedPassword {
            print("successful login")
            loginSuccessLabel.text = "Successful Login!"
            loginSuccessLabel.textColor = UIColor.green
        }
        
        if username == expectedUsername && password != expectedPassword {
            print("successful Username, incorrect Password")
            loginSuccessLabel.text = "successful Username, incorrect Password"
            loginSuccessLabel.textColor = UIColor.red
        }
        
        if username != expectedUsername && password == expectedPassword {
            print("successful Password, incorrect Username")
            loginSuccessLabel.text = "successful Password, incorrect Username"
            loginSuccessLabel.textColor = UIColor.red
        }
        
        if username != expectedUsername && password != expectedPassword {
            print("Wrong!!!")
            loginSuccessLabel.text = "Wrong!!!"
            loginSuccessLabel.textColor = UIColor.red
        }
        
    }
}

