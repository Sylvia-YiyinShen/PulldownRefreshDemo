//
//  DotsLoadingView.swift
//  LoadingIndicatorDemo
//
//  Created by Yiyin Shen on 18/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import UIKit

class DotView: UIView {
    private let expandRate: CGFloat = 1.8
    private let animationDuration = 0.3
    private var animationDelay: Double = 0
    private var expanded = false
    
    init(color: UIColor, delay: Double, frame: CGRect) {
        super.init(frame: frame)

        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
        self.backgroundColor = color
        self.animationDelay = delay
        self.startAnimation()
    }

    private func startAnimation() {
        var animator: UIViewPropertyAnimator
        if expanded {
            animator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut)
            animator.addAnimations({
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        } else {
            animator = UIViewPropertyAnimator(duration: animationDuration, curve: .linear)
            animator.addAnimations({
                self.transform = CGAffineTransform(scaleX: self.expandRate, y: self.expandRate)
            })
        }

        animator.addCompletion { [weak self] _ in
            self?.startAnimation()
        }

        animator.startAnimation(afterDelay: animationDelay)

        if expanded {
            animationDelay = 0.9
        } else {
            animationDelay = 0.1
        }

        expanded = !expanded
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
