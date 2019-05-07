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
import Kingfisher

class ProfileCoverCollectionNodeCell: BaseCellNode {
    
    private let cover: String
    private let index: Int
    
    private let imageView: UIImageView
    private let placeHolderImage: UIImage = UIImage.init(color: Color.thinGray)!
    
    init(with cover: String, index: Int) {
        self.cover = cover
        self.index = index
        self.imageView = UIImageView()
        super.init()
        self.backgroundColor = Color.backGroundColor
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.kf.setImage(with: URL(string: cover))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageNode = ASDisplayNode { () -> UIView in
            return self.imageView
        }
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: imageNode)
    }
}
