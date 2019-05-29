//  PhotoFilmCollectionNode.swift
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

// MARK: - PhotoFilmCollectionNodeCell

class PhotoFilmCollectionNodeCell: BaseCellNode {
    
    private let image: Recommend_Feedlist_Images_Model
    private let index: Int
    
    private let imageNode: ASNetworkImageNode
    
    init(image: Recommend_Feedlist_Images_Model, index: Int) {
        self.image = image
        self.index = index
        self.imageNode = ASNetworkImageNode()
        super.init()
        self.backgroundColor = Color.black
    }
    
    override func didLoad() {
        self.imageNode.url = URL(string: image.url)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let rationLayoutSpec = ASRatioLayoutSpec(ratio: image.ratio, child: self.imageNode)
        return ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: .minimumXY, child: rationLayoutSpec)
    }
}

// MARK: - PhotoFilmCollectionNode

class PhotoFilmCollectionNode: ASCollectionNode {
    
    private var images: [Recommend_Feedlist_Images_Model]
    
    init(images: [Recommend_Feedlist_Images_Model]) {
        self.images = images
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: macro.screenWidth, height: macro.screenHeight - macro.tabBarHeight)
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .horizontal
        super.init(frame: CGRect.zero, collectionViewLayout: layout, layoutFacilitator: nil)
        self.dataSource = self
        self.view.isPagingEnabled = true
        self.view.bounces = false
    }
}

extension PhotoFilmCollectionNode: ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return PhotoFilmCollectionNodeCell(image: self.images[indexPath.row], index: indexPath.row)
    }
}
