//  TutorialDetailInfoTagBtnNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/25.
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

import AsyncDisplayKit

class TutorialDetailInfoTagBtnNode: ASButtonNode {
    
    override var isHighlighted: Bool {
        set {
            
        }
        get {
            return false
        }
    }
    
    private let item: Recommend_Feedlist_Tags_Model
    private let index: Int
    
    private let floatWidth: CGFloat = 28
    private let fontSize: UIFont = UIFont.normalFont_14()
    private let btnNodeHeight: CGFloat = 24
    
    private var btnNodeWidth: CGFloat {
        return item.tag_name.size(withAttributes: [NSAttributedString.Key.font: fontSize]).width + floatWidth
    }

    var nodeSize: CGSize {
        return CGSize(width: btnNodeWidth, height: btnNodeHeight)
    }
    
    init(tag: Recommend_Feedlist_Tags_Model, index: Int) {
        self.item = tag
        self.index = index
        super.init()
        self.setAttributdWith(string: tag.tag_name, font: fontSize, color: Color.lightGray, state: .normal)
        self.backgroundColor = Color.thinGray
    }
}
