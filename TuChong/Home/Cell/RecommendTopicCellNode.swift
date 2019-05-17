//  RecommendTopCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/17.
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

class RecommendTopicCellNode: RecommendBaseCellNode {
    
    private let titleNameTextNode: ASTextNode
    private let moreTextNode: ASTextNode
    private let collectionNode: ASCollectionNode
    private let nodeLayout: UICollectionViewFlowLayout
    private let itemSize = CGSize(width: 100.0, height: 50.0)

    override init(with feenListItem: Recommend_Feedlist_Model, at index: Int) {
        self.titleNameTextNode = ASTextNode()
        self.moreTextNode = ASTextNode()
        /// Flow layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = itemSize
        self.nodeLayout = layout
        /// Collection Node
        self.collectionNode = ASCollectionNode(collectionViewLayout: layout)
        super.init(with: feenListItem, at: index)
    }
    
    override func didLoad() {
        super.didLoad()
        self.collectionNode.backgroundColor = Color.backGroundColor
        self.collectionNode.dataSource = self
        self.collectionNode.delegate = self
        self.collectionNode.showsVerticalScrollIndicator = false
        self.collectionNode.showsHorizontalScrollIndicator = false
        self.collectionNode.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        self.collectionNode.reloadData()
        
        /// add tap event
        self.moreTextNode.addTarget(self, action: #selector(moreTextNodeEvent), forControlEvents: .touchUpInside)
    }
    
    override func setPropertys() {
        self.titleNameTextNode.setAttributdWith(string: R.string.localizable.circle(), font: UIFont.boldFont_14())
        self.moreTextNode.setAttributdWith(string: R.string.localizable.to_view_more(), font: UIFont.normalFont_13(), color: Color.lightGray)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.setPropertys()
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
                ASInsetLayoutSpec(insets: insetForHeader, child:
                    ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
                        self.titleNameTextNode,
                        ASLayoutSpec().styled({ (style) in
                            style.flexGrow = 1.0
                        }),
                        self.moreTextNode.styled({ (style) in
                            style.spacingAfter = 0.0
                        })
                     ])
                  ),
                createTopicAreaLayoutSpec(constrainedSize)
            ])
      }
    
    /// Topic Area layouts, contains a collectionView
    private func createTopicAreaLayoutSpec(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if feenListItem.entry.tags.count > 0 {
            return ASInsetLayoutSpec(insets: insetForTopicCollectionNode, child: collectionNode.styled({ (style) in
                style.preferredSize = CGSize(width: constrainedSize.max.width, height: itemSize.height)
            }))
        } else {
            return ASLayoutSpec().styled({ (style) in
                style.flexShrink = 1.0
            })
        }
    }
    
    /// need to push to circle detail
    @objc private func moreTextNodeEvent() {
        let homeCircleVC = HomeCircleController()
        macro.currentSelectedNavgationController?.pushViewController(homeCircleVC, animated: true)
    }
}

extension RecommendTopicCellNode: ASCollectionDataSource, ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return feenListItem.entry.tags.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return RecommedTopicCollectionCellNode(with: feenListItem.entry.tags[indexPath.row], at: indexPath.row)
    }
}
