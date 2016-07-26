//
//  JCDonutGraphView.swift
//  JCDonutGraphView
//
//  Created by Jason Chan on 11/07/2016.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

private let π: CGFloat = CGFloat(M_PI)

@IBDesignable public class JCDonutGraphView: UIView {
    
    public struct Segment {
        let ratio: CGFloat
        let color: UIColor
    }
    
    // Default values
    @IBInspectable public var arcBackgroundColor: UIColor = .lightGrayColor()
    @IBInspectable public var arcWidth: CGFloat = 40
    
    public var startAngle: CGFloat = 0   // Zero starts at 12 o'clock and rotates clockwise
    
    private var angleInRadians: CGFloat {
        // Check valid angle ranges
        var angle: CGFloat = max(startAngle, 0)
        angle = min(angle, 360)
        
        // Convert to radians then -90 degrees anti-clockwise
        angle = (angle == 0) ? 0 : (π / 2 / angle)
        return angle - (π / 2)
    }
    
    public var segments: [Segment] = []
    
    public override func drawRect(rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width, bounds.height)
        
        arcWidth = min(arcWidth, bounds.width/2)
        arcWidth = max(arcWidth, 0)
        let arcRadius = radius / 2 - arcWidth / 2
        
        // Background
        let pathBackground = UIBezierPath(arcCenter: center,
                                          radius: arcRadius,
                                          startAngle: 0,
                                          endAngle: 2 * π,
                                          clockwise: true)
        pathBackground.lineWidth = arcWidth
        arcBackgroundColor.setStroke()
        pathBackground.stroke()
        
        // Total ratio
        let total = segments.reduce(0) { (sum, section) in
            return sum + section.ratio
        }
        
        // Foreground Sections
        var currentAngle: CGFloat = angleInRadians
        segments.forEach { segment in
            let startAngle: CGFloat = currentAngle
            let endAngle: CGFloat = startAngle + (segment.ratio / total) * (2 * π)
            currentAngle = endAngle
            
            let pathForeground = UIBezierPath(arcCenter: center,
                radius: arcRadius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true)
            pathForeground.lineWidth = arcWidth
            segment.color.setStroke()
            pathForeground.stroke()
        }
    }
}