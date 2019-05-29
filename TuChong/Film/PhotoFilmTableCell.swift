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
    private let profile: PhotoFilmProfileNode
    private let index: Int
    private static let profile_width: CGFloat = 64
    private static let profile_height: CGFloat = 400

    private let profile_position: CGPoint = {
        let profile_x: CGFloat = macro.screenWidth - profile_width
        let profile_y: CGFloat = macro.screenHeight - macro.tabBarHeight - profile_height
        return CGPoint(x: profile_x, y: profile_y)
    }()
    
    private let profile_size: CGSize = {
        return CGSize(width: profile_width, height: profile_height)
    }()
    
    private let insetForNode: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: macro.tabBarHeight, right: 0)
    
    init(feed_list: Recommend_Feedlist_Eentry_Model, index: Int) {
        self.feed_list = feed_list
        self.index = index
        self.collection = PhotoFilmCollectionNode(images: feed_list.images)
        self.profile = PhotoFilmProfileNode(entry_model: feed_list)
        super.init()
        self.backgroundColor = Color.black
    }
    
    override func didLoad() {
        self.collection.reloadData()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let childLayoutSpec = ASInsetLayoutSpec(insets: insetForNode, child: self.collection)
        profile.style.layoutPosition = profile_position
        profile.style.preferredSize = profile_size
        let overLayoutSpec = ASAbsoluteLayoutSpec(children: [profile])
        return ASOverlayLayoutSpec(child: childLayoutSpec, overlay: overLayoutSpec)
    }
}
