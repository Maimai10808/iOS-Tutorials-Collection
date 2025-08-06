//
//  NextViewController.swift
//  NavigationController
//
//  Created by mac on 6/5/25.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToLastVC(_ sender: Any) {
        performSegue(withIdentifier: "LastVCSegue", sender: nil)
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

}
