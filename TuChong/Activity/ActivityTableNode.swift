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

class ActivityBannerCollectionNode : ASCollectionNode {
    
    var bannerModel: [Activity_Top_Banner_Model] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("failure")
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: - ASCollectionDataSource, ASCollectionDelegate

extension ActivityBannerCollectionNode: ASCollectionDataSource, ASCollectionDelegate {
    
}

// MARK: - ActivityTableNode

class ActivityBannerView: UIView {
    
    var heights: CGFloat = 400
    
    private let layout: UICollectionViewFlowLayout
    private var collectionNode: ActivityBannerCollectionNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: heights)
        layout = UICollectionViewFlowLayout()
        collectionNode = ActivityBannerCollectionNode(frame: frame, collectionViewLayout: layout)
        super.init(frame: frame)
        self.addSubnode(collectionNode)
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
