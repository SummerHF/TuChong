//
//  TutorialDetailProfileCell.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/4/23.
//  Copyright © 2019 Summer. All rights reserved.
//

import AsyncDisplayKit

/// 教程详情 ---- 用户信息
class TutorialDetailProfileCell: ASCellNode {
    
    private let model: Recommend_Feedlist_Eentry_Model
    private let index: IndexPath
    
    private let avatorImageNode: ASNetworkImageNode
    private let vertificationImageNode: ASImageNode
    private let nameTextNode: ASTextNode
    private let publishTimeTextNode: ASTextNode
    private let viewCountBtnNode: ASButtonNode
    
    let avatorWidth: CGFloat = 36
    let vertificationWidth: CGFloat = 12
    let insetForHeader = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    init(post model: Recommend_Feedlist_Eentry_Model, indexPath: IndexPath) {
        self.model = model
        self.index = indexPath
        self.avatorImageNode = ASNetworkImageNode()
        self.vertificationImageNode = ASImageNode()
        self.nameTextNode = ASTextNode()
        self.publishTimeTextNode = ASTextNode()
        self.viewCountBtnNode = ASButtonNode()
        super.init()
        self.automaticallyManagesSubnodes = true
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
