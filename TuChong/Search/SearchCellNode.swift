//  SearchCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/4.
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

class SearchCellNode: ASCellNode {
    
    let index: Int
    let model: Search_Hot_Photographer_User
    let rankingNode: ASImageNode
    let indexNode: ASTextNode
    let avatorNode: ASNetworkImageNode
    let vertificationNode: ASImageNode
    let authorNameNode: ASTextNode
    let authorVertificationNode: ASTextNode
    let followNode: ASButtonNode
    let avatorWidth: CGFloat = 36
    let rankWidth: CGFloat = 30
    let vertificationWidth: CGFloat = 14
    let followNodeWidth: CGFloat = 65
    let followNodeHeight: CGFloat = 27
    /// Adaptive for iPhoneX
    let maxWidth: CGFloat = (175.0 / 375.0) * macro.screenWidth
    let bottomLine: ASDisplayNode
    
    init(with itemModel: Search_Hot_Photographer_User, index: Int) {
        self.model = itemModel
        self.index = index
        indexNode = ASTextNode()
        rankingNode = ASImageNode()
        avatorNode = ASNetworkImageNode()
        vertificationNode = ASImageNode()
        authorNameNode = ASTextNode()
        authorVertificationNode = ASTextNode()
        followNode = ASButtonNode()
        bottomLine = ASDisplayNode()
        super.init()
        self.selectionStyle = .none
        self.automaticallyManagesSubnodes = true
        self.rankingNode.isLayerBacked = true
        self.indexNode.isLayerBacked = true
        self.avatorNode.isLayerBacked = true
        self.vertificationNode.isLayerBacked = true
        self.authorNameNode.isLayerBacked = true
        self.authorVertificationNode.isLayerBacked = true
        self.bottomLine.isLayerBacked = true
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
        /// Ranking
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        /// Make text vertical aligment `center`: use baselineOffset
        indexNode.attributedText = NSAttributedString(string: "\(index + 1)", attributes: [NSAttributedString.Key.font: UIFont.normalFont_13(),
                                                                                       NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                                       NSAttributedString.Key.paragraphStyle : style,
                                                                                       NSAttributedString.Key.baselineOffset: -8])
        
        authorNameNode.attributedText = NSAttributedString(string: model.name, attributes: [NSAttributedString.Key.font: UIFont.boldFont_15(),
                                                                                            NSAttributedString.Key.foregroundColor: UIColor.black])
        authorNameNode.truncationMode = .byTruncatingTail
        authorNameNode.maximumNumberOfLines = 1
        authorVertificationNode.attributedText = NSAttributedString(string: model.description, attributes: [NSAttributedString.Key.font: UIFont.normalFont_12(),
                                                                                            NSAttributedString.Key.foregroundColor: UIColor.black])
        authorVertificationNode.truncationMode = .byTruncatingTail
        authorVertificationNode.maximumNumberOfLines = 1

        /// Set rank image
        switch index {
        case 0:
            rankingNode.image = R.image.first()
        case 1:
            rankingNode.image = R.image.second()
        case 2:
            rankingNode.image = R.image.third()
        default: break
        }
        /// User avatorR
        avatorNode.url = URL(string: model.icon)
        avatorNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(self.avatorWidth/2.0)
        }
        /// Vertification
        vertificationNode.image = R.image.verifications()
        /// Follow node
        followNode.setBackgroundImage(R.image.online_follow(), for: .normal)
        followNode.setBackgroundImage(R.image.icon_relation_followed(), for: .selected)
        followNode.isSelected = model.is_following
        /// Bottom line
        bottomLine.style.preferredSize.height = 0.1
        bottomLine.backgroundColor = Color.thinGray
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        bottomLine.style.flexGrow = 1.0
        indexNode.style.preferredSize = CGSize(width: rankWidth, height: rankWidth)
        rankingNode.style.preferredSize = CGSize(width: rankWidth, height: rankWidth)
        avatorNode.style.preferredSize = CGSize(width: avatorWidth, height: avatorWidth)
        vertificationNode.style.preferredSize = CGSize(width: vertificationWidth, height: vertificationWidth)
        authorNameNode.style.width = ASDimension(unit: .points, value: maxWidth)
        authorVertificationNode.style.width = ASDimension(unit: .points, value: maxWidth)
        followNode.style.preferredSize = CGSize(width: followNodeWidth, height: followNodeHeight)
        /// 用户头像
        var cornerLayoutSpec: ASCornerLayoutSpec?
        /// 用户认证
        var userVertificationAreaLayoutSpec: ASStackLayoutSpec?
        
        if model.verifications {
            cornerLayoutSpec = ASCornerLayoutSpec(child: avatorNode, corner: vertificationNode, location: .bottomRight)
            cornerLayoutSpec?.offset = CGPoint(x: -3, y: -3)
            userVertificationAreaLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .stretch, children: [
                authorNameNode,
                authorVertificationNode
                ])
        }
        
        let horizontalStack = ASStackLayoutSpec(direction: .horizontal, spacing: 16, justifyContent: .start, alignItems: .center, children: [
            index < 3 ? rankingNode : indexNode,
            cornerLayoutSpec ?? avatorNode,
            userVertificationAreaLayoutSpec ?? authorNameNode,
            followNode
            ])
        
        let verticalStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .stretch, children: [
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10), child: horizontalStack),
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), child: bottomLine)])
        return verticalStack
    }
}
