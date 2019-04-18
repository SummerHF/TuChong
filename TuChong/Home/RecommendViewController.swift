//  RecommendViewController.swift
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

// MARK: - RecommendViewController

/// `Type` is Recommend
class RecommendViewController: RecommendBaseViewController {
    
    private var feedList: [Recommend_Feedlist_Model] = []
    /// tableNode
    private lazy var tableNode: ASTableNode = {
        let tableNode = ASTableNode(style: .plain)
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = false
        return tableNode
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Fast Initializers
    override init(model: HomePageNav_Data_Model, index: Int, path: String, parameters: [String: Any]) {
        super.init(model: model, index: index, path: path, parameters: parameters)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubviews()
        self.loadData()
    }
    
    override func addSubviews() {
        self.view.addSubnode(tableNode)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableNode.frame = self.view.bounds
    }
    
    override func loadData() {
        Network.request(target: TuChong.homepage(path: path, parameters: paramerers), success: { (response) in
            guard let model = RecommendModel.deserialize(from: response) else { return }
            self.feedList = model.feedList
            self.tableNode.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

extension RecommendViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return feedList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let model = feedList[indexPath.row]
        switch model.stageType {
        case .topic:
            let cell = RecommendTopicCellNode(with: feedList[indexPath.row], at: indexPath.row)
            return cell
        default:
            let cell = RecommendCellNode(with: feedList[indexPath.row], at: indexPath.row)
            cell.delegate = self
            return cell
        }
    }
}

extension RecommendViewController: RecommendCellNodeProtocol {
    
    func needToReload(cell: ASCellNode, at index: Int, isFolding: Bool) {
        feedList[index].isFolding = isFolding
    }
    
    func needToShowTagDetail(cell: ASCellNode, at index: Int, tag: Recommend_Feedlist_Tags_Model) {
        print(tag.tag_name, tag.tag_id)
    }
}
