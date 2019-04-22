//  RecommendWallpaperViewController.swift
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

/// `Type` is wallpaper
class RecommendWallpaperViewController: RecommendBaseViewController {
    
    private var navArray: [HomePaga_Wallpaper_Data_Model] = []
    private var feedList: [Recommend_Feedlist_Model] = []
    private var banner: HomePage_Wallpaper_Banner?
    
    private let collectionNodeInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    
    /// 头部的导航视图
    private var navView: WallpaperNavNode? {
        didSet {
            self.node.addSubnode(navView!)
        }
    }
    
    private let layout = WallpaperLayout()
    
    private lazy var collectionNode: ASCollectionNode = {
        let collectionNode = ASCollectionNode(collectionViewLayout: layout)
        collectionNode.contentInset = collectionNodeInset
        collectionNode.backgroundColor = Color.backGroundColor
        collectionNode.dataSource = self
        collectionNode.delegate = self
        collectionNode.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
        return collectionNode
    }()
    
    /// Fast Initializers without `parameters`
    init(model: HomePageNav_Data_Model, index: Int, path: String) {
        super.init(model: model, index: index, path: path, parameters: [:])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        addSubviews()
    }
    
    override func addSubviews() {
        self.view.addSubnode(collectionNode)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionNode.frame = CGRect(x: 0, y: macro.homenavHeight, width: self.view.width, height: self.view.height - macro.homenavHeight)
        layout.configureItemSize()
    }
    
    /// First add nav data
    override func loadData() {
        Network.request(target: TuChong.homepage(baseURL: nil, path: path, parameters: nil), success: { (response) in
            guard let navarray = HomePage_Wallpaper_Nav.build(with: response) else { return }
            self.navArray = navarray
            self.navView = WallpaperNavNode(data: navarray, delegate: self)
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

// MARK: - Datasource

extension RecommendWallpaperViewController: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return feedList.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return RecommendWallpaperCell(with: feedList[indexPath.row], at: indexPath.row)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        if let banner = self.banner {
            return RecommendWallpaperHeadNode(with: banner)
        } else {
            return ASCellNode()
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, sizeRangeForHeaderInSection section: Int) -> ASSizeRange {
        if let banner = self.banner {
            let width: CGFloat = self.collectionNode.view.width - collectionNodeInset.left - collectionNodeInset.right
            let height = width * banner.ratio
            let size = CGSize(width: width, height: height)
            return ASSizeRange(min: size, max: size)
        } else {
            return ASSizeRangeZero
        }
    }
}

// MARK: - WallpaperNavNodeProtocol

extension RecommendWallpaperViewController: WallpaperNavNodeProtocol {
    
    /// Send request after selected trigger
    func wllpaperNav(node: WallpaperNavNode, selectedBtn: NavItemButton, with index: Int, and tagID: Int) {
        let path = "/4/wall-paper/app"
        let parameters = [RequestparameterKey.page: self.initialPage,
                          RequestparameterKey.tag: tagID
                          ]
        Network.request(target: .homepage(baseURL: nil, path: path, parameters: parameters), success: { (response) in
            guard let model = HomePage_Wallpaper.deserialize(from: response) else { return }
            self.feedList = model.feedList
            self.banner = model.banner
            self.collectionNode.scrollToTop(animate: false)
            self.collectionNode.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}
