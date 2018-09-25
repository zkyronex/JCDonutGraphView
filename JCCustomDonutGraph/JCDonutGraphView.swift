//
//  JCDonutGraphView.swift
//  JCDonutGraphView
//
//  Created by Jason Chan on 11/07/2016.
//  Copyright © 2016 Jason Chan. All rights reserved.
//

import UIKit

private let π: CGFloat = .pi

public extension JCDonutGraphView {

    struct Segment {

        let color: UIColor
        let ratio: CGFloat

        init(color: UIColor, ratio: CGFloat = 1) {
            self.color = color
            self.ratio = ratio
        }
    }
}

@IBDesignable public class JCDonutGraphView: UIView {
    
    // Default values
    @IBInspectable public var arcPlaceholderColor: UIColor = .lightGray
    @IBInspectable public var arcWidth: CGFloat = 40

    public var startAngle: CGFloat = 0   // Zero starts at 12 o'clock and rotates clockwise
    
    private var startAngleInRadians: CGFloat {
        // Check valid angle ranges
        var angle: CGFloat = max(startAngle, 0)
        angle = min(angle, 360)
        
        // Convert to radians then -90 degrees anti-clockwise
        angle = (angle == 0) ? 0 : (π / 2 / angle)
        return angle - (π / 2)
    }
    
    public var segments: [Segment] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = min(bounds.width, bounds.height)
        
        arcWidth = min(arcWidth, bounds.width/2)
        arcWidth = max(arcWidth, 0)
        let arcRadius = radius / 2 - arcWidth / 2

        drawPlaceholderArcFor(center: center, arcRadius: arcRadius)
        drawArcSegmentsFor(center: center, arcRadius: arcRadius)
    }

    private func drawPlaceholderArcFor(center: CGPoint, arcRadius: CGFloat) {
        let pathBackground = UIBezierPath(
            arcCenter: center,
            radius: arcRadius,
            startAngle: 0,
            endAngle: 2 * π,
            clockwise: true
        )

        pathBackground.lineWidth = arcWidth
        arcPlaceholderColor.setStroke()
        pathBackground.stroke()
    }

    private func drawArcSegmentsFor(center: CGPoint, arcRadius: CGFloat) {
        let totalRatio = segments
            .map { $0.ratio }
            .reduce(0, +)

        var currentAngle: CGFloat = startAngleInRadians
        segments.forEach { segment in
            let startAngle = currentAngle
            let endAngle = startAngle + (segment.ratio / totalRatio) * (2 * π)
            currentAngle = endAngle

            let pathForeground = UIBezierPath(
                arcCenter: center,
                radius: arcRadius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: true
            )
            pathForeground.lineWidth = arcWidth
            segment.color.setStroke()
            pathForeground.stroke()
        }
    }
}
