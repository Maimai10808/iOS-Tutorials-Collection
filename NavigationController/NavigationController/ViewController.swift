//
//  ViewController.swift
//  NavigationController
//
//  Created by mac on 6/5/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func goToNextVC(_ sender: Any) {
     //   performSegue(withIdentifier: "NextVCSegue", sender: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = mainStoryboard.instantiateViewController(withIdentifier: "NextVC")
        navigationController?.pushViewController(nextVC, animated: true)
    }
    

}

