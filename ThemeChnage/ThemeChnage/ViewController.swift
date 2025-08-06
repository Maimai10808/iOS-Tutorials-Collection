//
//  ViewController.swift
//  ThemeChnage
//
//  Created by mac on 5/22/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ThemeColorLabel: UILabel!
    
    enum Theme {
        case red, yellow, blue
    }
    
    // var activeTheme: Theme = .blue

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        change(theme: .blue)
    }
    
    func change(theme: Theme) {
        switch theme {
        case .blue:
            view.backgroundColor = UIColor.blue
            ThemeColorLabel.text = "Blue"
            ThemeColorLabel.textColor = UIColor.blue
        case .red:
            view.backgroundColor = UIColor.red
            ThemeColorLabel.text = "Red"
            ThemeColorLabel.textColor = UIColor.red
        case .yellow:
            view.backgroundColor = UIColor.yellow
            ThemeColorLabel.text = "Yellow"
            ThemeColorLabel.textColor = UIColor.yellow
        }
    }

    @IBAction func blueButtonTapped(_ sender: Any) {
        change(theme: .blue)
    }
    
    @IBAction func redButtonTapped(_ sender: Any) {
        change(theme: .red)
    }
    
    @IBAction func yellowButtonTapped(_ sender: Any) {
        change(theme: .yellow)
    }
}

