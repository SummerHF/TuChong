//  CategoryCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/18.
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

class CategoryCellNode: ASCellNode {
    
    let postListItem: Recommend_Feedlist_Eentry_Model
    let index: Int
    let imageNode: ASNetworkImageNode
    let insetForImageNode: UIEdgeInsets = UIEdgeInsets.zero
    
    init(with postListItem: Recommend_Feedlist_Eentry_Model, at index: Int) {
        self.postListItem = postListItem
        self.index = index
        self.imageNode = ASNetworkImageNode()
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        self.imageNode.url = URL(string: postListItem.image_cover)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratioLayoutSpec = ASRatioLayoutSpec(ratio: postListItem.image_cover_ratio, child: self.imageNode)
        return ASInsetLayoutSpec(insets: insetForImageNode, child: ratioLayoutSpec)
    }
}
