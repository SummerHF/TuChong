//  TutorialDetailProfileCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/23.
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

/// 教程详情 ---- 用户信息
class TutorialDetailProfileCell: BaseAScellNode {
    
    private let model: Recommend_Feedlist_Eentry_Model
    private let index: IndexPath
    
    private let avatorImageNode: ASNetworkImageNode
    private let vertificationImageNode: ASImageNode
    private let nameTextNode: ASTextNode
    private let publishTimeTextNode: ASTextNode
    private let viewCountBtnNode: ASButtonNode
    
    private let avatorWidth: CGFloat = 36
    private let vertificationWidth: CGFloat = 12
    private let insetForHeader = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    init(post model: Recommend_Feedlist_Eentry_Model, indexPath: IndexPath) {
        self.model = model
        self.index = indexPath
        self.avatorImageNode = ASNetworkImageNode()
        self.vertificationImageNode = ASImageNode()
        self.nameTextNode = ASTextNode()
        self.publishTimeTextNode = ASTextNode()
        self.viewCountBtnNode = ASButtonNode()
        super.init()
        self.publishTimeTextNode.isLayerBacked = true
        self.nameTextNode.isLayerBacked = true
        self.vertificationImageNode.isLayerBacked = true
        self.viewCountBtnNode.isEnabled = false
    }
    
    override func didLoad() {
        super.didLoad()
        /// avator
        self.avatorImageNode.url = model.site.iconURL
        //// ASImageNodeRoundBorderModificationBlock(1.0, color), create rounded image
        self.avatorImageNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(image.size.width / 2.0)
        }
        self.vertificationImageNode.image = model.site.verified_image
        self.nameTextNode.setAttributdWith(string: model.site.name, font: UIFont.normalFont_15())
        self.nameTextNode.truncationMode = .byTruncatingTail
        self.nameTextNode.maximumNumberOfLines = 1
        self.publishTimeTextNode.setAttributdWith(string: model.published_at.offsetTime(), font: UIFont.normalFont_14(), color: Color.lightGray)
        self.viewCountBtnNode.setAttributdWith(string: "\(model.views) 阅读", font: UIFont.normalFont_13(), color: Color.lightGray, state: .normal)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.avatorImageNode.style.preferredSize = CGSize(width: self.avatorWidth, height: self.avatorWidth)
        self.vertificationImageNode.style.preferredSize = CGSize(width: self.vertificationWidth, height: self.vertificationWidth)
        
        return ASInsetLayoutSpec(insets: insetForHeader, child:
            /// Header stack with inset
                ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
                    model.site.verified ? avatorCornerLayoutSpec() : avatorImageNode,
                    nameLayoutSpec(),
                    ASLayoutSpec().styled({ (style) in
                        style.flexGrow = 1.0
                    }),
                    self.viewCountBtnNode.styled({ (style) in
                        style.spacingAfter = 0.0
                    })
                ]
            )
        )
    }
    
    /// Avator corner layout spec
    private func avatorCornerLayoutSpec() -> ASCornerLayoutSpec {
        let layoutSpec = ASCornerLayoutSpec(child: avatorImageNode, corner: vertificationImageNode, location: ASCornerLayoutLocation.bottomRight)
        layoutSpec.offset = CGPoint(x: -5, y: -5)
        return layoutSpec
    }
    
    /// Name layout spec
    private func nameLayoutSpec() -> ASLayoutSpec {
        let layoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            self.nameTextNode.styled({ (style) in
                style.flexShrink = 1.0
                style.maxWidth = ASDimension(unit: ASDimensionUnit.points, value: 200)
            }),
            self.publishTimeTextNode
            ])
        return layoutSpec
    }
}
