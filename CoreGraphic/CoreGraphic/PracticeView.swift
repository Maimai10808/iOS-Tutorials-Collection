//
//  PracticeView.swift
//  CoreGraphic
//
//  Created by mac on 7/13/25.
//

import UIKit

@IBDesignable
class PracticeView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        /*
        let ctx = UIGraphicsGetCurrentContext()!
        
        
        ctx.setFillColor  (UIColor.orange.cgColor)
        ctx.setStrokeColor(UIColor.blue  .cgColor)
        ctx.setLineWidth(6.5)
        /*
         ctx.move(to: CGPoint(x: 0, y: 0))
         ctx.addLine(to: CGPoint(x: 180, y: 0))
         ctx.addLine(to: CGPoint(x: 180, y: 90))
         ctx.addLine(to: CGPoint(x: 0, y: 90))
         ctx.closePath()
         ctx.fillPath()
         */
        /*
         let rectPath = CGMutablePath()
         rectPath.move   (to: CGPoint(x: 2.25, y: 2.25))
         rectPath.addLine(to: CGPoint(x: 180.25, y: 2.25))
         rectPath.addLine(to: CGPoint(x: 180.25, y: 90.25))
         rectPath.addLine(to: CGPoint(x: 2.25, y: 90.25))
         rectPath.closeSubpath()
         
         ctx.addPath(rectPath)
         // ctx.fillPath()
         ctx.strokePath()
         */
        
        /*
        let rectPath = UIBezierPath()
        rectPath.move   (to: CGPoint(x: 2.25, y: 2.25))
        rectPath.addLine(to: CGPoint(x: 180.25, y: 2.25))
        rectPath.addLine(to: CGPoint(x: 180.25, y: 90.25))
        rectPath.addLine(to: CGPoint(x: 2.25, y: 90.25))
        ctx.fillPath()
         */
        
        /*
        let rectPath = UIBezierPath(rect: CGRect(x: 2, y: 2, width: 180, height: 90))
        rectPath.fill()
        
        UIColor.green.setFill()
        createtrianglePath()
        
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 2, y: 2, width: 100, height: 100))
       
        ovalPath.fill()
        
        let center     = CGPoint(x: bounds.width  / 2,
                                 y: bounds.height / 2)
        let arcRadius  = CGFloat(135) * (.pi / 180)
        let startAngle = CGFloat(135) * (.pi / 180)
        let endAngle   = CGFloat(45)  * (.pi / 180)
        let arcPath    = UIBezierPath(arcCenter : center,
                                      radius    : arcRadius,
                                      startAngle: startAngle,
                                      endAngle  : endAngle,
                                      clockwise : true)
        arcPath.lineWidth = 50
        UIColor.orange.setStroke()
        arcPath.stroke()
         
         
         
         func createtrianglePath() {
             let trianglePath = UIBezierPath()
             
             trianglePath.move   (to: CGPoint(x: 2, y: 90))
             trianglePath.addLine(to: CGPoint(x: 100, y: 90))
             trianglePath.addLine(to: CGPoint(x: 50, y: 10))
             trianglePath.close()
             UIColor.blue.setFill()
             trianglePath.fill()
         }
         
         */
        */
        
        /*
        let context            = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        let ovalPath = UIBezierPath(ovalIn:CGRect(x: 50, y: 50, width: 200, height: 200))
        ovalPath.addClip()
        let gradientStartColor = UIColor.yellow.cgColor
        let gradientEndColor   = UIColor.red   .cgColor
        let colors             = [gradientStartColor, gradientEndColor]
        let colorSpace         = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors     : colors as CFArray,
                                  locations  : colorLocations)!
        let startPoint         = CGPoint.zero
        let endPoint           = CGPoint(x: 0.0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
        context.restoreGState()
        
        let secondOval = UIBezierPath(ovalIn:CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height))
        UIColor.green.setFill()
        secondOval.fill()
        */
        
        /*
        let context             = UIGraphicsGetCurrentContext()!
        let shadowColor         = UIColor.black.withAlphaComponent(0.7).cgColor
        let shadowOffset        = CGSize(width: 2.0, height: 2.0)
        let shadowBlur: CGFloat = 5.0
        context.setShadow(offset: shadowOffset,
                          blur: shadowBlur,
                          color: shadowColor)
        let oval = UIBezierPath(ovalIn: CGRect(x: 50, y: 50, width: 100, height: 100))
        UIColor.green.setFill()
        oval.fill()
         */
        
        let context = UIGraphicsGetCurrentContext()!
        let rotationAngle: CGFloat = 45 * .pi / 180
        let squreWidth   : CGFloat = 80.0
        let viewWidth    : CGFloat = bounds.width
        let viewHeight   : CGFloat = bounds.height
        // context.translateBy(x: viewWidth / 2, y: viewHeight / 2)
        // context.rotate(by: rotationAngle)
        // context.scaleBy(x: 1.2, y: 1.2)
        var transform = CGAffineTransform(translationX: viewWidth / 2, y: viewHeight / 2)
        transform = transform.rotated(by: rotationAngle)
        transform = transform.scaledBy(x: 1.2, y: 1.2)
        let squrePath = UIBezierPath(rect: CGRect(
                                                  x: -viewWidth  / 2 - squreWidth / 2,
                                                  y: -viewHeight / 2 - squreWidth / 2,
                                                  width : squreWidth,
                                                  height: squreWidth))
        squrePath.apply(transform)
        
        UIColor.green.setFill()
        squrePath.fill()
        
    }
}
