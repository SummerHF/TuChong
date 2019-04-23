//  RecommendTutorialCell.swift
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

private enum TutorialCellType {
    case text
    case profile
}

class RecommendTutorialCell: ASCellNode {
    
    private let postListItem: Tutorial_List_Model
    private let index: Int
    private let imageNode: ASNetworkImageNode
    private let titleNode: ASTextNode
    private let contentNode: ASTextNode
    private let avatorImageNode: ASNetworkImageNode
    private let nameTextNode: ASTextNode

    private let insetForTitleArea: UIEdgeInsets = UIEdgeInsets(top: 20, left: 120, bottom: 20, right: 10)
    private let insetForImageNode: UIEdgeInsets = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: CGFloat.infinity)
    private let insetForProfileArea: UIEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    private let imageNodeSize: CGSize = CGSize(width: 100, height: 100)
    private let avatorImageNodeSize: CGSize = CGSize(width: 30, height: 30)
    private let viewCountBtnNode: ASButtonNode
    
    /// `Text` or `Profile`
    private var cellType: TutorialCellType {
        return index % 2 == 0 ? .text : .profile
    }

    init(with postListItem: Tutorial_List_Model, at index: Int) {
        self.postListItem = postListItem
        self.index = index
        self.imageNode = ASNetworkImageNode()
        self.titleNode = ASTextNode()
        self.contentNode = ASTextNode()
        self.avatorImageNode = ASNetworkImageNode()
        self.nameTextNode = ASTextNode()
        self.viewCountBtnNode = ASButtonNode()
        super.init()
        self.imageNode.isLayerBacked = true
        self.titleNode.isLayerBacked = true
        self.automaticallyManagesSubnodes = true
        self.avatorImageNode.isLayerBacked = true
        self.nameTextNode.isLayerBacked = true 
    }
    
    override func didLoad() {
        super.didLoad()
        
        if self.cellType == .text {
            self.imageNode.url = URL(string: postListItem.post.image_srcs_cover)
            self.titleNode.setAttributdWith(string: postListItem.post.title, font: UIFont.normalFont_18())
            self.contentNode.setAttributdWith(string: postListItem.post.excerpt, font: UIFont.normalFont_13())
            self.titleNode.maximumNumberOfLines = 2
            self.contentNode.maximumNumberOfLines = 3
            self.nameTextNode.maximumNumberOfLines = 1
        } else {
            /// user area
            self.avatorImageNode.url = postListItem.post.site.iconURL
            self.avatorImageNode.imageModificationBlock = {
                image in
                image.byRoundCornerRadius(image.size.width / 2.0)
            }
            self.nameTextNode.setAttributdWith(string: postListItem.post.site.name, font: UIFont.normalFont_13())
            self.viewCountBtnNode.setAttributdWith(string: "\(postListItem.post.views)", font: UIFont.normalFont_13(), color: Color.lightGray, state: .normal)
            self.viewCountBtnNode.setImage(R.image.view_count(), for: .normal)
            self.viewCountBtnNode.contentSpacing = 4.0
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
            self.cellType == .text ? createDescribtionAreaLayoutSpec() : createProfileLayoutSpec()
        ])
    }
    
    /// Main Layout for text area
    private func createDescribtionAreaLayoutSpec() -> ASLayoutSpec {
        self.imageNode.style.preferredSize = imageNodeSize
        let describtionAreaLayoutSpec = ASInsetLayoutSpec(insets: insetForTitleArea, child:
               ASStackLayoutSpec(direction: .vertical, spacing: 0.0, justifyContent: .start, alignItems: .start, children: [
                self.titleNode,
                ASLayoutSpec().styled({ (style) in
                    style.flexGrow = 1.0
                }),
                self.contentNode
            ])
        )
        return ASOverlayLayoutSpec(child: ASInsetLayoutSpec(insets: insetForImageNode, child: self.imageNode), overlay: describtionAreaLayoutSpec)
    }
    
    /// Profile Area, include avator and name
    private func createProfileLayoutSpec() -> ASLayoutSpec {
        self.avatorImageNode.style.preferredSize = avatorImageNodeSize
        return ASInsetLayoutSpec(insets: insetForProfileArea, child:
            ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
                self.avatorImageNode,
                self.nameTextNode,
                ASLayoutSpec().styled({ (style) in
                    style.flexGrow = 1.0
                }),
                self.viewCountBtnNode.styled({ (style) in
                    style.spacingAfter = 0.0
                })
           ])
        )
     }
}
