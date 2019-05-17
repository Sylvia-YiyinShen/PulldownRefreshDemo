//
//  RefreshableTableView.swift
//  PulldownRefreshDemo
//
//  Created by Yiyin Shen on 16/5/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation
import UIKit

public class RefreshableTableView: UITableView {
    private var _refreshControl: RefreshControl?

    func refreshDone() {
        _refreshControl?.refreshDone()
    }

    func configureRefreshControl(refreshHandler: @escaping () -> Void) {
        _refreshControl = RefreshControl(refreshHandler: refreshHandler)
        _refreshControl?.tableView = self
        addSubview(_refreshControl!)
    }
}
