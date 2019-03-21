//  BaseViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/18.
//
//
//  Copyright (c) 2019 SummerHF(https://github.com/summerhf)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import AsyncDisplayKit

// MARK: - ASDK

class BaseViewControlle: ASViewController<ASDisplayNode> {
    
    /// 全局共用的navigationBar
    var navigationBar = CommenNavigationBar()
    
    init() {
        super.init(node: ASDisplayNode())
        configureNavBar()
    }
    
    override init(node: ASDisplayNode) {
        if node.isKind(of: ASScrollNode.self) || node.isKind(of: ASTableNode.self) || node.isKind(of: ASCollectionNode.self) {
            let baseNode = ASDisplayNode()
            super.init(node: baseNode)
            configureNavBar()
            baseNode.addSubnode(node)
            node.frame = CGRect(x: 0, y: macro.topHeight, width: macro.screenWidth, height: macro.screenHeight - macro.topHeight)
            return
        }
        super.init(node: node)
        configureNavBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    /// 配置导航条
    func configureNavBar() {
        /// 是否隐藏导航条
        guard !initialHidden() else { return }
        /// 是否使用自定义导航条
        if let navigationBar = self.createCustomeNavigationBar() {
            self.node.addSubnode(navigationBar)
        }
        self.node.addSubnode(navigationBar)
    }
}

extension BaseViewControlle: NavigationBarManagerMent {
    
    func createCustomeNavigationBar() -> BaseNavigationBar? {
        /// subclass to overrid
        return nil
    }
    
    func hiddenTopBar(isHidden: Bool) {
        self.navigationBar.isHidden = isHidden
    }
    
    func initialHidden() -> Bool {
        /// default false, subclass to override
        return false
    }
}

// MARK: - BaseNavigationController

class BaseNavigationController: ASNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarHidden(true, animated: false)
        self.setCustomGestureRecognizer()
    }
    
    /// 设置自定义侧滑返回手势
    private func setCustomGestureRecognizer() {
    
//         使用系统自带的屏幕边缘侧滑返回
         self.interactivePopGestureRecognizer?.delegate = self
         self.interactivePopGestureRecognizer?.isEnabled = true
//
//         let target = self.interactivePopGestureRecognizer?.delegate
//         self.interactivePopGestureRecognizer?.isEnabled = false
//         let panGesture = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
//         panGesture.delegate = self
//         panGesture.maximumNumberOfTouches = 1
//         self.view.addGestureRecognizer(panGesture)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    
    private func gestureRecognizerShouldBegin(_ gestureRecognizer: UIPanGestureRecognizer) -> Bool {
        /// Ignore when no view controller is pushed into the navigation stack.
        if self.viewControllers.count <= 1 {
            return false
        }
        /// Ignore pan gesture when the navigation controller is currently in transition.
        if let value = self.navigationController?.value(forKey: "_isTransitioning") as? Bool, value {
            return false
        }
        /// prevent calling the handle when the gesture begins in an opposite direction
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        let isLeftToRight = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight
        let multiplier = isLeftToRight ? 1 : -1
        if  (translation.x * CGFloat(multiplier) <= 0) {
            return false
        }
        return true
    }
}

// MARK: - BaseTabBarController

class BaseTabBarController: ASTabBarController {}
