//  ActivityViewController.swift
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

import UIKit
import AsyncDisplayKit

class ActivityViewController: BaseViewControlle {
    
    private let tableNode: ActivityTableNode
    private var topBannerModel: Activity_Top_Model = Activity_Top_Model()
    private var bottomEventModel: Activity_Bottom_List_Model = Activity_Bottom_List_Model()
    /// 搜索框
    private let searchBar = SearchBar()
    /// 搜索TableNode
    private lazy var searchTableNode: SearchTableNode = {
        let node = SearchTableNode()
        node.frame = tableNode.frame
        return node
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        tableNode = ActivityTableNode(style: .grouped)
        super.init(node: tableNode)
        tableNode.tableNodeDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenLfetBackItem = true
        addSearchBar()
        loadData()
    }
    
    override func loadData() {
        /// create group to manager first request for data
        let group = DispatchGroup()
        group.enter()
        Network.request(target: .activity, success: { (response) in
            group.leave()
            guard let model = Activity_Top_Model.deserialize(from: response) else { return }
            self.topBannerModel = model
        }, error: { _ in
            group.leave()
        }) { _ in
            group.leave()
        }
        group.enter()
        Network.request(target: .activity_event(page: 1), success: { (responseData) in
            group.leave()
            guard let model = Activity_Bottom_List_Model.deserialize(from: responseData) else { return }
            self.bottomEventModel = model
        }, error: { _ in
            group.leave()
        }, failure: { _ in
            group.leave()
        })
        /// all request finished
        group.notify(queue: .main) {
            self.tableNode.reload(topBanner: self.topBannerModel.banners, bottomEvents: self.bottomEventModel.eventList)
        }
    }
    
    /// addSearchBar
    private func addSearchBar() {
        searchBar.delegate = self
        self.navigationBar.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(macro.bottomMargin)
            make.size.equalTo(macro.searchBarSize)
        }
    }
}

// MARK: - SearchBarProtocol

extension ActivityViewController: SearchBarProtocol {
    
    func searchBarDidBeginEditing(searchBar: SearchBar) {
        searchTableNode.show(in: self.node, searchBar: searchBar)
    }
    
    func searchBarDidEndEditing(searchBar: SearchBar) {
        searchTableNode.dissmiss()
    }
}

extension ActivityViewController: ActivityTableNodeProtocol {
    
    func tableNode(node: ActivityTableNode, hasSelcted categoryType: ActivityCategoryType) {
        switch categoryType {
        case .club:
            let destination = PhotographyGroupViewController()
            destination.title = R.string.localizable.photography_club()
            self.navigationController?.pushViewController(destination, animated: true)
        case .photographer:
            let destination = RecommendPhotographerViewController()
            destination.title = R.string.localizable.recommended_photographer()
            self.navigationController?.pushViewController(destination, animated: true)
        case .lecture:
            let destination = LectureViewController()
            destination.title = R.string.localizable.lecture()
            self.navigationController?.pushViewController(destination, animated: true)
        default:
            break
        }
    }
}
