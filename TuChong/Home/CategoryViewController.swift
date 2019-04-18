//  CategoryViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/11.
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

// MARK: - CategoryViewController

/// `Type` is Tag
class CategoryViewController: RecommendBaseViewController {
    
    private let collectionNode: ASCollectionNode
    private let layoutInspector = CategoryFlowLayoutInspector()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Fast Initializers
    override init(model: HomePageNav_Data_Model, index: Int, path: String, parameters: [String: Any]) {
        /// layout
        let layout = CategoryFlowLayout()
        self.collectionNode = ASCollectionNode(collectionViewLayout: layout)
        super.init(model: model, index: index, path: path, parameters: parameters)
        layout.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        loadData()
    }
    
    override func addSubviews() {
        collectionNode.layoutInspector = layoutInspector
        collectionNode.dataSource = self
        collectionNode.view.isScrollEnabled = true
        collectionNode.view.showsVerticalScrollIndicator = false
        collectionNode.backgroundColor = Color.backGroundColor
        self.view.addSubnode(collectionNode)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionNode.frame = self.view.bounds
    }
    
    override func loadData() {
        Network.request(target: .homepage(path: path, parameters: paramerers), success: { (response) in
            guard let model = RecommendTagsModel.deserialize(from: response) else { return }
            /// filter the empty images
            self.post_list = model.post_list.filter { return $0.image_count > 0 }
            self.collectionNode.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

// MARK: - dataSource

extension CategoryViewController: ASCollectionDataSource, CategoryFlowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout: CategoryFlowLayout, originalRatioAtIndexPath: IndexPath) -> CGFloat {
        return post_list[originalRatioAtIndexPath.row].image_cover_ratio
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return post_list.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return CategoryCellNode(with: post_list[indexPath.row], at: indexPath.row)
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
}
