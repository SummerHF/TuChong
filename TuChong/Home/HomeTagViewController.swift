//  TagViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/25.
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

import UIKit
import AsyncDisplayKit

class HomeTagViewController: BaseViewControlle {

    let collectionNode: ASCollectionNode
    let collectionNodeLayout: HomeTagCollectionNodeLayout
    var modelArray: [HomePage_More_Model]?

    override init() {
        collectionNodeLayout = HomeTagCollectionNodeLayout()
        collectionNode = ASCollectionNode(collectionViewLayout: collectionNodeLayout)
        super.init(node: collectionNode)
        collectionNode.backgroundColor = UIColor.white
        collectionNode.dataSource = self
        collectionNode.delegate = self
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func loadData() {
        Network.request(target: .home_more, success: { (response) in
             self.modelArray = HomePage_More_Model.build(with: response)
             self.collectionNode.reloadData()
        }, error: { _ in
            
        }) { (_) in
            
        }
    }
}

// MARK: - DataSource && Delegate
/// ASCollection
extension HomeTagViewController: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        guard let array = self.modelArray else { return macro.zero }
        return array.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        guard let array = self.modelArray else { return macro.zero }
        return array[section].items.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        guard let array = self.modelArray else { return ASCellNode() }
        return HomeTagCellNode(with: array[indexPath.section].items[indexPath.row])
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        guard let array = self.modelArray else { return ASCellNode() }
        return HomeTagSectionHeaderNode(with: array[indexPath.section].categoryName)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        guard self.modelArray != nil else { return ASSizeRangeZero }
        return ASSizeRangeUnconstrained
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let paddding: CGFloat = 10.0
        let column: CGFloat = 3
        let oneItemWidth = (self.view.width - (column - 1.0) * paddding) / column
        let size = CGSize(width: oneItemWidth, height: oneItemWidth)
        return ASSizeRange(min: size, max: size)
    }
}
