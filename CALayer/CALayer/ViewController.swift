//
//  ViewController.swift
//  CALayer
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var practiceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let practiceViewWidth = CGFloat(200)
        let xPos = view.frame.width / 2 - practiceViewWidth / 2
        let yPos = view.frame.height / 2 - practiceViewWidth / 2
        practiceView.frame = CGRect(x: xPos, y: yPos, width: practiceViewWidth, height: practiceViewWidth)
    }
    


}

