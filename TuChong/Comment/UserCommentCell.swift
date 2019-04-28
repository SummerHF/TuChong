//  UserCommentCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/28.
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

/// user comment, global use
class UserCommentCell: BaseCellNode {
    
    private let comment: Tutorial_Comment_Item_Model
    private let index: Int
    
    private let avatorImageNode: ASNetworkImageNode
    private let userNameTextNode: ASTextNode
    private let favoritesBtnNode: ASButtonNode
    private let contentTextNode: ASTextNode
    private let publishTimeTextNode: ASTextNode
    
    /// size
    private let avatorSize = CGSize(width: 24, height: 24)
    private let insetForHeader = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
    
    private var insetForComment: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: avatorSize.width + 10, bottom: 0, right: 5)
    }
    private var insetForReply: UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: avatorSize.width + 15, bottom: 5, right: 10)
    }
    
    private lazy var replyTextNodeArray: [ASTextNode] = {
        return self.createReplyTextNodes()
    }()

    init(comment: Tutorial_Comment_Item_Model, index: Int) {
        self.comment = comment
        self.index = index
        self.avatorImageNode = ASNetworkImageNode()
        self.userNameTextNode = ASTextNode()
        self.favoritesBtnNode = ASButtonNode()
        self.contentTextNode = ASTextNode()
        self.publishTimeTextNode = ASTextNode()
        super.init()
        self.selectionStyle = .default
    }
    
    override func didLoad() {
        super.didLoad()
        self.avatorImageNode.url = comment.author.iconURL
        self.avatorImageNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(image.size.width / 2.0)
        }
        self.userNameTextNode.setAttributdWith(string: comment.author.comment_name, font: UIFont.normalFont_14(), color: Color.blueColor)
        self.favoritesBtnNode.setImage(R.image.favorites(), for: .normal)
        self.favoritesBtnNode.setImage(R.image.favorites_selected(), for: .selected)
        self.favoritesBtnNode.setTitle(comment.likes_desc, with: UIFont.normalFont_14(), with: Color.lightGray, for: .normal)
        self.favoritesBtnNode.contentSpacing = 4.0
        self.favoritesBtnNode.contentVerticalAlignment = .top
        
        /// comment
        self.contentTextNode.setAttributdWith(string: comment.content, font: UIFont.normalFont_14(), color: Color.thinBlack)
        self.publishTimeTextNode.setAttributdWith(string: comment.created_at_desc, font: UIFont.normalFont_12(), color: Color.lightGray)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: insetForHeader, child: ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            createHeaderLayoutSpec(),
            createContentLayoutSpec(),
            createReplyLayoutSpec(),
            createBottomLineLayoutSpec()
            ]))
    }
    
    /// Header layout area
    private func createHeaderLayoutSpec() -> ASLayoutSpec {
        self.avatorImageNode.style.preferredSize = avatorSize
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
            self.avatorImageNode,
            self.userNameTextNode,
            ASLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            self.favoritesBtnNode.styled({ (style) in
                style.spacingAfter = 0.0
            })
        ])
    }
    
    /// Content layout area
    private func createContentLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: insetForComment, child: ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
                self.contentTextNode,
                self.publishTimeTextNode
            ]))
    }
    
    /// Reply layout area
    private func createReplyLayoutSpec() -> ASLayoutSpec {
        if replyTextNodeArray.count > 0 {
            let backGroundNode = ASDisplayNode()
            backGroundNode.backgroundColor = Color.thinGray
            let backgroundLayoutSpec = ASInsetLayoutSpec(insets: insetForComment, child: backGroundNode)
            return ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: insetForReply, child: ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: replyTextNodeArray)), background: backgroundLayoutSpec)
        } else {
            return ASLayoutSpec().styled({ (style) in
                style.flexShrink = 1.0
            })
        }
    }
    
    /// User reply textnode arrat
    private func createReplyTextNodes() -> [ASTextNode] {
        var replyTextNodeArray = [ASTextNode]()
        for item in comment.sub_notes {
            let textNode = ASTextNode()
            textNode.attributedText = item.getReplyAttributedString(with: comment.author_id)
            replyTextNodeArray.append(textNode)
        }
        return replyTextNodeArray
    }
    
    /// Bottom Line
    private func createBottomLineLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: insetForComment, child: createSeparotLine())
    }
    
    private func createSeparotLine() -> ASDisplayNode {
        let node = ASDisplayNode()
        node.backgroundColor = Color.lineGray
        node.style.maxHeight = ASDimension(unit: .points, value: 0.1)
        return node
    }
}
