//  RecommendPhotographerViewController.swift
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

class RecommendPhotographerViewController: BaseViewControlle {

    private let tableNode: ASTableNode
    private var feedList: [Recommend_Feedlist_Site_Model] = []
    private var page = 1
    
    override init() {
        tableNode = ASTableNode(style: .plain)
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableNode()
        self.loadData()
    }
    
    override func configureTableNode() {
        tableNode.view.separatorStyle = .none
        tableNode.dataSource = self
    }
    
    override func loadData() {
        Network.request(target: TuChong.activity_recommend_photographer(page: page), success: { (responseData) in
            self.feedList = Recommend_Photographer_Model.build(with: responseData)
            self.tableNode.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

extension RecommendPhotographerViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.feedList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let row = indexPath.row
        return RecommendPhotographerCell(author: feedList[row], index: row)
    }
}
