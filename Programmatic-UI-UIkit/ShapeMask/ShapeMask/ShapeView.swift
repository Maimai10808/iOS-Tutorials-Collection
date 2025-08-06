//
//  ShapeView.swift
//  ShapeMask
//
//  Created by mac on 7/14/25.
//

import UIKit

class ShapeView: UIView {

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        let shape  = CAShapeLayer()
        
        let lineWidth: CGFloat = 30.0
        
        shape.path        = UIBezierPath(ovalIn: CGRect(x: lineWidth / 2,
                                                        y: lineWidth / 2,
                                                        width : bounds.width  - lineWidth,
                                                        height: bounds.height - lineWidth)).cgPath
        
        shape.frame       = bounds
        shape.fillColor   = nil
        shape.lineWidth   = lineWidth
        shape.strokeColor = UIColor.black.cgColor
        
        // layer.addSublayer(shape)
        
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = bounds
        
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
        
        gradientLayer.mask = shape
        
        layer.addSublayer(gradientLayer)
    }

}
