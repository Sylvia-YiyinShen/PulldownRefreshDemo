//
//  UIView+extension.swift
//  LoadingIndicatorDemo
//
//  Created by Yiyin Shen on 18/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit


private var rotatingLoadingIndicatorAssociationKey = 0
private var dotsLoadingIndicatorAssociationKey = 1

extension UIView {

    private var rotatingLoadingIndicator: RotatingLoadingIndicator? {
        get {
            return objc_getAssociatedObject(self, &rotatingLoadingIndicatorAssociationKey) as? RotatingLoadingIndicator
        }
        set {
            objc_setAssociatedObject(self, &rotatingLoadingIndicatorAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var dotsLoadingIndicator: DotsLoadingIndicator? {
        get {
            return objc_getAssociatedObject(self, &dotsLoadingIndicatorAssociationKey) as? DotsLoadingIndicator
        }
        set {
            objc_setAssociatedObject(self, &dotsLoadingIndicatorAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func showDotsLoadingIndicator(with size: CGSize = CGSize(width: 50, height: 25)) {
        guard dotsLoadingIndicator == nil else { return }
        let indicator = DotsLoadingIndicator(with: size)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: size.width),
            indicator.heightAnchor.constraint(equalToConstant: size.height),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: centerYAnchor)])
        dotsLoadingIndicator = indicator
        dotsLoadingIndicator?.show()
    }

    func hideDotsLoadingIndicator() {
        dotsLoadingIndicator?.hide()
        dotsLoadingIndicator?.removeFromSuperview()
        dotsLoadingIndicator = nil
    }

    func showRotatingImageIndicator(with size: CGSize = CGSize(width: 40, height: 40) ,speed: RotateSpeed = .medium) {
        guard rotatingLoadingIndicator == nil else { return }
        let circleIndicator = RotatingLoadingIndicator(useImage: true, rotateSpeed: speed)
        circleIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleIndicator)
        NSLayoutConstraint.activate([
            circleIndicator.widthAnchor.constraint(equalToConstant: size.width),
            circleIndicator.heightAnchor.constraint(equalToConstant: size.width),
            circleIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)])
        rotatingLoadingIndicator = circleIndicator
        rotatingLoadingIndicator?.show()
    }

    func showRotatingDotsIndicator(with size: CGSize = CGSize(width: 40, height: 40) ,speed: RotateSpeed = .medium) {
        guard rotatingLoadingIndicator == nil else { return }
        let circleIndicator = RotatingLoadingIndicator(color: UIColor.gray, rotateSpeed: speed)
        circleIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circleIndicator)
        NSLayoutConstraint.activate([
            circleIndicator.widthAnchor.constraint(equalToConstant: size.width),
            circleIndicator.heightAnchor.constraint(equalToConstant: size.width),
            circleIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)])
        rotatingLoadingIndicator = circleIndicator
        rotatingLoadingIndicator?.show()
    }

    func hideRotatingLoadingIndicator() {
        rotatingLoadingIndicator?.hide()
        rotatingLoadingIndicator?.removeFromSuperview()
        rotatingLoadingIndicator = nil
    }
}
