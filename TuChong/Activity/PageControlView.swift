//  PageControlView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/20.
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

// MARK: - PageDotView

final class PageDotView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = frame.height / 2.0
        self.clipsToBounds = true
        self.backgroundColor = Color.dotColor
    }
}

// MARK: - PageControlView
/// 分页指示器视图

final class PageControlView: UIView {
    
    private let count: Int
    
    private var dot_attay: [PageDotView] = []
    private var indicator: UIView?
    
    private let padding: CGFloat = 10
    private let content_height: CGFloat = 10
    private let indicator_width: CGFloat = 12
    private let dot_width: CGFloat = 5
    private let dot_height: CGFloat = 5
    private let left_margin: CGFloat = 10
    private let right_margin: CGFloat = 10
    private let bottom_margin: CGFloat = 10
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(count: Int, frame: CGRect) {
        /// propertys
        self.count = count
        /// size
        let w = CGFloat(count - 1) * padding + CGFloat(count) * dot_width + right_margin + left_margin
        let h = content_height
        let x = (frame.width - w) / 2.0
        let y = frame.height - h - bottom_margin
        let frames = CGRect(x: x, y: y, width: w, height: h)
        super.init(frame: frames)
        self.setPropertys()
    }
    
    func setPropertys() {
        let y = (content_height - dot_height) / 2.0
        for i in 0..<count {
            var x: CGFloat = 0.0
            if 0 == i {
                x = left_margin
            } else {
                x = left_margin + CGFloat(i) * (dot_width + padding)
            }
            let dot = PageDotView(frame: CGRect(x: x, y: y, width: dot_width, height: dot_height))
            addSubview(dot)
            dot_attay.append(dot)
        }
        /// 默认指向0
        self.changeIndicatorWith(index: 0)
    }
    
    func changeIndicatorWith(index: Int) {
        guard index < dot_attay.count else { return }
        let dot = self.dot_attay[index]
        if let indicatorView = self.indicator {
            indicatorView.center = dot.center
        } else {
            let indicatorView = UIView()
            indicatorView.backgroundColor = Color.flatWhite
            indicatorView.size = CGSize(width: indicator_width, height: dot_height)
            indicatorView.center = self.dot_attay[0].center
            indicatorView.layer.cornerRadius = dot_height / 2.0
            indicatorView.clipsToBounds = true
            self.addSubview(indicatorView)
            self.indicator = indicatorView
        }
    }
}
