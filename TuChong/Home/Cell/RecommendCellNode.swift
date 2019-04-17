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

// MARK: - RecommendCellNodeProtocol

protocol RecommendCellNodeProtocol: class {
    /// 点击更多时，刷新cell以展开显示更多内容
   func needToReload(cell: ASCellNode, at index: Int, isFolding: Bool)
    /// 点击某一个tag时
   func needToShowTagDetail(cell: ASCellNode, at index: Int, tag: Recommend_Feedlist_Tags_Model)
}

// MARK: - RecommendCellNode

/// 推荐Cell
class RecommendCellNode: RecommendBaseCellNode {
    
    weak var delegate: RecommendCellNodeProtocol?
    
    override init(with feenListItem: Recommend_Feedlist_Model, at index: Int) {
        super.init(with: feenListItem, at: index)
    }
    
    // MARK: - didLoad
    
    override func didLoad() {
        super.didLoad()
        /// avator
        self.avatorImageNode.url = feenListItem.entry.site.iconURL
        //// ASImageNodeRoundBorderModificationBlock(1.0, color), create rounded image
        self.avatorImageNode.imageModificationBlock = { image in
              image.byRoundCornerRadius(image.size.width / 2.0)
        }
        self.vertificationImageNode.image = feenListItem.entry.site.verified_image
        self.nameTextNode.setAttributdWith(string: feenListItem.entry.site.name, font: UIFont.boldFont_15())
        self.nameTextNode.truncationMode = .byTruncatingTail
        self.nameTextNode.maximumNumberOfLines = 1
        self.verifiedTextNode.setAttributdWith(string: feenListItem.entry.site.description, font: UIFont.normalFont_10(), color: Color.lightGray)
        self.verifiedTextNode.truncationMode = .byTruncatingTail
        self.verifiedTextNode.maximumNumberOfLines = 1
        /// focus
        self.focusBtnNode.setAttributedTitle(NSAttributedString(string: R.string.localizable.focus(), attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_12(),
            NSAttributedString.Key.foregroundColor: Color.lineColor]), for: .normal)
        ///
        switch feenListItem.stageType {
        case .multi_photo:
            guard let image = feenListItem.entry.images.first else { return }
            self.photoImageNode.url = URL(string: image.url)
            /// image count is more than one
            if feenListItem.entry.image_count > 1 {
                let node = ASButtonNode()
                node.setAttributedTitle(NSAttributedString(string: feenListItem.entry.iamge_count_desc, attributes:            [NSAttributedString.Key.font: UIFont.normalFont_12(),
                     NSAttributedString.Key.foregroundColor: Color.lightGray ])
                    , for: .normal)
                node.setImage(R.image.triangle_bottom(), for: .normal)
                node.imageAlignment = .end
                node.contentSpacing = 4
                self.totalImageCountBtnNode = node
            }
        default:
            break
        }
        /// operation
        self.likeBtnNode.setImage(R.image.like(), for: .normal)
        self.commentBtnNode.setImage(R.image.comment(), for: .normal)
        self.shareBtnNode.setImage(R.image.share(), for: .normal)
        self.collectBtnNode.setImage(R.image.collect(), for: .normal)
        self.shareRightNode.setImage(R.image.share_right(), for: .normal)
        /// tag Node
        self.tagNode.setAttributedWith(name: feenListItem.entry.site.name, title: feenListItem.entry.title, content: feenListItem.entry.content, tags: feenListItem.entry.tags, isFloding: feenListItem.isFolding)
        self.configureTagsArea()
    }
    
    // MARK: - layoutSpecThatFits
    
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
                            /// FocusBtn Node
                            focusBtnNode.styled({ (style) in
                                style.spacingAfter = 0.0
                            })
                         ])
                  ),
                  /// Center Photo
                centerPhotoArea() ?? ASLayoutSpec().styled({ (style) in style.flexShrink = 1.0 }),
                  /// Operation
                createOperateArea(),
                  /// Equip
                createEquipArea(),
                  /// Likes
                createLikesArea(),
                  /// Tags
                createTagsArea(),
                  /// Comments Count
                createCommentCountArea(),
                  /// Comments Area
                createCommentsArea(),
                  /// Reply Area
                createReplyCommentsArea()
        ])
    }
}

// MARK: - ASTextNodeDelegate

extension RecommendCellNode: ASTextNodeDelegate {
    
    func configureTagsArea() {
        /// set delegate
        self.tagNode.delegate = self
        /// enable  user interaction
        self.tagNode.isUserInteractionEnabled = true
        /// add target event
        self.tagNode.addTarget(self, action: #selector(tagNodeUserTapEvent), forControlEvents: .touchUpInside)
    }
    
    @objc private func tagNodeUserTapEvent() {
        if self.tagNode.isTruncated {
            /// since tagNode isTruncated, so need to reopen it.
            textNodeTappedTruncationToken(self.tagNode)
        }
    }
    
    func textNodeTappedTruncationToken(_ textNode: ASTextNode!) {
        /// reload tableNode
        self.delegate?.needToReload(cell: self, at: index, isFolding: false)
    }
    
    func textNode(_ textNode: ASTextNode!, tappedLinkAttribute attribute: String!, value: Any!, at point: CGPoint, textRange: NSRange) {
        if self.tagNode.isTruncated {
            textNodeTappedTruncationToken(self.tagNode)
        } else {
            guard let string = value as? String else { return }
            for item in feenListItem.entry.tags {
                let value = String(format: " #%@", item.tag_name)
                if value == string {
                    self.delegate?.needToShowTagDetail(cell: self, at: index, tag: item)
                }
            }
        }
    }
}
