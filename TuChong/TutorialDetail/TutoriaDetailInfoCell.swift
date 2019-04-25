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
        return createTagsLayoutSpec()
    }
    
    /// Tags layout spec
    private func createTagsLayoutSpec() -> ASLayoutSpec {
        var tagNodeArray: [TutorialDetailInfoTagBtnNode] = []
        for tag in model.tags {
            let btnNode = TutorialDetailInfoTagBtnNode(tag: tag, index: 0)
            btnNode.style.preferredSize = btnNode.nodeSize
            btnNode.cornerRoundingType = .defaultSlowCALayer
            btnNode.cornerRadius = btnNode.nodeSize.height / 2.0
            tagNodeArray.append(btnNode)
        }
        
        return ASInsetLayoutSpec(insets: insetForTags, child: ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start, children: ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition, verticalPosition: <#T##ASRelativeLayoutSpecPosition#>, sizingOption: <#T##ASRelativeLayoutSpecSizingOption#>, child: <#T##ASLayoutElement#>)))
    }
}
