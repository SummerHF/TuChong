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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
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
    }
}

// MARK: - BaseTabBarController

class BaseTabBarController: ASTabBarController {}
