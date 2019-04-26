//  TutoriaDetailInfoCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/25.
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

/// 教程详情 ---- tags, likes, rewards
class TutoriaDetailInfoCell: BaseAScellNode {
    
    private let model: Recommend_Feedlist_Eentry_Model
    private var rewardModel: Tutorial_Detail_Reward_Post_Model?
    private let index: IndexPath
    
    private let insetForTagsLayout = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    private let rewardBtnNodeSize = CGSize(width: 86, height: 30)
    private let spaceing: CGFloat = 10
    
    private let likeCountBtnNode: ASButtonNode
    private let rewardTitleTextNode: ASTextNode
    private let rewardBtnNode: ASButtonNode
    private let rewardPromptTextNode: ASTextNode
    
    init(post model: Recommend_Feedlist_Eentry_Model, reward: Tutorial_Detail_Reward_Post_Model?, indexPath: IndexPath) {
        self.model = model
        self.rewardModel = reward
        self.index = indexPath
        self.likeCountBtnNode = ASButtonNode()
        self.rewardTitleTextNode = ASTextNode()
        self.rewardBtnNode = ASButtonNode()
        self.rewardPromptTextNode = ASTextNode()
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        self.likeCountBtnNode.setAttributdWith(string: model.favorites_description, font: UIFont.normalFont_13(), color: Color.lightGray, state: .normal)
        self.likeCountBtnNode.contentHorizontalAlignment = .left
        let string = "\" \(R.string.localizable.reward_title()) \""
        self.rewardTitleTextNode.setAttributdWith(string: string, originalString: R.string.localizable.reward_title(), font: UIFont.normalFont_14(), orignaleFont: UIFont.boldFont_20())
        self.rewardBtnNode.setAttributdWith(string: R.string.localizable.reward(), font: UIFont.boldFont_15(), color: Color.flatWhite, state: .normal)
        self.rewardBtnNode.backgroundColor = Color.lineColor
        self.rewardBtnNode.style.preferredSize = rewardBtnNodeSize
        self.rewardBtnNode.cornerRadius = rewardBtnNodeSize.height / 2.0
        self.rewardBtnNode.cornerRoundingType = .defaultSlowCALayer
        if let reward = self.rewardModel {
            self.rewardPromptTextNode.attributedText = reward.reward_desc
        } else {
            self.rewardPromptTextNode.setAttributdWith(string: "给作者加个鸡腿吧", font: UIFont.normalFont_14(), color: Color.lightGray, aligement: .center)
        }
        
    }
    /// Main layout spec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
           return ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            createTagsLayoutSpec(),
            createLikesLayoutSpec(),
            createRewardLayoutSpec()
        ])
    }
    
    /// Tag node layout spec
    private func createTagsLayoutSpec() -> ASLayoutSpec {
        let tagNodeArray = TutorialDetailInfoTagBtnNode.createTagsLayoutSpec(with: model.tags)
        for tagNode in tagNodeArray {
            /// add tagNode event
            tagNode.addTarget(self, action: #selector(tagNodeEvent(node:)), forControlEvents: .touchUpInside)
        }
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start, children: tagNodeArray)
        stack.flexWrap = .wrap
        stack.lineSpacing = spaceing
        return ASInsetLayoutSpec(insets: insetForTagsLayout, child: stack)
    }
    
    /// Tag node event
    @objc private func tagNodeEvent(node: TutorialDetailInfoTagBtnNode) {
        printLog("tagNodeEvent")
    }
    
    /// Likes layout spec
    private func createLikesLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: insetForTagsLayout, child: self.likeCountBtnNode)
    }
    
    /// Reward layout spec
    private func createRewardLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 18, justifyContent: .start, alignItems: .stretch, children: [
            /// line
            createSeparotLine(),
            /// reward title
            self.rewardTitleTextNode,
            /// rewardBtnNode
            ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: .minimumXY, child: self.rewardBtnNode),
            /// rewardPromptTextNode
            self.rewardPromptTextNode,
            /// line
            createSeparotLine()
        ])
    }
    
    private func createSeparotLine() -> ASDisplayNode {
        let node = ASDisplayNode()
        node.backgroundColor = Color.lineGray
        node.style.maxHeight = ASDimension(unit: .points, value: 0.1)
        return node
    }
}
