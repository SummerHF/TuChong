//  RecommendCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/12.
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

/// 推荐Cell
class RecommendCellNode: ASCellNode {
    
    private let feenListItem: Recommend_Feedlist_Model
    private let index: Int
    /// node
    private let avatorImageNode: ASNetworkImageNode
    private let vertificationImageNode: ASImageNode
    private let nameTextNode: ASTextNode
    private let verifiedTextNode: ASTextNode
    private let focusBtnNode: ASButtonNode
    /// size
    private let avatorWidth: CGFloat = 36
    private let vertificationWidth: CGFloat = 12
    private let insetForHeader = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

    init(with feenListItem: Recommend_Feedlist_Model, at index: Int) {
        self.feenListItem = feenListItem
        self.index = index
        self.avatorImageNode = ASNetworkImageNode()
        self.vertificationImageNode = ASImageNode()
        self.nameTextNode = ASTextNode()
        self.verifiedTextNode = ASTextNode()
        self.focusBtnNode = ASButtonNode()
        super.init()
        self.selectionStyle = .none
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
        /// avator
        self.avatorImageNode.url = feenListItem.entry.site.iconURL
        self.avatorImageNode.imageModificationBlock = { image in
              image.byRoundCornerRadius(image.size.width / 2.0)
        }
        self.vertificationImageNode.image = R.image.verifications()
        self.nameTextNode.attributedText = NSAttributedString(string: feenListItem.entry.site.name, attributes: [
            NSAttributedString.Key.font: UIFont.boldFont_15(),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ])
        self.nameTextNode.truncationMode = .byTruncatingTail
        self.nameTextNode.maximumNumberOfLines = 1
        self.verifiedTextNode.attributedText = NSAttributedString(string: feenListItem.entry.site.description, attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_10(),
            NSAttributedString.Key.foregroundColor: Color.lightGray
            ])
        self.verifiedTextNode.truncationMode = .byTruncatingTail
        self.verifiedTextNode.maximumNumberOfLines = 1
        /// focus
        self.focusBtnNode.setAttributedTitle(NSAttributedString(string: R.string.localizable.focus(), attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_12(),
            NSAttributedString.Key.foregroundColor: Color.lineColor]), for: .normal)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.avatorImageNode.style.preferredSize = CGSize(width: self.avatorWidth, height: self.avatorWidth)
        self.vertificationImageNode.style.preferredSize = CGSize(width: self.vertificationWidth, height: self.vertificationWidth)
        
        /// Main stack
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
                  /// Header stack with inset
                  ASInsetLayoutSpec(insets: insetForHeader, child:
                          /// Header stack
                         ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
                               /// Whether verified
                            feenListItem.entry.site.verified ? (avatorCornerLayoutSpec()) : avatorImageNode ,
                               /// Whether verified
                            feenListItem.entry.site.verified ? ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .stretch, children: [
                                        nameTextNode.styled({ (style) in
                                        style.flexShrink = 1.0
                                        style.maxWidth = ASDimension(unit: ASDimensionUnit.points, value: 200)
                                        }),
                                        verifiedTextNode.styled({ (style) in
                                        style.flexShrink = 1.0
                                        style.maxWidth = ASDimension(unit: ASDimensionUnit.points, value: 200)
                                         })]) :
                                        nameTextNode.styled({ (style) in
                                        style.flexShrink = 1.0
                                        style.maxWidth = ASDimension(unit: ASDimensionUnit.points, value: 200)
                                        }),
                               /// Spacing between avator and focusBtnNode
                            ASLayoutSpec().styled({ (style) in
                                style.flexGrow = 1.0
                            }),
                            /// focusBtn Node
                            focusBtnNode.styled({ (style) in
                                style.spacingAfter = 0.0
                            })
                         ])
                  )
              ])
    }
    
    /// avator corner layout spec
    private func avatorCornerLayoutSpec() -> ASCornerLayoutSpec {
        let layoutSpec = ASCornerLayoutSpec(child: avatorImageNode, corner: vertificationImageNode, location: ASCornerLayoutLocation.bottomRight)
        layoutSpec.offset = CGPoint(x: -5, y: -5)
        return layoutSpec
    }
}
