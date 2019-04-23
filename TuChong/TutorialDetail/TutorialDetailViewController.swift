//  TutorialDetailViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/23.
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
import WebKit

class TutorialDetailViewController: BaseViewControlle {
    
    private let post_id: String
    private let tableNode: ASTableNode
    
    /// user profile model
    private var profile_model: Tutorial_Detail_Profile_Model = Tutorial_Detail_Profile_Model()
    /**
     /// 用户
     https://api.tuchong.com/app-posts/31264361
     /// 打赏
     https://api.tuchong.com/posts/31264361/rewards
     /// 评论
     https://api.tuchong.com/2/posts/30972658/comments?count=20&page=1&sort_by=0
     /// 网页
     https://tuchong.com/462420/at/28478061/
     */
    private var _webView: WKWebView?

    /// Create `TutorialDetailViewController`
    init(post_id: String) {
        self.post_id = post_id
        self.tableNode = ASTableNode(style: .grouped)
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = R.string.localizable.detail()
        self.configureTableNode()
        self.loadData()
    }
    
    override func configureTableNode() {
        self.tableNode.dataSource = self
    }
    
    override func loadData() {
        /// load user Data
        Network.request(target: TuChong.tutorial_profile(post_id: post_id), success: { (responseData) in
            guard let model = Tutorial_Detail_Profile_Model.deserialize(from: responseData) else { return }
            self.profile_model = model
            self.tableNode.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension TutorialDetailViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return TutorialDetailProfileCell(post: profile_model.post, indexPath: indexPath)
    }
}
