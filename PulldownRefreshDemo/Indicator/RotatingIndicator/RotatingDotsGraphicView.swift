//
//  CircleGraphicView.swift
//  LoadingIndicatorDemo
//
//  Created by Yiyin Shen on 18/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

class RotatingDotsGraphicView: UIView {
    private var dotColor = UIColor.gray
    private var numberOfDots = 8
    private var dotRadius: CGFloat = 0

    init(dotColor: UIColor = UIColor.gray, numberOfDots: Int = 8) {
        super.init(frame: CGRect.zero)
        self.dotColor = dotColor
        self.numberOfDots = numberOfDots
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        drawDots()
    }

    private func drawDots() {
        let width = bounds.width / 2
        dotRadius = width / 4.5
        let radius = width - dotRadius

        var angle: CGFloat = 0
        let deltaAngle = CGFloat.pi * 2 / CGFloat(numberOfDots)

        var alpha: CGFloat = 0.8
        let deltaAlpha: CGFloat = (0.8 - 0.2) / CGFloat(numberOfDots)

        for _ in 0...numberOfDots {
            angle = angle + deltaAngle
            alpha = alpha - deltaAlpha
            let circlePoint = CGPoint(x: width + cos(angle) * radius, y: width + radius * sin(angle))
            drawDot(at: circlePoint, alpha: alpha)
        }
    }

    private func drawDot(at point: CGPoint, alpha: CGFloat) {
        let circlePath = UIBezierPath(arcCenter: point, radius: dotRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = dotColor.withAlphaComponent(alpha).cgColor
        layer.addSublayer(shapeLayer)
    }
}
