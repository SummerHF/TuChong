//  PhotoFilmProfileNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/29.
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

class PhotoFilmProfileNode: ASDisplayNode {
    
    private let entry: Recommend_Feedlist_Eentry_Model
    
    private let avatorImageNode: ASNetworkImageNode = ASNetworkImageNode()
    
    init(entry_model: Recommend_Feedlist_Eentry_Model) {
        self.entry = entry_model
        super.init()
        self.backgroundColor = Color.lineColor
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        self.avatorImageNode.url = entry.site.iconURL
        self.avatorImageNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(image.size.width / 2.0, borderWidth: 1.0, borderColor: Color.flatWhite)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let verticalLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 20, justifyContent: .start, alignItems: .center, children: [
            self.avatorImageNode.styled({ (style) in
                style.preferredSize = CGSize(width: 48, height: 48)
            })
        ])
        return verticalLayoutSpec
    }
}
