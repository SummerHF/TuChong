//  PhotographyGroupCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/5.
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

class PhotographyGroupCell: BaseCellNode {
    
    private let item: Photography_Group_Item_Model
    private let index: Int
    /// header
    private let imageNode: ASNetworkImageNode
    private let groupNameTextNode: ASTextNode
    private let groupInfoTextNode: ASTextNode
    private let joinBtnNode: ASButtonNode
    /// intro
    private let introTextNode: ASTextNode

    var group_intro: String {
        return "\(item.members)成员  \(item.group_posts)作品"
    }
    
    private let groupNameTextNodeMaxWidth: CGFloat = 200
    private let imageNodeSize = CGSize(width: 40, height: 40)
    private let insetForInfo: UIEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    private let joinBtnNodeSize: CGSize = CGSize(width: 60, height: 24)

    init(item: Photography_Group_Item_Model, index: Int) {
        self.item = item
        self.index = index
        self.imageNode = ASNetworkImageNode()
        self.groupNameTextNode = ASTextNode()
        self.groupInfoTextNode = ASTextNode()
        self.joinBtnNode = ASButtonNode()
        self.introTextNode = ASTextNode()
        super.init()
        self.selectionStyle = .none
        self.setPropertys()
    }
    
    override func setPropertys() {
        imageNode.style.preferredSize = imageNodeSize
        groupNameTextNode.setAttributdWith(string: item.name, font: UIFont.normalFont_16())
        groupInfoTextNode.setAttributdWith(string: group_intro, font: UIFont.normalFont_14(), color: Color.lightGray)
        groupNameTextNode.maximumNumberOfLines = 2
        groupNameTextNode.style.maxWidth = ASDimensionMakeWithPoints(groupNameTextNodeMaxWidth)
        
        /// intro
        introTextNode.setAttributdWith(string: item.description, font: UIFont.normalFont_13(), color: Color.lightGray)
        introTextNode.maximumNumberOfLines = 2
        introTextNode.truncationMode = .byTruncatingTail
    }
    
    override func didLoad() {
        super.didLoad()
        self.imageNode.url = URL(string: item.icon_url)
        self.joinBtnNode.setAttributdWith(string: R.string.localizable.join(), font: UIFont.normalFont_14(), color: Color.backGroundColor, state: .normal)
        self.joinBtnNode.backgroundColor = Color.lineColor
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            createLayoutForHeader(),
            introTextNode,
            createImageLayoutSpec()
            ])
        return ASInsetLayoutSpec(insets: insetForInfo, child: stackLayoutSpec)
    }
    
    /// Header layout
    private func createLayoutForHeader() -> ASLayoutSpec {
        joinBtnNode.add(cornerRadius: joinBtnNodeSize.height / 2.0, backgroundColor: Color.backGroundColor, cornerRoundingType: .clipping)
        return ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
                self.imageNode,
                self.createLayoutForGroupInfo(),
                ASLayoutSpec().styled({ (style) in
                    style.flexGrow = 1.0
                }),
                self.joinBtnNode.styled({ (style) in
                    style.spacingAfter = 0.0
                    style.preferredSize = joinBtnNodeSize
                })
            ])
    }
    
    /// Group info layout
    private func createLayoutForGroupInfo() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 5.0, justifyContent: .start, alignItems: .stretch, children: [
            self.groupNameTextNode,
            ASLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            self.groupInfoTextNode.styled({ (style) in
                style.spacingAfter = 0.0
            })
            ]
        )
    }
    
    /// Images layout
    private func createImageLayoutSpec() -> ASLayoutSpec {
        let spacing: CGFloat = 4.0
        let count = 3
        var imageNodes: [ASNetworkImageNode] = []
        let width = (macro.screenWidth - (insetForInfo.left + insetForInfo.right + CGFloat(count - 1) * spacing)) / CGFloat(count)
        for item in item.posts_list {
            let imageNode = ASNetworkImageNode()
            imageNode.style.preferredSize = CGSize(width: width, height: width)
            imageNode.url = URL(string: item.cover_image.url)
            imageNodes.append(imageNode)
        }
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: ASStackLayoutSpec(direction: .horizontal, spacing: spacing, justifyContent: .start, alignItems: .stretch, children: imageNodes))
    }
}
