//
//  ViewController.swift
//  CAShapes
//
//  Created by mac on 7/14/25.
//

import UIKit

class ViewController: UIViewController {

    let squereShapeLayer  : CAShapeLayer = CAShapeLayer()
    
    let triangleShapeLayer: CAShapeLayer = CAShapeLayer()
    
    let combineShapeLayer : CAShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // createSquareShape()
        // createTriangleShape()
        combinePaths()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
    }
    
    func createSquareShape() {
        squereShapeLayer.fillColor   = UIColor.red.cgColor
        squereShapeLayer.lineWidth   = 10.0
        squereShapeLayer.strokeColor = UIColor.black.cgColor
        view.layer.addSublayer(squereShapeLayer)
    }
    
    func createTriangleShape() {
        triangleShapeLayer.fillColor = UIColor.red.cgColor
        view.layer.addSublayer(triangleShapeLayer)
    }
    
    func combinePaths() {
        let squrePath    = UIBezierPath(rect: CGRect(x: 50, y: 50, width: 100, height: 100))
        let trianglePath = UIBezierPath()
        let combinePath  = UIBezierPath()
        
        trianglePath.move   (to: CGPoint(x: 50, y: 300))
        trianglePath.addLine(to: CGPoint(x: 150, y: 300))
        trianglePath.addLine(to: CGPoint(x: 100, y: 200))
        trianglePath.close()
        
        combinePath.append(squrePath)
        combinePath.append(trianglePath)
        
        combineShapeLayer .path = combinePath.cgPath
        
        combineShapeLayer.frame           = CGRect(x: 120, y: 70, width: 300, height: 300)
        combineShapeLayer.strokeColor     = UIColor.red.cgColor
        combineShapeLayer.fillColor       = UIColor.clear.cgColor
        combineShapeLayer.lineWidth       = 5
        combineShapeLayer.lineJoin        = .round
        combineShapeLayer.lineCap         = .round
        combineShapeLayer.strokeStart     = 0
        combineShapeLayer.strokeEnd       = 0.7
        combineShapeLayer.lineDashPattern = [6, 3]
        combineShapeLayer.lineDashPhase   = 0
        
        view.layer.addSublayer(combineShapeLayer)
    }


}

