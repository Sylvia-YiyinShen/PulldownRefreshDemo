//
//  DotsLoadingView.swift
//  LoadingIndicatorDemo
//
//  Created by Yiyin Shen on 18/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

public class DotsLoadingIndicator: UIView {

    private var numberOfDots: Int = 3
    private var dotColor: UIColor = UIColor.orange
    private var dotRadius: CGFloat = 0
    private var dots: [DotView] = []

    public init(with size: CGSize, dotColor: UIColor = UIColor.orange, numberOfDots: Int = 3) {
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        self.numberOfDots = numberOfDots
        self.dotColor = dotColor
        self.dotRadius = size.width / CGFloat(numberOfDots) * 0.6
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func show() {
        for i in 0..<numberOfDots {
            let dotFrame = CGRect(x: 0, y: 0, width: dotRadius, height: dotRadius)
            let dot = DotView(color: dotColor, delay: 0.25 * Double(i), frame: dotFrame)
            dot.center = CGPoint(x: frame.width / CGFloat(2 * numberOfDots) + CGFloat(i) * frame.width / CGFloat(numberOfDots), y: frame.height / 2)
            dots.append(dot)
            addSubview(dot)
        }
    }

    public func hide() {
        dots.forEach { (dotView) in
            dotView.removeFromSuperview()
        }
        dots = []
    }
}
