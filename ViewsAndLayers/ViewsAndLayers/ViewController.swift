//
//  ViewController.swift
//  ViewsAndLayers
//
//  Created by mac on 5/20/25.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var testview: UIView!
    @IBOutlet weak var changeColorButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    @IBAction func buttonTapped(_ sender: Any) {
        colorView.backgroundColor = UIColor.blue
        changeColorButton.setTitle("Button Was Clicked", for: .normal)
        
        let xPos = view.frame.width - colorView.frame.width
        let yPos = view.frame.height - colorView.frame.height
        
        colorView.frame.origin = CGPoint(x: xPos, y: 0)
    }
    
}

