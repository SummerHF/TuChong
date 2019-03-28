//  String+Extension.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/19.
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

import Foundation

// MARK: - Helpers

public extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

public extension Int {
    
    /// 产生随机数
    /// [0, upper)
    static func randomIntValue(upper: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper)))
    }
}

public extension UILabel {
    
    /// 快速创建lable
    static func lable(with title: String? = "", font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = UIColor.white) -> UILabel {
        let lable = UILabel()
        lable.text = title
        lable.font = font
        lable.textColor = textColor
        return lable
    }
    
    /// 快速赋值
     public func setLable(with title: String? = "", font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = UIColor.black) {
        self.text = title
        self.font = font
        self.textColor = textColor
    }
}
