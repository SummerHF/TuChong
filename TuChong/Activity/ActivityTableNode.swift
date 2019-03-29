//  ActivityTableNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/29.
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
import UIKit

// MARK: - ActivityBannerCell

class ActivityBannerCell: ASCellNode {
    
    private let bannerModel: Activity_Top_Banner_Model
    private let imageNode: ASNetworkImageNode
    
    init(banner model: Activity_Top_Banner_Model) {
        bannerModel = model
        imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        imageNode.url = URL(string: bannerModel.src)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: imageNode)
    }
}

// MARK: - ActivityBannerCollectionNode

class ActivityBannerCollectionNode : ASCollectionNode {
    
    var bannerModel: [Activity_Top_Banner_Model] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("failure")
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout, layoutFacilitator: nil)
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false 
    }
}

// MARK: - ASCollectionDataSource, ASCollectionDelegate

extension ActivityBannerCollectionNode: ASCollectionDataSource, ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return bannerModel.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return ActivityBannerCell(banner: bannerModel[indexPath.row])
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: self.view.width, height: self.view.height)
        return ASSizeRange(min: size, max: size)
    }
}

class ActivityCategoryNode: ASDisplayNode {
    
    override init() {
        super.init()
        self.backgroundColor = UIColor.yellow
    }
}

// MARK: - ActivityTitileNode

class ActivityTitileNode: ASDisplayNode {
    
    let titleNode: ASTextNode
    let imageNode: ASImageNode
    
    override init() {
        titleNode = ASTextNode()
        imageNode = ASImageNode()
        super.init()
        titleNode.isLayerBacked = true
        imageNode.isLayerBacked = true
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        imageNode.image = R.image.iconNearbyHot_15x15_()
        titleNode.attributedText = NSAttributedString(string: R.string.localizable.hot_activity_title(), attributes: [
            NSAttributedString.Key.font : UIFont.boldFont(size: 16),
            NSAttributedString.Key.foregroundColor: UIColor.flatBlack
            ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: 20, height: 20)
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .center, alignItems: .center, children: [imageNode, titleNode])
        return stack
    }
}

// MARK: - ActivityTableNode

class ActivityBannerView: UIView {
    
    var heights: CGFloat = 400
    
    var collectionNodeHeight: CGFloat {
        return heights * 0.5
    }
    
    var titleNodeHeight: CGFloat {
        return heights * 0.2
    }
    
    var categoryNodeHeight: CGFloat {
        return heights * 0.3
    }
    
    private let layout: UICollectionViewFlowLayout
    private var collectionNode: ActivityBannerCollectionNode
    private var titleNode: ActivityTitileNode
    private var categoryNode: ActivityCategoryNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: heights)
        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        collectionNode = ActivityBannerCollectionNode(collectionViewLayout: layout)
        titleNode = ActivityTitileNode()
        categoryNode = ActivityCategoryNode()
        super.init(frame: frame)
        addSubnode(collectionNode)
        addSubnode(titleNode)
        addSubnode(categoryNode)
        setNodeProperty()
    }
    
    private func setNodeProperty() {
        layout.scrollDirection = .horizontal
        collectionNode.frame = CGRect(x: 0, y: 0, width: self.width, height: collectionNodeHeight)
        titleNode.frame = CGRect(x: 0, y: heights - titleNodeHeight, width: self.width, height: titleNodeHeight)
        categoryNode.frame = CGRect(x: 0, y: collectionNode.view.bottom, width: self.width, height: categoryNodeHeight)
        collectionNode.view.isPagingEnabled = true
    }
    
    func configureTopBanner(with data: [Activity_Top_Banner_Model]) {
        collectionNode.bannerModel = data
    }
}

// MARK: - ActivityTableNode

class ActivityTableNode: ASTableNode {
    
    private var bannerView = ActivityBannerView()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.dataSource = self
        self.delegate = self
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func reloadTopBanner(banner: [Activity_Top_Banner_Model]) {
        bannerView.configureTopBanner(with: banner)
    }
}

// MARK: - DataSource, Delegate

extension ActivityTableNode: ASTableDataSource, ASTableDelegate {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return ASCellNode()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return bannerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return bannerView.heights
    }
}
