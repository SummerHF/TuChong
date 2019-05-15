//  ProfileEventsCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/10.
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

class ProfileEventsCellNode: BaseCellNode {
    
    private let post_list: Recommend_Feedlist_Eentry_Model
    private let index: IndexPath
    private let imageNode: ASNetworkImageNode
    private let titleTextNode: ASTextNode
    private let publishTimeTextNode: ASTextNode
    /// 喜欢 + 评论
    private let summaryTextNode: ASTextNode

    private let margin: CGFloat = 10.0
    private let insetForImageNode = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    private let imageNodeSize = CGSize(width: 72, height: 72)
    
    init(post_list: Recommend_Feedlist_Eentry_Model, indexPath: IndexPath) {
        self.post_list = post_list
        self.index = indexPath
        self.imageNode = ASNetworkImageNode()
        self.titleTextNode = ASTextNode()
        self.publishTimeTextNode = ASTextNode()
        self.summaryTextNode = ASTextNode()
        super.init()
        self.selectionStyle = .default
    }
    
    override func didLoad() {
        super.didLoad()
        self.titleTextNode.maximumNumberOfLines = 1
        self.imageNode.url = post_list.setCoverUrl(with: "g")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.imageNode.style.preferredSize = imageNodeSize
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
                self.imageNode,
                self.createImageDescLayoutSpec()
            ])
        return ASInsetLayoutSpec(insets: insetForImageNode, child: stack)
    }
    
    private func createImageDescLayoutSpec() -> ASLayoutSpec {
        self.titleTextNode.setAttributdWith(string: post_list.title, font: UIFont.normalFont_14())
        self.publishTimeTextNode.setAttributdWith(string: post_list.published_at.offsetTime(), font: UIFont.normalFont_12(), color: Color.lightGray)
        self.summaryTextNode.setAttributdWith(string: post_list.summary_desc, font: UIFont.normalFont_12(), color: Color.lightGray)
        
        let verticalStack = ASStackLayoutSpec(direction: .vertical, spacing: 15, justifyContent: .start, alignItems: .stretch, children: [
            self.titleTextNode.styled({ (style) in
                style.maxWidth = ASDimensionMake(200)
            }),
            self.publishTimeTextNode,
            self.summaryTextNode
        ])
        return verticalStack
    }
}
