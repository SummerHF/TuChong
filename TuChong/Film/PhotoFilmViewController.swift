//  PhotoFilmViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/9.
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

/// 照片电影

class PhotoFilmViewController: BaseViewControlle {
    
    private var page: Int = 1
    private var feed_list: [Recommend_Feedlist_Eentry_Model] = []
    
    private lazy var tableNode: PhotoFilmTableNode = {
        let tableNode = PhotoFilmTableNode()
        tableNode.dataSource = self
        tableNode.delegate = self
        return tableNode
    }()
    
    private lazy var searchBtnNode: ASButtonNode = {
        let searchBtnNode = ASButtonNode()
        let frame = CGRect(x: 20, y: macro.statusBarHeight, width: 36, height: 36)
        searchBtnNode.setImage(R.image.film_search(), for: .normal)
        searchBtnNode.frame = frame
        return searchBtnNode
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubNodes()
        self.loadData()
    }
    
    override func addSubNodes() {
        self.node.addSubnode(tableNode)
        self.node.addSubnode(searchBtnNode)
    }
    
    override func loadData() {
        Network.request(target: TuChong.film(page: self.page), success: { (responseData) in
            self.feed_list = PhotoFilmModel.buildWith(dict: responseData)
            self.tableNode.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
    
    override func initialHidden() -> Bool {
        return true
    }
}

extension PhotoFilmViewController: ASTableDataSource, ASTableDelegate {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.feed_list.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return PhotoFilmTableCell(feed_list: self.feed_list[indexPath.row], index: indexPath.row)
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeMake(UIScreen.main.bounds.size)
    }
}
