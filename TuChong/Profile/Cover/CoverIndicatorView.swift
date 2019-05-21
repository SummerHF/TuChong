//  CoverIndicatorView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/7.
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

class CoverIndicatorView: UIView {
    
    lazy var indicator: UIView = {
        let indicator = UIView()
        return indicator
    }()
    
    var bgColor: UIColor {
        get {
            return RGBA(R: 133, G: 133, B: 135, A: 0.6)
        }
        set {
            self.backgroundColor = newValue
        }
    }
    
    var indicatorBgColor: UIColor {
        get {
            return Color.flatWhite
        }
        set {
            self.indicator.backgroundColor = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = bgColor
        self.indicator.backgroundColor = indicatorBgColor
        self.indicator.frame = CGRect(x: 0, y: 0, width: 0, height: frame.size.height)
        self.addSubview(indicator)
        self.layer.cornerRadius = frame.size.height / 2.0
        self.clipsToBounds = true
    }
    
    func triggerAnimation(with percent: CGFloat, animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.indicator.width = self.width * percent
            }
        } else {
            self.indicator.width = self.width * percent
        }
    }
}
