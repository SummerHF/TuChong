//  Color.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/28.
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
import ChameleonFramework

/// use this method to create color fast
func RGBA(R: CGFloat, G: CGFloat, B: CGFloat, A: CGFloat = 1.0) -> UIColor {
    return UIColor.init(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: A)
}

struct Color {
    /// 主题颜色
    static var themeColor = UIColor.white
    static var backGroundColor = UIColor.white
    static var black = UIColor.black
    static var lightGray = RGBA(R: 133, G: 133, B: 135)
    static var thinGray = RGBA(R: 243, G: 243, B: 243)
    static var flatWhite = RGBA(R: 255, G: 255, B: 255, A: 0.9)
    static var lineColor = RGBA(R: 239, G: 45, B: 88)
    static var eqipBackGroundColor = RGBA(R: 251, G: 251, B: 251)
    static var eqipBorderColor = RGBA(R: 220, G: 220, B: 220)
    static var orangerColor = RGBA(R: 247, G: 134, B: 100)
}
