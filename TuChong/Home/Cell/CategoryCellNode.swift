//  CategoryCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/18.
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

class CategoryCellNode: ASCellNode {
    
    let postListItem: Recommend_Feedlist_Eentry_Model
    let index: Int
    let imageNode: ASNetworkImageNode
    let avatorImageNode: ASNetworkImageNode
    let vertificationImageNode: ASImageNode
    let nameTextNode: ASTextNode
    let favoriteBtnNode: ASButtonNode
    let imageCountBtnNode: ASButtonNode
    
    let vertificationWidth: CGFloat = 12
    let insetForImageNode: UIEdgeInsets = UIEdgeInsets.zero
    let insetForImageCountBtnNode: UIEdgeInsets = UIEdgeInsets(top: 5, left: CGFloat.infinity, bottom: CGFloat.infinity, right: 5)
    let imageCountBtnNodeBackgroundImageSize = CGSize(width: 18, height: 18)
    
    init(with postListItem: Recommend_Feedlist_Eentry_Model, at index: Int) {
        self.postListItem = postListItem
        self.index = index
        self.imageNode = ASNetworkImageNode()
        self.avatorImageNode = ASNetworkImageNode()
        self.vertificationImageNode = ASImageNode()
        self.nameTextNode = ASTextNode()
        self.favoriteBtnNode = ASButtonNode()
        self.imageCountBtnNode = ASButtonNode()
        super.init()
        self.automaticallyManagesSubnodes = true
        self.nameTextNode.isLayerBacked = true
        self.vertificationImageNode.isLayerBacked = true
    }
    
    override func didLoad() {
        super.didLoad()
        self.imageNode.url = URL(string: postListItem.image_cover)
        self.avatorImageNode.url = postListItem.site.iconURL
        self.imageNode.imageModificationBlock = {
            image in
            image.byRoundCornerRadius(8.0)
        }
        self.avatorImageNode.contentMode = .scaleAspectFit
        self.avatorImageNode.imageModificationBlock = {
            image in
            image.byRoundCornerRadius(image.size.width / 2.0)
        }
        self.vertificationImageNode.image = postListItem.site.verified_image
        self.nameTextNode.setAttributdWith(string: postListItem.site.name, font: UIFont.normalFont_10())
        self.favoriteBtnNode.setImage(R.image.favorite(), for: .normal)
        self.favoriteBtnNode.contentSpacing = 4.0
        /// favorite count more than `Zero`
        if postListItem.favorites > 0 {
            self.favoriteBtnNode.setAttributdWith(string: "\(postListItem.favorites)", font: UIFont.normalFont_10(), state: .normal)
        }
        
        if postListItem.image_count > 0 {
            let image = UIImage.init(color: RGBA(R: 0, G: 0, B: 0, A: 0.5), size: imageCountBtnNodeBackgroundImageSize)?.byRoundCornerRadius(imageCountBtnNodeBackgroundImageSize.width / 2.0)
            self.imageCountBtnNode.setAttributdWith(string: "\(postListItem.image_count)", font: UIFont.normalFont_10(), color:Color.flatWhite,  state: .normal)
            self.imageCountBtnNode.setBackgroundImage(image, for: .normal)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.avatorImageNode.style.preferredSize = CGSize(width: 26, height: 26)
        self.vertificationImageNode.style.preferredSize = CGSize(width: self.vertificationWidth, height: self.vertificationWidth)
        self.imageCountBtnNode.style.preferredSize = imageCountBtnNodeBackgroundImageSize
        /// Main stack
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: mainLayoutSpec())
        
      }
    
    /// Main layoutSpec
    private func mainLayoutSpec() -> ASLayoutSpec {
        if postListItem.image_count > 0 {
            return ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: insetForImageCountBtnNode, child: imageCountBtnNode), background:
                /// Vertical Stack
                ASStackLayoutSpec(direction: .vertical, spacing: 4.0, justifyContent: .start, alignItems: .stretch, children: [
                    createImageNodeLayoutSpec(),
                    createProfileLayoutSpec()
                    ])
            )
        } else {
            return /// Vertical Stack
                    ASStackLayoutSpec(direction: .vertical, spacing: 4.0, justifyContent: .start, alignItems: .stretch, children: [
                    createImageNodeLayoutSpec(),
                    createProfileLayoutSpec()
                    ])
           }
    }
    
    /// Photo layoutSpec
    private func createImageNodeLayoutSpec() -> ASLayoutSpec {
        let ratioLayoutSpec = ASRatioLayoutSpec(ratio: postListItem.image_cover_ratio, child: self.imageNode)
        return ratioLayoutSpec
    }
    
    /// Profile area layoutSpec
    private func createProfileLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .center, children: [
            postListItem.site.verified ? avatorCornerLayoutSpec() : avatorImageNode,
            nameTextNode,
            ASLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            self.favoriteBtnNode.styled({ (style) in
                style.spacingAfter = 0.0
            })
       ])
    }
    
    /// Avator corner layout spec
    func avatorCornerLayoutSpec() -> ASCornerLayoutSpec {
        let layoutSpec = ASCornerLayoutSpec(child: avatorImageNode, corner: vertificationImageNode, location: ASCornerLayoutLocation.bottomRight)
        layoutSpec.offset = CGPoint(x: -5, y: -5)
        return layoutSpec
    }
}
