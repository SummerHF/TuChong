//  RecommendTopCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/17.
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

class RecommendTopCellNode: RecommendBaseCellNode {
    
    private let titleNameTextNode: ASTextNode
    private let moreTextNode: ASTextNode

    override init(with feenListItem: Recommend_Feedlist_Model, at index: Int) {
        self.titleNameTextNode = ASTextNode()
        self.moreTextNode = ASTextNode()
        super.init(with: feenListItem, at: index)
    }
    
    override func didLoad() {
        super.didLoad()
        self.titleNameTextNode.setAttributdWith(string: R.string.localizable.circle(), font: UIFont.boldFont_13())
        self.moreTextNode.setAttributdWith(string: R.string.localizable.to_view_more(), font: UIFont.normalFont_13(), color: Color.lightGray)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
                ASInsetLayoutSpec(insets: insetForHeader, child:
                    ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
                        self.titleNameTextNode,
                        ASLayoutSpec().styled({ (style) in
                            style.flexGrow = 1.0
                        }),
                        self.moreTextNode.styled({ (style) in
                            style.spacingAfter = 0.0
                        })
                     ])
                  )
            ])
      }
}
