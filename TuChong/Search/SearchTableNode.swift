//  SearchTableNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/3.
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

class SearchTableNode: ASTableNode {
    
    private var search: SearchBar?
    private var targetNode: ASDisplayNode?
    private let sectionCount = 2
    private var hotEventList: [Activity_Events_Model] = []
    private var authorList: [Search_Hot_Photographer_User] = []

    override init(style: UITableView.Style) {
        /// 指定样式, 为组样式
        super.init(style: .grouped)
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
        self.view.separatorStyle = .none
        self.dataSource = self
        self.delegate = self
    }

    func show(in node: ASDisplayNode, searchBar: SearchBar) {
        targetNode = node
        search = searchBar
        searchBar.isFirstShow = false
        /// Every display requires a request for data
        loadData()
    }
    
    func dissmiss() {
        fadeAnimation(isHidden: true) {
            self.removeFromSupernode()
            self.targetNode = nil
            self.search?.isFirstShow = true
        }
    }
    
    func fadeAnimation(isHidden: Bool, completion: (() -> Void)? = nil) {
        self.alpha = isHidden ? 1.0 : 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = !isHidden ? 1.0 : 0
        }) { _ in
            self.alpha = 1.0
            completion?()
        }
    }
    
    /// request data
    private func loadData() {
        let group = DispatchGroup()
        group.enter()
        Network.request(target: .search_hot(page: 1), success: { response in
            group.leave()
            guard let model = Search_Hot_Photographer.deserialize(from: response) else { return }
            self.authorList = model.author_list
        }, error: { _ in
            group.leave()
        }) { _ in
            group.leave()
        }
        group.enter()
        Network.request(target: .activity_event(page: 0), success: { response in
            group.leave()
            guard let model = Activity_Bottom_List_Model.deserialize(from: response) else { return }
            self.hotEventList = Array(model.eventList[0...3])
        }, error: { _ in
            group.leave()
        }) { _ in
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            self.reloadData()
            /// add self to target view
            self.targetNode?.addSubnode(self)
            /// animate
            self.fadeAnimation(isHidden: false)
        }
    }
}

// MARK: - ASTableDataSource, ASTableDelegate

extension SearchTableNode: ASTableDataSource, ASTableDelegate {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return sectionCount
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return authorList.count
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        switch indexPath.section {
        case 0:
            return ASCellNode()
        default:
            return SearchCellNode(with: authorList[indexPath.row], index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var title: String
        switch section {
        case 0:
            title = R.string.localizable.hot_activity_title()
        default:
            title = R.string.localizable.hot_search_photographer_title()
        }
        return TableSectionHeaderView(with: title)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableSectionHeaderView.headerHeight
    }
    
    /// When scrollView begin drag, end editing
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _ = self.search?.endEditing(true)

    }
}
