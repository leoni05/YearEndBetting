//
//  NavigationController.swift
//  YearEndBetting
//
//  Created by yongjun18 on 12/8/24.
//

import Foundation
import UIKit

class NavigationController: UINavigationController, UIGestureRecognizerDelegate {

    /// Custom back buttons disable the interactive pop animation
    /// To enable it back we set the recognizer to `self`
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
