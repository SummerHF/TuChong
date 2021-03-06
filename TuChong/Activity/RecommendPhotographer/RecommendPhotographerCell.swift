//  RecommendPhotographerCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/29.
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

class RecommendPhotographerCell: BaseCellNode {
    
    private let author: Recommend_Feedlist_Site_Model
    private let index: Int
    
    /// node
    let avatorImageNode: ASNetworkImageNode
    let vertificationImageNode: ASImageNode
    let nameTextNode: ASTextNode
    let verifiedTextNode: ASTextNode
    let followNode: ASButtonNode
    
    /// size
    let avatorWidth: CGFloat = 32
    let vertificationWidth: CGFloat = 12
    let insetForHeader = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    let insetForImages = UIEdgeInsets(top: 20, left: 20, bottom: 15, right: 20)
    let followNodeWidth: CGFloat = 72
    let followNodeHeight: CGFloat = 24

    init(author: Recommend_Feedlist_Site_Model, index: Int) {
        self.author = author
        self.index = index
        self.avatorImageNode = ASNetworkImageNode()
        self.vertificationImageNode = ASImageNode()
        self.nameTextNode = ASTextNode()
        self.verifiedTextNode = ASTextNode()
        self.followNode = ASButtonNode()
        super.init()
        self.selectionStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
        self.avatorImageNode.url = author.iconURL
        self.avatorImageNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(image.size.width / 2.0)
        }
        self.vertificationImageNode.image = author.recommend_photographer_verified_image
        self.followNode.setAttributdWith(string: R.string.localizable.attention(), font: UIFont.normalFont_13(), color: Color.flatWhite, state: .normal)
        self.followNode.backgroundColor = Color.lineColor
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
                createHeaderLayoutSpec(),
                createImageLayoutSpec()
            ])
    }
    
    private func createHeaderLayoutSpec() -> ASLayoutSpec {
        self.avatorImageNode.style.preferredSize = CGSize(width: avatorWidth, height: avatorWidth)
        self.vertificationImageNode.style.preferredSize = CGSize(width: vertificationWidth, height: vertificationWidth)
        self.followNode.add(cornerRadius: followNodeHeight / 2.0, backgroundColor: Color.backGroundColor, cornerRoundingType: .clipping)
        
        return ASInsetLayoutSpec(insets: insetForHeader, child:
            ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
            /// Whether verified
            author.recommend_photographer_verified ? (avatorCornerLayoutSpec()) : avatorImageNode,
            userProfileLayoutSpec(),
            ASLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            followNode.styled({ (style) in
                style.preferredSize = CGSize(width: followNodeWidth, height: followNodeHeight)
                style.spacingAfter = 0.0
            })
         ])
       )
    }
    
    /// Images layout
    private func createImageLayoutSpec() -> ASLayoutSpec {
        var imageNodes: [ASNetworkImageNode] = []
        let width = (macro.screenWidth - (insetForHeader.left + insetForHeader.right + CGFloat(author.images.count - 1) * 10.0)) / CGFloat(author.images.count)
        for url in author.images {
            let imageNode = ASNetworkImageNode()
            imageNode.style.preferredSize = CGSize(width: width, height: width)
            imageNode.url = URL(string: url)
            imageNodes.append(imageNode)
        }
        return ASInsetLayoutSpec(insets: insetForImages, child: ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .stretch, children: imageNodes))
    }
    
    /// Avator corner layout spec
    func avatorCornerLayoutSpec() -> ASCornerLayoutSpec {
        let layoutSpec = ASCornerLayoutSpec(child: avatorImageNode, corner: vertificationImageNode, location: ASCornerLayoutLocation.bottomRight)
        layoutSpec.offset = CGPoint(x: -5, y: -5)
        return layoutSpec
    }
    
    /// User name and verified area
    func userProfileLayoutSpec() -> ASLayoutSpec {
        self.nameTextNode.setAttributdWith(string: author.name, font: UIFont.normalFont_14())
        self.verifiedTextNode.setAttributdWith(string: author.recommend_photographer_verified_reason ?? "", font: UIFont.normalFont_13(), color: Color.lightGray)
        if author.recommend_photographer_verified_reason != nil {
            return ASStackLayoutSpec(direction: .vertical, spacing: 1.0, justifyContent: .start, alignItems: .stretch, children: [
                 self.nameTextNode.styled({ (style) in
                    style.flexShrink = 1.0
                    style.maxWidth = ASDimension(unit: ASDimensionUnit.points, value: 200)
                 }),
                  ASLayoutSpec().styled({ (style) in
                    style.flexGrow = 1.0
                  }),
                  self.verifiedTextNode.styled({ (style) in
                    style.maxWidth = ASDimension(unit: ASDimensionUnit.points, value: 200)
                    style.flexShrink = 1.0
                  })
                ])
        } else {
            return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .center, children: [
                self.nameTextNode
           ])
        }
    }
}
