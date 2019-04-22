//  WallpaperLayout.swift
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

import Foundation

class WallpaperLayout: UICollectionViewFlowLayout {
    
    static let ration: CGFloat = 1.6
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        super.init()
    }
    
    /// Caculate itemsize
    open func configureItemSize() {
        guard let collectionView = self.collectionView else { return }
        let lineSpacing: CGFloat = 8.0
        let numberOfLines: CGFloat = 2.0
        let width = collectionView.width - collectionView.contentInset.left - collectionView.contentInset.right
        let itemWidth = (width - (numberOfLines - 1.0) * lineSpacing) / numberOfLines
        let itemHeight = itemWidth * WallpaperLayout.ration
        self.minimumLineSpacing = 6.0
        self.minimumInteritemSpacing = 6.0
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
}
