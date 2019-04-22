//  RecommendWallpaperCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/19.
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

class RecommendWallpaperCell: ASCellNode {
    
    let postListItem: Recommend_Feedlist_Model
    let index: Int
    let photoImageNode: ASNetworkImageNode
    let gifImageNode: ASNetworkImageNode
    let hotImageNode: ASImageNode
    
    private let insetForPhotoImageNode = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    private let insetForHotImageNode = UIEdgeInsets(top: 4, left: 4, bottom: CGFloat.infinity, right: CGFloat.infinity)

    init(with postListItem: Recommend_Feedlist_Model, at index: Int) {
        self.postListItem = postListItem
        self.index = index
        self.photoImageNode = ASNetworkImageNode()
        self.gifImageNode = ASNetworkImageNode()
        self.hotImageNode = ASImageNode()
        super.init()
        self.hotImageNode.isLayerBacked = true
        self.photoImageNode.isLayerBacked = true 
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        self.hotImageNode.image = R.image.hot()
        if postListItem.stageType == .video {
            /// need to fix gif issue
            self.gifImageNode.url = URL(string: postListItem.entry.gif_cover)
        } else {
            self.photoImageNode.url = URL(string: postListItem.entry.image_cover)
            self.photoImageNode.imageModificationBlock = {
                image in
                image.byRoundCornerRadius(8.0)
            }
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        /// whether hot
        return postListItem.entry.is_hot ? ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: insetForHotImageNode, child:
            self.hotImageNode.styled({ (style) in
                style.preferredSize = CGSize(width: 18, height: 18)
            })
        ), background: createPhotoLayoutSpec()) : createPhotoLayoutSpec()
    }
    
    /// Photo layout spec, Gif or normal photo
    private func createPhotoLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: insetForPhotoImageNode, child: ASRatioLayoutSpec(ratio: WallpaperLayout.ration, child: postListItem.stageType == .video ?
            self.gifImageNode :
            self.photoImageNode
        ))
    }
}
