//  CategoryFlowLayout.swift
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

// MARK: - CategoryFlowLayoutDelegate

@objc protocol CategoryFlowLayoutDelegate: class {
    @objc optional func collectionView(_ collectionView: UICollectionView, layout: CategoryFlowLayout, originalRatioAtIndexPath: IndexPath) -> CGFloat
}

class CategoryFlowLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns: Int
    var columnSpacing: CGFloat
    
    var _sectionInset: UIEdgeInsets
    var _interItemSpacing: UIEdgeInsets
    
    var _columnHeights: [CGFloat] = []
    var _itemAttributes: [UICollectionViewLayoutAttributes] = []
    
    weak var delegate: CategoryFlowLayoutDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        self.numberOfColumns = 2
        self.columnSpacing = 10
        self._sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        self._interItemSpacing = UIEdgeInsets(top: 10.0, left: 0, bottom: 10.0, right: 0)
        super.init()
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView , collectionView.numberOfSections > 0 else { return }
        let top = _sectionInset.top
        _itemAttributes = []
        _columnHeights = []
        
        for _ in 0..<numberOfColumns {
            _columnHeights.append(top)
        }
        
        let section = 0
        let items = collectionView.numberOfItems(inSection: section)
        let columnWidth = self.columnWidthForLayout()
        for item in 0..<items {
            let columnIndex: Int = self.shortestColumnIndex()
            let indexPath = IndexPath(row: item, section: section)
            let itemSize = self.itemSizeAt(indexPath: indexPath)
            let xOffset = _sectionInset.left + (columnWidth + columnSpacing) * CGFloat(columnIndex)
            let yOffset = _columnHeights[columnIndex]
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height)
            _columnHeights[columnIndex] = attributes.frame.maxY + _interItemSpacing.bottom
            _itemAttributes.append(attributes)
            print("section:\(section), index:\(columnIndex), frame: \(attributes.frame)")

        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return !self.collectionView!.bounds.equalTo(newBounds) ? true : false
    }
    
    /// attributes in rect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var includedAttributes: [UICollectionViewLayoutAttributes] = []
        for attribute in _itemAttributes {
            if attribute.frame.intersects(rect) {
                includedAttributes.append(attribute)
            }
        }
        return includedAttributes
    }
    
    /// attributes in indexPath
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.row < _itemAttributes.count else { return nil }
        return _itemAttributes[indexPath.row]
    }
    
    override var collectionViewContentSize: CGSize {
        var height: CGFloat = 0
        if _columnHeights.count > 0 {
            height = _columnHeights.first ?? 0
        }
        return CGSize(width: self.collectionView!.width, height: height)
    }
    
    /// layout width
    private func widthForLayout() -> CGFloat {
        return self.collectionView!.width - _sectionInset.left - _sectionInset.right
    }
    
    /// item width
    private func columnWidthForLayout() -> CGFloat {
        return (widthForLayout() - CGFloat(numberOfColumns - 1) * columnSpacing) / CGFloat(numberOfColumns)
    }
    
    private func shortestColumnIndex() -> Int {
        var index = 0
        var shortestHeight = CGFloat.greatestFiniteMagnitude
        _ = _columnHeights.enumerated().map {
            (idx, height) in
            if height < shortestHeight {
                index = idx
                shortestHeight = height
            }
        }
        return index
    }
    
    private func tallestColumnIndex() -> Int {
        var index = 0
        var tallestHeight: CGFloat = 0
        _ = _columnHeights.enumerated().map {
            (idx, height) in
            if height > tallestHeight {
                index = idx
                tallestHeight = height
            }
        }
        return index
    }
    
    /// itemSize
    func itemSizeAt(indexPath: IndexPath) -> CGSize {
        guard let ratio = self.delegate?.collectionView?(self.collectionView!, layout: self, originalRatioAtIndexPath: indexPath) else { return CGSize.zero }
        let descriptionHeigth: CGFloat = 40
        let height = columnWidthForLayout() * ratio + descriptionHeigth
        let width = columnWidthForLayout()
        /// need to FIX:
        return CGSize(width: width, height: height)
    }
}

class CategoryFlowLayoutInspector: NSObject ,ASCollectionViewLayoutInspecting {
    
    func collectionView(_ collectionView: ASCollectionView, constrainedSizeForNodeAt indexPath: IndexPath) -> ASSizeRange {
        guard let layout = collectionView.collectionViewLayout as? CategoryFlowLayout else {
            return ASSizeRange(min: CGSize.zero, max: CGSize.zero)
        }
        return ASSizeRange(min: CGSize.zero, max: layout.itemSizeAt(indexPath: indexPath))
    }
    
    func scrollableDirections() -> ASScrollDirection {
        return ASScrollDirectionVerticalDirections
    }
}
