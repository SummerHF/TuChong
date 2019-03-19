//
//  AppDelegate+Extension.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/3/19.
//  Copyright © 2019 Summer. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    /// 设置主窗口
    func setKeyWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = HomepageViewController()
        self.window?.makeKeyAndVisible()
    }
}
