//
//  LoadingIndicator.swift
//  LoadingIndicatorDemo
//
//  Created by Yiyin Shen on 18/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

enum RotateSpeed {
    case slow
    case medium
    case fast
}

class RotatingLoadingIndicator: UIView {
    private var imageName: String = "circle-orange"
    private var indicatorImageView: UIView?
    private var rotateAnimationKey = "rotateAnimationKey"
    private var rotateSpeed: RotateSpeed = .medium
    private var color: UIColor = UIColor.gray
    private var useImage: Bool = false
    private var clockwise: Bool = true
    private lazy var rotateAnimation: CABasicAnimation = {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        if clockwise {
            rotation.fromValue = 0.0
            rotation.toValue = Double.pi * 2
        } else {
            rotation.fromValue = Double.pi * 2
            rotation.toValue = 0.0
        }
        switch rotateSpeed {
        case .slow:
                rotation.duration = 1.5
        case .medium:
            rotation.duration = 1.0
        case .fast:
            rotation.duration = 0.5
        }
        rotation.repeatCount = Float.greatestFiniteMagnitude
        return rotation
    }()

    private lazy var rotationAnimation: CABasicAnimation = {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0.0
        rotation.toValue = Double.pi * 2
        rotation.duration = 1.5
        rotation.repeatCount = Float.greatestFiniteMagnitude
        return rotation
    }()

    init(useImage: Bool = false,color: UIColor = UIColor.gray, rotateSpeed: RotateSpeed = .medium, clockwise: Bool = true) {
        super.init(frame: CGRect.zero)
        self.rotateSpeed = rotateSpeed
        self.color = color
        self.useImage = useImage
        self.clockwise = clockwise
        initialConfigure()
    }

    func initialConfigure() {
        isHidden = true
        let indicator: UIView
        if useImage {
            indicator = UIImageView(image: UIImage(named: imageName))

        } else {
            indicator = RotatingDotsGraphicView()
        }
        indicatorImageView = indicator
        addSubview(indicatorImageView!)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: topAnchor),
            indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
            indicator.leftAnchor.constraint(equalTo: leftAnchor),
            indicator.rightAnchor.constraint(equalTo: rightAnchor)])
    }

    func show() {
        isHidden = false
        indicatorImageView?.layer.add(rotateAnimation, forKey: rotateAnimationKey)
    }

    func hide() {
        isHidden = true
        indicatorImageView?.layer.removeAnimation(forKey: rotateAnimationKey)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
