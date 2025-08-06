//
//  ViewController.swift
//  Transformations
//
//  Created by mac on 7/14/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createSquare()
    }
    
    func createSquare() {
        
        let squarePath: CGPath = UIBezierPath(rect: CGRect( x: 0,
                                                            y: 0,
                                                            width: 200,
                                                            height: 200)).cgPath
        let squreShape = CAShapeLayer()
        squreShape.path = squarePath
        
        squreShape.frame = CGRect(
                                  x: view.frame.midX - 100,
                                  y: view.frame.midY - 100,
                                  width: 200,
                                  height: 200)
        
        squreShape.fillColor = UIColor.orange.cgColor
        
        let angle = 45 * CGFloat(Double.pi) / 180
        squreShape.transform = CATransform3DMakeRotation(angle, 0, 0, 1.0)
        view.layer.addSublayer(squreShape)
        
    }
}

