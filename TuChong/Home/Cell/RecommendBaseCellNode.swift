//  RecommendBaseCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/17.
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

/// Base Recommend Cell, contains almost all property and layout method, subClass to using it
/// ASDisplayNode+Subclasses
class RecommendBaseCellNode: ASCellNode {
    
    let feenListItem: Recommend_Feedlist_Model
    let index: Int
    
    /// node
    let avatorImageNode: ASNetworkImageNode
    let vertificationImageNode: ASImageNode
    let nameTextNode: ASTextNode
    let verifiedTextNode: ASTextNode
    let focusBtnNode: ASButtonNode
    let photoImageNode: ASNetworkImageNode
    var totalImageCountBtnNode: ASButtonNode?
    let likeBtnNode: ASButtonNode
    let commentBtnNode: ASButtonNode
    let shareBtnNode: ASButtonNode
    let collectBtnNode: ASButtonNode
    /// right share
    let shareRightNode: ASButtonNode
    let equipTextNode: ASTextNode
    let likeCountTextNode: ASTextNode
    let tagNode: ASTextNode
    let commentCountNode: ASTextNode
    /// comment
    let topCommentTextNode: ASTextNode
    let topCommentLikeBtnNode: ASButtonNode
    let topCommentReplySepator: ASDisplayNode
    let topCommentReplyTextNode: ASTextNode
    /// size
    let avatorWidth: CGFloat = 36
    let vertificationWidth: CGFloat = 12
    let insetForHeader = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    let insetForOperation = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    let insetForEquip = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    let insetForLikes = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    let insetForTags = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    let insetForCommentsCount = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    let insetForComments = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    let insetForReplyComments = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
    let insetForTopicCollectionNode = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

    init(with feenListItem: Recommend_Feedlist_Model, at index: Int) {
        self.feenListItem = feenListItem
        self.index = index
        self.avatorImageNode = ASNetworkImageNode()
        self.vertificationImageNode = ASImageNode()
        self.nameTextNode = ASTextNode()
        self.verifiedTextNode = ASTextNode()
        self.focusBtnNode = ASButtonNode()
        self.photoImageNode = ASNetworkImageNode()
        self.likeBtnNode = ASButtonNode()
        self.commentBtnNode = ASButtonNode()
        self.shareBtnNode = ASButtonNode()
        self.collectBtnNode = ASButtonNode()
        self.shareRightNode = ASButtonNode()
        self.equipTextNode = ASTextNode()
        self.likeCountTextNode = ASTextNode()
        self.tagNode = ASTextNode()
        self.commentCountNode = ASTextNode()
        self.topCommentTextNode = ASTextNode()
        self.topCommentLikeBtnNode = ASButtonNode()
        self.topCommentReplySepator = ASDisplayNode()
        self.topCommentReplyTextNode = ASTextNode()
        super.init()
        self.selectionStyle = .none
        self.automaticallyManagesSubnodes = true
        self.neverShowPlaceholders = true
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
    }
    
    // MARK: - LayoutSpec
    
    /// Avator corner layout spec
    func avatorCornerLayoutSpec() -> ASCornerLayoutSpec {
        let layoutSpec = ASCornerLayoutSpec(child: avatorImageNode, corner: vertificationImageNode, location: ASCornerLayoutLocation.bottomRight)
        layoutSpec.offset = CGPoint(x: -5, y: -5)
        return layoutSpec
    }
    
    /// Photo area, Including various types
    func centerPhotoArea() -> ASLayoutElement? {
        switch feenListItem.stageType {
        case .multi_photo:
            guard let image = feenListItem.entry.images.first else { return nil }
            return ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .center, children: [
                ASRatioLayoutSpec(ratio: image.ratio, child: photoImageNode),
                self.totalImageCountBtnNode ?? ASLayoutSpec().styled({ (style) in style.flexShrink = 1.0 })
                ])
        default:
            return nil
        }
    }
    
    /// Including like, comment, share, collect
    func createOperateArea() -> ASLayoutElement {
        return ASInsetLayoutSpec(insets: insetForOperation, child:
            ASStackLayoutSpec(direction: .horizontal, spacing: 24, justifyContent: .start, alignItems: .center, children: [
                likeBtnNode,
                commentBtnNode,
                shareBtnNode,
                collectBtnNode,
                ASLayoutSpec().styled({ (style) in
                    style.flexGrow = 1.0
                }),
                shareRightNode.styled({ (style) in
                    style.spacingAfter = 0.0
                })
                ])
        )
    }
    
    /// Equip area
    func createEquipArea() -> ASLayoutElement {
        if let equip = feenListItem.entry.equip {
            self.equipTextNode.setAttributdWith(string: equip.display_name, font: UIFont.normalFont_12(), color: Color.lightGray)
            self.configureEquipArea()
            return ASInsetLayoutSpec(insets: insetForEquip, child: ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .center, children: [
                self.equipTextNode
                ]))
        } else {
            return ASLayoutSpec().styled({ (style) in
                style.flexShrink = 1.0
            })
        }
    }
    
    func configureEquipArea() {
        self.equipTextNode.style.maxWidth = ASDimension(unit: .points, value: macro.screenWidth - insetForEquip.left - insetForEquip.right)
        self.equipTextNode.maximumNumberOfLines = 1
        self.equipTextNode.truncationMode = .byTruncatingTail
        self.equipTextNode.backgroundColor = Color.eqipBackGroundColor
        self.equipTextNode.textContainerInset = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        
        /// add rounded border
        self.equipTextNode.willDisplayNodeContentWithRenderingContext = {
            context, drawParameters in
            let bounds: CGRect = context.boundingBoxOfClipPath
            let radius: CGFloat = 20.0 * UIScreen.main.scale
            let lineWidth: CGFloat = 0.8
            /// set overlay
            let overlay = UIImage.as_resizableRoundedImage(withCornerRadius: radius, cornerColor: Color.backGroundColor, fill: Color.backGroundColor)
            overlay.draw(in: bounds)
            let path = UIBezierPath(roundedRect: CGRect(x: lineWidth/2.0, y: lineWidth/2.0, width: bounds.width - lineWidth, height: bounds.height - lineWidth), cornerRadius: radius)
            /// set strike
            Color.eqipBorderColor.setStroke()
            path.lineWidth = lineWidth
            path.stroke()
            path.addClip()
        }
    }
    
    /// Likes area
    func createLikesArea() -> ASLayoutElement {
        if feenListItem.entry.favorites != 0 {
            self.likeCountTextNode.attributedText = feenListItem.entry.favorites_desc
            return ASInsetLayoutSpec(insets: insetForLikes, child:
                self.likeCountTextNode.styled({ (style) in
                    style.flexGrow = 1.0
                })
            )
        } else {
            return ASLayoutSpec().styled({ (style) in
                style.flexShrink = 1.0
            })
        }
    }
    
    /// Tags area
    func createTagsArea() -> ASLayoutElement {
        if let attributed = self.tagNode.attributedText , attributed.length == 0 {
            return ASLayoutSpec().styled({ (style) in
                style.flexShrink = 1.0
            })
        }
        return ASInsetLayoutSpec(insets: insetForTags, child: self.tagNode)
    }
    
    /// Comments count
    func createCommentCountArea() -> ASLayoutElement {
        if feenListItem.entry.comments > 0 {
            self.commentCountNode.setAttributdWith(string: "查看全部\(feenListItem.entry.comments)条评论", font: UIFont.normalFont_13(), color: Color.lightGray)
            return ASInsetLayoutSpec(insets: insetForCommentsCount, child: self.commentCountNode)
        } else {
            return ASLayoutSpec().styled({ (style) in
                style.flexShrink = 1.0
            })
        }
    }
    
    /// Comments area
    func createCommentsArea() -> ASLayoutElement {
        guard let comments = feenListItem.entry.comment_list, let comment = comments.first else { return ASLayoutSpec().styled({ (style) in
            style.flexShrink = 1.0
        })}
        /// set top comment
        self.topCommentTextNode.setAttributedWith(name: comment.author.name, content: comment.content, maxLines: 2)
        self.topCommentLikeBtnNode.setImage(R.image.comment_like(), for: .normal)
        let imageSize = R.image.comment_like()!.size
        return ASInsetLayoutSpec(insets: insetForComments, child:
            ASStackLayoutSpec(direction: .horizontal, spacing: 0.0, justifyContent: .start, alignItems: .stretch, children: [
                self.topCommentTextNode.styled({ (style) in
                    style.maxWidth = ASDimension(unit: .points, value: 300)
                }),
                ASLayoutSpec().styled({ (style) in
                    style.flexGrow = 1.0
                }),
                self.topCommentLikeBtnNode.styled({ (style) in
                    style.spacingAfter = 0.0
                    style.preferredSize = imageSize
                })
                ]
            )
        )
    }
    
    /// Reply area
    func createReplyCommentsArea() -> ASLayoutElement {
        guard let comments = feenListItem.entry.comment_list, let comment = comments.first, let replyComment = comment.sub_notes.first else { return ASLayoutSpec().styled({ (style) in
            style.flexShrink = 1.0
        })}
        self.topCommentReplySepator.backgroundColor = Color.lightGray
        self.topCommentReplyTextNode.setAttributedWith(replyName: replyComment.author.name, repiedName: comment.author.name, content: replyComment.content)
        return ASInsetLayoutSpec(insets: insetForReplyComments, child:
            ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .center, children: [
                self.topCommentReplySepator.styled({ (style) in
                    style.preferredSize = CGSize(width: 1.0, height: 12)
                    style.spacingBefore = 0.5
                }),
                self.topCommentReplyTextNode.styled({ (style) in
                    style.maxWidth = ASDimension(unit: .points, value: 280)
                })
                ])
        )
    }
}
