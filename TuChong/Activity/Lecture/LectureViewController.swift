//  LectureViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/5.
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

class LectureViewController: BaseViewControlle {
    
    /// model
    private var feedList: [Tutorial_List_Model] = []
    
    /// 列表
    private let tableNode: ASTableNode
    
    private var page = 1
    private let count = 20
    private let loadingNodeFrame = CGRect(x: 0, y: macro.topHeight, width: macro.screenWidth, height: macro.screenHeight - macro.topHeight)

    lazy var parameters: [String: Any] = {
        return [RequestparameterKey.page: page, RequestparameterKey.count: count]
    }()

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
        tableNode.delegate = self
    }
    
    override func loadData() {
        Network.request(target: .activity_lecture_vision, success: { (responseData) in
            guard let model = Lecture_Vision_Model.build(with: responseData) else { return }
            self.requestForLecture(with: model.site_ids)
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
    
    private func requestForLecture(with id: String) {
        let baseURL = "https://tuchong.com"
        let path = "/rest/sites/\(id)/posts"
        self.showLoadingView(with: loadingNodeFrame)
        Network.request(target: TuChong.tutorial(baseURL: baseURL, path: path, parameters: parameters), success: { (responseData) in
            self.feedList = Tutorial_Model.build(with: responseData)
            self.tableNode.reloadData(completion: { [weak self] in
                guard let `self` = self else { return }
                self.removeLoadingView()
            })
        }, error: { (_) in
            self.removeLoadingView()
        }) { (_) in
            self.removeLoadingView()
        }
    }
}

extension LectureViewController: ASTableDataSource, ASTableDelegate {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.feedList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return RecommendTutorialCell(with: self.feedList[indexPath.row], at: indexPath.row)
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableNode.deselectRow(at: indexPath, animated: false)
        let post_id = feedList[indexPath.row].post.post_id
        let app_url = feedList[indexPath.row].post.app_url
        let tutorialDetail = TutorialDetailViewController(post_id: post_id, app_url: app_url)
        self.navigationController?.pushViewController(tutorialDetail, animated: true)
    }
}
