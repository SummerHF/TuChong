//  ProfileCoverCollectionNodeCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/6.
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

class ProfileCoverCollectionNodeCell: BaseCellNode {
    
    private let cover: String
    private let index: Int
    
    private let imageNode: ASNetworkImageNode
    
    init(with cover: String, index: Int) {
        self.cover = cover
        self.index = index
        self.imageNode = ASNetworkImageNode()
        super.init()
        self.backgroundColor = Color.backGroundColor
    }
    
    override func didLoad() {
        self.imageNode.url = URL(string: cover)
        self.imageNode.contentMode = .scaleAspectFill
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: self.imageNode)
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        printLog(UIScreen.main.bounds)
        printLog(self.frame)
    }
}
