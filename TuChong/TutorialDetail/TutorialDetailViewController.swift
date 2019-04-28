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
    private let app_url: String
    private let webView: WebView
    private var requestFinished: Bool = false
    
    private var webViewHeight: CGFloat = 0
    private let tableNodeFrame = CGRect(x: 0, y: macro.topHeight, width: macro.screenWidth, height: macro.screenHeight - macro.topHeight)
    
    /// tableNode
    private let tableNode: ASTableNode
    
    /// using group to manager request
    let group = DispatchGroup()
    
    /// user profile model
    private var profile_model: Tutorial_Detail_Profile_Model = Tutorial_Detail_Profile_Model()
    /// tutorial reward info
    private var reward_model: Tutorial_Detail_Reward_Post_Model?
    /// tutorial comments model
    private var comments_model: Tutorial_Detail_Comment_Model = Tutorial_Detail_Comment_Model()
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
    
    /// comments request parameters
    private var page = 1
    /// 默认是最热
    private var commentType = RequestparameterKey.hotest
    private var commentsParameters: [String: Any] {
        return [RequestparameterKey.count: 20,
                RequestparameterKey.page: page,
                RequestparameterKey.sort_by: commentType
        ]
    }
    
    /// comments headerView
    private let  headerView: TutorialDetailHeadView = TutorialDetailHeadView()
    
    /// Create `TutorialDetailViewController`
    init(post_id: String, app_url: String) {
        self.post_id = post_id
        self.app_url = app_url
        self.tableNode = ASTableNode(style: .grouped)
        self.webView = WebView()
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
        self.tableNode.backgroundColor = Color.backGroundColor
        self.tableNode.dataSource = self
        self.tableNode.delegate = self
        self.tableNode.view.separatorStyle = .none
        self.headerView.delegate = self
    }
    
    override func loadData() {
        
        self.showLoadingView(with: tableNodeFrame)
        /// load user profile
        self.group.enter()
        Network.request(target: .tutorial_profile(post_id: post_id), success: { (responseData) in
            self.group.leave()
            guard let model = Tutorial_Detail_Profile_Model.deserialize(from: responseData) else { return }
            self.profile_model = model
        }, error: { (_) in
            self.group.leave()
        }) { (_) in
            self.group.leave()
        }
        
        /// load webpage
        self.group.enter()
        self.webView.load(with: app_url) { (result) in
            self.group.leave()
            switch result {
            case let .success(height):
                self.webViewHeight = height
            case let .failure(error):
                printLog(error)
            }
        }
        
        /// load reward info
        self.group.enter()
        Network.request(target: TuChong.tutorial_reward(post_id: post_id), success: { (responseData) in
            self.group.leave()
            self.reward_model = Tutorial_Detail_Reward_Model.build(with: responseData)
        }, error: { (_) in
            self.group.leave()
        }) { (_) in
            self.group.leave()
        }
        
        /// load user comment
        self.group.enter()
        Network.request(target: TuChong.tutorial_comments(post_id: post_id, parameters: commentsParameters), success: { (responseData) in
            self.group.leave()
            self.comments_model = Tutorial_Detail_Comment_Model.build(with: responseData)
        }, error: { (_) in
            self.group.leave()
        }) { (_) in
            self.group.leave()
        }
        
        /// notify
        self.group.notify(queue: DispatchQueue.main) {
            self.requestFinished = true
            self.tableNode.reloadData(completion: {
                self.removeLoadingView()
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - ASTableDataSource, ASTableDelegate

extension TutorialDetailViewController: ASTableDataSource, ASTableDelegate {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return TutorialGroup.numOfSection(isRequestFinished: self.requestFinished)
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return TutorialGroup.numOfRows(in: section, isRequestFinished: self.requestFinished, comments: self.comments_model.comment_count)
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        switch TutorialGroup(section: indexPath.section) {
        case .top:
            let cellType = Tutorial(index: indexPath.row)
            switch cellType {
            case .head:
                return TutorialDetailProfileCell(post: profile_model.post, indexPath: indexPath)
            case .webView:
                return TutorialDetailWebViewCell(webView: self.webView, height: self.webViewHeight)
            case .info:
                return TutoriaDetailInfoCell(post: profile_model.post, reward: self.reward_model, indexPath: indexPath)
            case .unknow:
                return ASCellNode()
            }
        case .comment:
            return UserCommentCell(comment: self.comments_model.commentlist[indexPath.row], index: indexPath.row)
        default:
            return ASCellNode()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return TutorialGroup.footerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TutorialGroup.heightFotHeader(at: section, isRequestFinished: self.requestFinished, commentCount: self.comments_model.comment_count)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.requestFinished && self.comments_model.comment_count > 0 && TutorialGroup(section: section) == .comment {
            headerView.configure(with: self.comments_model.comment_count, commentType: self.commentType)
            return headerView
        } else {
            return nil
        }
    }
}

// MARK: - TutorialDetailHeadViewProtocol

extension TutorialDetailViewController: TutorialDetailHeadViewProtocol {
    
    func headView(view: TutorialDetailHeadView, selected type: Int) {
        self.loadUserCommentBy(type: type)
    }
    
    private func loadUserCommentBy(type: Int) {
        self.commentType = type
        Network.request(target: .tutorial_comments(post_id: post_id, parameters: commentsParameters), success: { (responseData) in
            self.comments_model = Tutorial_Detail_Comment_Model.build(with: responseData)
            let indexSet = IndexSet(integer: TutorialGroup.groupOne)
            self.tableNode.reloadSections(indexSet, with: .automatic)
        }, error: { (_) in
        }) { (_) in
        }
    }
}
