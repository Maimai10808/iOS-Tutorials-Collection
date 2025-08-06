//
//  BarGraphView.swift
//  Graph
//
//  Created by mac on 7/14/25.
//

import UIKit

@IBDesignable
class BarGraphView: UIView {
    
    let barGraphData:[BarGraphData] = [
        BarGraphData(label: "Mon", value: 10),
        BarGraphData(label: "Tue", value: 7),
        BarGraphData(label: "Wed", value: 2),
        BarGraphData(label: "Thu", value: 15),
        BarGraphData(label: "Fri", value: 6),
    ]
    
    let barWidth: CGFloat = 20.0
    var margin: CGFloat {
            return 0.1 * bounds.width
        }
    var graphMidPoint: Int {
            return Int((bounds.height - (2 * margin)) / 2)
    }

    override func draw(_ rect: CGRect) {
        
        // draw line
        drawLine()
        
        // draw label  and  draw bar
        drawLabelAndBar()
    }
    
    func drawLine() {
        let linePath = UIBezierPath()
        
        // up
        linePath.move   (to: CGPoint(x: 0,            y: margin))
        linePath.addLine(to: CGPoint(x: bounds.width, y: margin))
        
        // graphMidPoint
        linePath.move   (to: CGPoint(x: 0,            y: CGFloat(graphMidPoint) + margin))
        linePath.addLine(to: CGPoint(x: bounds.width, y: CGFloat(graphMidPoint) + margin))
        
        // down
        linePath.move   (to: CGPoint(x: 0,            y: bounds.height - margin))
        linePath.addLine(to: CGPoint(x: bounds.width, y: bounds.height - margin))
        
        UIColor.black.setStroke()
        linePath.lineWidth = 0.5
        linePath.stroke()
    }
    
    func drawLabelAndBar() {
        
        // labelAttributes
        let font = UIFont(name: "Avenir-Medium", size: 14)!
        let labelAttributes: [NSAttributedString.Key: Any] = [
            .font           : font,
            .foregroundColor: UIColor.black
        ]
        
        // DataValue
        let highestDataValue = Int(barGraphData.max { $0.value < $1.value }!.value)
        let midDataValue = Int(highestDataValue / 2)
        let bottomDataValue = 0
        
        // vertical Label
        let verticalTopLabel   : NSString = String(highestDataValue) as NSString
        let verticalMidLabel   : NSString = String(midDataValue)     as NSString
        let verticalBottomLabel: NSString = String(bottomDataValue)  as NSString
        
        // draw vertical Label
        verticalTopLabel.draw   (at: CGPoint(x: 0, y: margin),
                                 withAttributes: labelAttributes)
        verticalMidLabel.draw   (at: CGPoint(x: 0, y: CGFloat(graphMidPoint) + margin),
                                 withAttributes: labelAttributes)
        verticalBottomLabel.draw(at: CGPoint(x: 0, y: bounds.height - margin),
                                 withAttributes: labelAttributes)
        
        let numberOfBars: Int = barGraphData.count
        let numberOfGaps: Int = numberOfBars - 1
        let barGap: CGFloat = (bounds.width - (CGFloat(numberOfBars) * barWidth) - (2 * margin)) / CGFloat(numberOfGaps)
        
        for i in 0...barGraphData.count - 1 {
            let xPos = CGFloat(i) * (barWidth + barGap) + margin
            let barHeight: CGFloat = CGFloat(barGraphData[i].value) /
            CGFloat(highestDataValue) * (bounds.height - margin * 2)
            let yPos = bounds.height - barHeight - margin
            let bar = UIBezierPath(rect: CGRect(x: xPos,
                                                y: yPos,
                                                width: barWidth,
                                                height: barHeight))
            let barColor = UIColor(red: randomColorValue(),
                                   green: randomColorValue(),
                                   blue: randomColorValue(),
                                   alpha: 1.0)
            barColor.setFill()
            bar.fill()
            
            let label = barGraphData[i].label as NSString
            let textPos = CGPoint(x: xPos, y: bounds.height - margin)
            label.draw(at: textPos, withAttributes: labelAttributes)
        }
        
        func randomColorValue() -> CGFloat {
            return CGFloat(arc4random()) / CGFloat(UInt32.max)
        }
    }
}
