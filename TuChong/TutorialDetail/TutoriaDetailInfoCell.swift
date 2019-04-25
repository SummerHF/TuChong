//  TutoriaDetailInfoCell.swift
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

/// 教程详情 ---- tags, likes, rewards
class TutoriaDetailInfoCell: BaseAScellNode {
    
    private let model: Recommend_Feedlist_Eentry_Model
    private let index: IndexPath
    private let insetForTags = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private let spaceing: CGFloat = 10
    
    private let likeCountBtnNode: ASButtonNode
    
    init(post model: Recommend_Feedlist_Eentry_Model, indexPath: IndexPath) {
        self.model = model
        self.index = indexPath
        self.likeCountBtnNode = ASButtonNode()
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        self.likeCountBtnNode.setAttributedTitle(model.favorites_desc, for: .normal)
    }
    
    /// Main layout spec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
                   test(),  
                   self.likeCountBtnNode.styled({ (style) in
                        style.spacingBefore = spaceing
                   })
            ])
    }
    
    /// Tags layout spec
    private func createTagsLayoutSpec() -> ASLayoutSpec {
        let tagNodeArray = TutorialDetailInfoTagBtnNode.createTagsLayoutSpec(with: model.tags)
        let width: CGFloat = macro.screenWidth - insetForTags.left - insetForTags.right
        var lastNode: TutorialDetailInfoTagBtnNode?
        var tagNodeX: CGFloat = 0
        var tagNodeY: CGFloat = 0
        for tagNode in tagNodeArray {
            if lastNode != nil {
                /// need to change line
                if tagNodeX + tagNode.nodeSize.width > width {
                    tagNodeY += tagNode.nodeSize.height + spaceing
                    tagNodeX = tagNode.nodeSize.width + spaceing
                    tagNode.style.layoutPosition = CGPoint(x: 0, y: tagNodeY)
                } else {
                    tagNode.style.layoutPosition = CGPoint(x: tagNodeX, y: tagNodeY)
                    tagNodeX += tagNode.nodeSize.width + spaceing
                }
                lastNode = tagNode
            } else {
                tagNode.style.layoutPosition = CGPoint(x: 0, y: 0)
                tagNodeX = tagNode.nodeSize.width + spaceing
                tagNodeY = 0
                lastNode = tagNode
            }
            /// add tagNode event
            tagNode.addTarget(self, action: #selector(tagNodeEvent(node:)), forControlEvents: .touchUpInside)
        }
        return ASInsetLayoutSpec(insets: insetForTags, child: ASAbsoluteLayoutSpec(children: tagNodeArray))
    }
    
    /// Tag node event
    @objc private func tagNodeEvent(node: TutorialDetailInfoTagBtnNode) {
        printLog(">")
    }
    
    private func test() -> ASLayoutSpec {
        let tagNodeArray = TutorialDetailInfoTagBtnNode.createTagsLayoutSpec(with: model.tags)
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start, children: tagNodeArray)
        stack.flexWrap = .wrap
        stack.lineSpacing = spaceing
        return stack
    }
}
