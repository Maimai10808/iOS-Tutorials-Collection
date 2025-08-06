//
//  RingGraphView.swift
//  RingGraph
//
//  Created by mac on 7/14/25.
//

import UIKit

class RingGraphView: UIView {

    let backdropLayer: CAShapeLayer    = CAShapeLayer()
    let ringLayer    : CAShapeLayer    = CAShapeLayer()
    let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    let ringWidth: CGFloat = CGFloat(40.0)
    let offset   : CGFloat = CGFloat(90 * Double.pi / 180)
    
    var halfRingWidth: CGFloat {
        return ringWidth / 2
    }
    
    var circlePath: CGPath {
        return UIBezierPath(ovalIn: CGRect(
            x: halfRingWidth,
            y: halfRingWidth,
            width : bounds.width  - ringWidth,
            height: bounds.height - ringWidth)
        ).cgPath
    }
    
    var progress: CGFloat = CGFloat(0.5) {
        didSet {
                 if progress >= 1.0 {
                    progress = 1.0
            }
            else if progress <= 0.0 {
                    progress = 0.0
            }
            
            ringLayer.strokeEnd = progress
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        drawBackDropLayer()
        drawRingLayer()
    }
    
    
    func drawBackDropLayer() {

        
        backdropLayer.path        = circlePath
        backdropLayer.lineWidth   = ringWidth
        backdropLayer.strokeEnd   = 1.0
        backdropLayer.fillColor   = nil
        backdropLayer.strokeColor = UIColor(red  : 112 / 255,
                                            green: 25  / 255,
                                            blue : 18  / 255,
                                            alpha: 1.0).cgColor
        
        layer.addSublayer(backdropLayer)
    }
    
    func drawRingLayer() {
        ringLayer.path        = circlePath
        ringLayer.frame       = CGRect(x: 0,
                                       y: 0,
                                       width: bounds.width,
                                       height: bounds.height)
        ringLayer.lineWidth   = ringWidth
        ringLayer.strokeColor = UIColor.black.cgColor
        ringLayer.fillColor   = nil
        ringLayer.strokeEnd   = 0.5
        ringLayer.lineCap     = .round
        ringLayer.transform   = CATransform3DMakeRotation(offset, 0, 0, -1.0)
        
        // layer.addSublayer(ringLayer)
        
        gradientLayer.colors = [UIColor(red  : 231 / 255,
                                        green: 51  / 255,
                                        blue : 38  / 255,
                                        alpha: 1.0).cgColor,
                                UIColor(red  : 248 / 255,
                                        green: 255 / 255,
                                        blue : 174 / 255,
                                        alpha: 1.0).cgColor]
        gradientLayer.frame     = bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.mask      = ringLayer
        
        layer.addSublayer(gradientLayer)
    }
}

/*
 gradientLayer.frame     = bounds 让渐变层覆盖整个视图 匹配父视图尺寸

 gradientLayer.locations = [0.0, 1.0] 定义每个颜色在渐变中的相对位置 控制颜色如何分布

 */
