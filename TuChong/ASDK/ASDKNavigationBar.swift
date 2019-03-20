//  ASDKNavigationBar.swift
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
import AsyncDisplayKit

// MARK: - Protocol

@objc protocol NavigationBarManagerMent: class {
    /// 不使用全局共用导航条, 使用自定义
    @objc optional func createCustomeNavigationBar() -> BaseNavigationBar?
    /// 隐藏/显示
    @objc optional func hiddenTopBar(isHidden: Bool)
}

/// 基类导航条
open class BaseNavigationBar: ASDisplayNode {}

/// 全局公用导航条
open class CommenNavigationBar: BaseNavigationBar {
    
    override init() {
        super.init()
        self.frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: macro.topHeight)
        self.backgroundColor = UIColor.yellow
    }
}
