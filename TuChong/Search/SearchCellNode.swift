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
    let indexNode: ASTextNode
    let avatorNode: ASNetworkImageNode
    let avatorWidth: CGFloat = 32
    let bottomLine: ASImageNode
    
    init(with itemModel: Search_Hot_Photographer_User, index: Int) {
        self.model = itemModel
        self.index = index
        indexNode = ASTextNode()
        avatorNode = ASNetworkImageNode()
        bottomLine = ASImageNode()
        super.init()
        self.automaticallyManagesSubnodes = true
        self.indexNode.isLayerBacked = true
        self.avatorNode.isLayerBacked = true
        self.bottomLine.isLayerBacked = true 
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
        /// Ranking
        indexNode.attributedText = NSAttributedString(string: "\(index)", attributes: [NSAttributedString.Key.font: UIFont.normalFont_13(),
                                                                                       NSAttributedString.Key.foregroundColor: UIColor.black])
        /// User AvatorR
        avatorNode.url = URL(string: model.icon)
        avatorNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(self.avatorWidth/2.0)
        }
        /// Bottom line
        bottomLine.image = UIImage.as_resizableRoundedImage(withCornerRadius: 0.0, cornerColor: Color.lightGray, fill: Color.lightGray, borderColor: Color.lightGray, borderWidth: 0.00001)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        avatorNode.style.preferredSize = CGSize(width: avatorWidth, height: avatorWidth)
        bottomLine.style.flexGrow = 1.0
        
        let horizontalStack = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .start, alignItems: .center, children: [
            indexNode,
            avatorNode
            ])
        
        let verticalStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .center, alignItems: .stretch, children: [
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: horizontalStack),
            ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), child: bottomLine)])
        return verticalStack
    }
}
