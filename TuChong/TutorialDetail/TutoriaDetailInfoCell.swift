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
class TutoriaDetailInfoCell: ASCellNode {
    
    private let model: Recommend_Feedlist_Eentry_Model
    private let index: IndexPath
    private let insetForTags = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private let spaceing: CGFloat = 10
    
    init(post model: Recommend_Feedlist_Eentry_Model, indexPath: IndexPath) {
        self.model = model
        self.index = indexPath
        super.init()
        self.automaticallyManagesSubnodes = true
    }

    override func didLoad() {
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: insetForTags, child: createTagsLayoutSpec())
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
        return ASAbsoluteLayoutSpec(children: tagNodeArray)
    }
    
    /// Tag node event
    @objc private func tagNodeEvent(node: TutorialDetailInfoTagBtnNode) {
        printLog(node.index)
    }
}
