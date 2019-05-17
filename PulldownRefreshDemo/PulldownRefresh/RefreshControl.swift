//
//  RefreshControl.swift
//  PulldownRefreshDemo
//
//  Created by Yiyin Shen on 16/5/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

enum RefreshingState {
    case refreshing // pulling down trigger a refresh
    case endedDragging // releaseed finger after pulling down
    case endingRefreshing // after refreshDone() invoked before tableView pushing up the indicator until completely hiding it
    case endedRefreshing // default state or tableView completely hides the indicator after refreshing
}

public class RefreshControl: UIView {
    private var activityView: UIActivityIndicatorView?
    public weak var scrollView: UIScrollView?
    private let contentOffsetKeyPath = "contentOffset"
    private var refreshHandler: (() -> Void)
    private var refreshingState: RefreshingState = .endedRefreshing
    private let refreshViewHeight: CGFloat = 60

    init(refreshHandler: @escaping () -> Void) {
        self.refreshHandler = refreshHandler
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: refreshViewHeight))
        backgroundColor = UIColor.clear
    }

    public func refreshDone() {
        refreshingState = .endingRefreshing
        scrollView?.setContentOffset(CGPoint.zero, animated: true)
    }

    private func showLoadingIndicator() {
        showRotatingImageIndicator()
        //showDotsLoadingIndicator()
    }

    private func hideLoadingIndicator() {
        hideRotatingLoadingIndicator()
        //hideDotsLoadingIndicator()
    }

    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        scrollView?.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .new, context: nil)
    }

    override public func removeFromSuperview() {
        scrollView?.removeObserver(self, forKeyPath: contentOffsetKeyPath)
        super.removeFromSuperview()
    }

    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == contentOffsetKeyPath, let contentOffsetY = scrollView?.contentOffset.y {
            // default state
            if contentOffsetY >= CGFloat(0) {
                isHidden = true
                refreshingState = .endedRefreshing
                hideLoadingIndicator()
            } else {
                // tableView gradually hiding the indicator
                if refreshingState == .endingRefreshing {
                    return
                }

                if refreshingState == .endedRefreshing {
                    refreshingState = .refreshing
                    refreshHandler()
                    showLoadingIndicator()
                    isHidden = false
                }

                // adjust position
                let refreshControlOffsetY = min(-refreshViewHeight, contentOffsetY)
                frame = CGRect(x: 0, y: refreshControlOffsetY, width: UIScreen.main.bounds.width, height: refreshViewHeight)

                // update state when finger leaves
                if refreshingState == .refreshing && !(scrollView?.isDragging ?? true) {
                    refreshingState = .endedDragging
                    scrollView?.setContentOffset(CGPoint(x: 0, y: -refreshViewHeight), animated: true)
                }
            }
        }
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
