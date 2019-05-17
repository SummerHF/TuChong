//  HomeCircleContainer.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/17.
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

class HomeCircleContainer: UIScrollView {
    
    private let recommendTableNode = HomeCircleRecommendTableNode()
    private let focusTableNode = HomeCircleFocusTableNode()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.backGroundColor
        self.showsHorizontalScrollIndicator = false
        self.isPagingEnabled = true
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubnode(recommendTableNode)
        self.addSubnode(focusTableNode)
        /// set frame
        self.recommendTableNode.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        self.focusTableNode.frame = CGRect(x: self.width, y: 0, width: self.width, height: self.height)
        /// set contentSize
        self.contentSize = CGSize(width: self.width * 2.0, height: self.height)
    }
}
