//  PhotoFilmTableCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/28.
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

class PhotoFilmTableCell: BaseCellNode {
    
    private let feed_list: Recommend_Feedlist_Eentry_Model
    private let collection: PhotoFilmCollectionNode
    private let index: Int
    
    private let insetForNode: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: macro.tabBarHeight, right: 0)
    
    init(feed_list: Recommend_Feedlist_Eentry_Model, index: Int) {
        self.feed_list = feed_list
        self.index = index
        self.collection = PhotoFilmCollectionNode(images: feed_list.images)
        super.init()
    }
    
    override func didLoad() {
        self.collection.reloadData()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: insetForNode, child: self.collection)
    }
}
