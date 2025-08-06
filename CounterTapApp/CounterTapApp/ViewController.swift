//
//  ViewController.swift
//  CounterTapApp
//
//  Created by mac on 5/21/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var changeCounterButton: UIButton!
    
    var currentNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberLabel.frame = CGRect(
            x: 0,
            y: numberLabel.frame.origin.y,
            width: view.frame.width,
            height: numberLabel.frame.height)
        
        let changeCounterButtonYPos = numberLabel.frame.origin.y + numberLabel.frame.height + CGFloat(40)
        
        changeCounterButton.frame.origin = CGPoint(x: changeCounterButton.frame.origin.x, y: changeCounterButtonYPos)
    }

    @IBAction func changeCounterButtonTapped(_ sender: Any) {
        
        if currentNumber + 1 > 30 {
            view.backgroundColor = UIColor(.white)
            currentNumber = 0
            numberLabel.text = "\(currentNumber)"
            return
        }
        currentNumber += 1
        numberLabel.text = "\(currentNumber)"
        
        if currentNumber >= 10 && currentNumber <= 20 {
            view.backgroundColor = UIColor(.red)
        }
        if currentNumber >= 20 && currentNumber <= 30{
            view.backgroundColor = UIColor(.blue)
        }
        
    }
    
}

