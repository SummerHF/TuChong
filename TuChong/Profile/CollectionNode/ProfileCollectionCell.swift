//  ProfileCollectionCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/10.
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

class ProfileCollectionCell: BaseCellNode {
    
    private let work_list_model: Profile_Work_List_Model
    private let index: Int
    
    private let insetForWorkTypeLayoutSpec = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    private let font: UIFont = UIFont.boldFont_12()
    
    private let imageNode: ASNetworkImageNode
    private let shadowImageNode: ASImageNode
    
    private let workTypeImageNode: ASImageNode
    private let lookCountBtnNode: ASButtonNode
    private let favoriteCountBtnNode: ASButtonNode
    private let commentCountBtnNode: ASButtonNode

    init(work_list: Profile_Work_List_Model, index: Int) {
        self.work_list_model = work_list
        self.index = index
        self.shadowImageNode = ASImageNode()
        self.imageNode = ASNetworkImageNode()
        self.workTypeImageNode = ASImageNode()
        self.lookCountBtnNode = ASButtonNode()
        self.favoriteCountBtnNode = ASButtonNode()
        self.commentCountBtnNode = ASButtonNode()
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        
        self.shadowImageNode.image = R.image.profile_cover()
        self.shadowImageNode.contentMode = .scaleToFill
        self.imageNode.contentMode = .scaleAspectFill
        self.imageNode.url = work_list_model.cover_url
        self.workTypeImageNode.image = R.image.hot()
        
        self.lookCountBtnNode.contentSpacing = 4.0
        self.favoriteCountBtnNode.contentSpacing = 4.0
        self.commentCountBtnNode.contentSpacing = 4.0

        self.lookCountBtnNode.setAttributdWith(string: "\(work_list_model.entry.views)", font: font, color: Color.backGroundColor, state: .normal)
        self.lookCountBtnNode.setImage(R.image.profile_look_count(), for: .normal)
        
        self.favoriteCountBtnNode.setAttributdWith(string: "\(work_list_model.entry.favorites)", font: font, color: Color.backGroundColor, state: .normal)
        self.favoriteCountBtnNode.setImage(R.image.profile_favorite(), for: .normal)
        
        self.commentCountBtnNode.setAttributdWith(string: "\(work_list_model.entry.comments)", font: font, color: Color.backGroundColor, state: .normal)
        self.commentCountBtnNode.setImage(R.image.profile_message(), for: .normal)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        /// set corner radius
        self.imageNode.add(cornerRadius: 4.0, backgroundColor: Color.backGroundColor, cornerRoundingType: .clipping)
        return ASBackgroundLayoutSpec(child: createInfoLayoutSpec(), background: self.imageNode)
    }
    
    private func createInfoLayoutSpec() -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            createWoryTypeLayoutSpec(),
            ASLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            createOverLayoutSpec()
        ])
        return stack
    }
    
    private func createOverLayoutSpec() -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
            self.lookCountBtnNode.styled({ (style) in
                let width = work_list_model.entry.text_length_with(count: work_list_model.entry.views, font: font)
                style.preferredSize = CGSize(width: width, height: 25)
                style.spacingBefore = 10.0
            }),
            self.favoriteCountBtnNode.styled({ (style) in
                let width = work_list_model.entry.text_length_with(count: work_list_model.entry.favorites, font: font)
                style.preferredSize = CGSize(width: width, height: 25)
            }),
            self.commentCountBtnNode.styled({ (style) in
                let width = work_list_model.entry.text_length_with(count: work_list_model.entry.comments, font: font)
                style.preferredSize = CGSize(width: width, height: 25)
            })
        ])
        self.shadowImageNode.styled({ (style) in  style.maxHeight = ASDimensionMake(40) })
        return ASOverlayLayoutSpec(child: self.shadowImageNode, overlay: stack)
    }
    
    private func createWoryTypeLayoutSpec() -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            ASLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            self.workTypeImageNode.styled({ (style) in
                style.preferredSize = CGSize(width: 20, height: 20)
                style.spacingAfter = 10.0
            })
        ])
        return ASInsetLayoutSpec(insets: insetForWorkTypeLayoutSpec, child: stack)
    }
}
