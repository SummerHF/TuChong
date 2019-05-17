//  HomeCircleRecommendCell.swift
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

import AsyncDisplayKit

class HomeCircleRecommendCell: BaseCellNode {
    
    private let tag_model: Home_Circle_Tag_Model
    private let index: Int
    private let imageNode: ASNetworkImageNode
    private let tagNameTextNode: ASTextNode
    private let detailTextNode: ASTextNode
    private let focusBtnNode: ASButtonNode
    
    private let insetForStatck = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    private let insetForInfoStack = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0)
    private let focusBtnSize = CGSize(width: 64, height: 28)

    private let imageNodeSize: CGSize = CGSize(width: 64, height: 64)
    
    init(tag_model: Home_Circle_Tag_Model, index: Int) {
        self.tag_model = tag_model
        self.index = index
        self.imageNode = ASNetworkImageNode()
        self.tagNameTextNode = ASTextNode()
        self.detailTextNode = ASTextNode()
        self.focusBtnNode = ASButtonNode()
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        self.imageNode.url = URL(string: tag_model.cover_url)
        self.imageNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(8.0)
        }
        self.focusBtnNode.setBackgroundImage(R.image.small_btn_background(), for: .normal)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.focusBtnNode.setTitle(R.string.localizable.focus(), with: UIFont.normalFont_13(), with: Color.flatWhite, for: .normal)
        
        let statck = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
            self.imageNode.styled({ (style) in
                style.preferredSize = imageNodeSize
            }),
            self.createInfoLayoutSpec(),
            ASLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            self.focusBtnNode.styled({ (style) in
                style.preferredSize = focusBtnSize
            })
        ])
        return ASInsetLayoutSpec(insets: insetForStatck, child: statck)
    }
    
    private func createInfoLayoutSpec() -> ASLayoutSpec {
        self.tagNameTextNode.setAttributdWith(string: "#\(tag_model.tag_name)", font: UIFont.normalFont_14(), color: Color.thinBlack)
        self.detailTextNode.setAttributdWith(string: tag_model.detail_info, font: UIFont.normalFont_12(), color: Color.lightGray)
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 2, justifyContent: .start, alignItems: .stretch, children: [
            self.tagNameTextNode,
            self.detailTextNode
        ])
        return ASInsetLayoutSpec(insets: insetForInfoStack, child: stack)
    }
}
