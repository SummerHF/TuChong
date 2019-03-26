//  AppDelegate+Extension.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/20.
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

extension AppDelegate {

    /// 设置主窗口
    func setKeyWindow() {
        let tabBarController = BaseTabBarController()
        let homeNavgationController = BaseNavigationController(rootViewController: HomeContainerViewController())
        homeNavgationController.tabBarItem.title = "哈哈"
        tabBarController.viewControllers = [homeNavgationController]
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    /// 设置开机广告
    func setLaunchAdvertiseMent() {
        LaunchManager.manager.show()
    }
}
