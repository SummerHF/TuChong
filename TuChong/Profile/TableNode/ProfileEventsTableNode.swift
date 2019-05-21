//  ProfileEventsTableNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/10.
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

class ProfileEventsTableNode: ASTableNode {
    
    let type: ProfileDetailType
    var feedList: [Profile_Events_List_Model] = []
    var canScroll: Bool = false

    private var site_id: String = ""
    private var page: Int = 1

    init(type: ProfileDetailType) {
        self.type = type
        super.init(style: .grouped)
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = Color.simpleGray
        self.view.showsVerticalScrollIndicator = false
    }
    
    override func didLoad() {
        super.didLoad()
        self.view.separatorStyle = .none
    }
    
    func configureWith(site_id: String) {
        self.site_id = site_id
        self.loadData()
    }
    
    private func loadData() {
        Network.request(target: TuChong.profile_event(site_id: site_id, page: page), success: { (responseData) in
            self.feedList = Profile_Events_Model.buildWith(dict: responseData)
            self.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

extension ProfileEventsTableNode: ASTableDataSource, ASTableDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.canScroll {
            scrollView.contentOffset.y = 0
        } else {
            if scrollView.contentOffset.y <= 0 {
                self.canScroll = false
                scrollView.contentOffset.y = 0
                NotificationCenter.default.post(name: NotificationName.detailViewHasScrollToTop, object: nil)
            }
        }
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return self.feedList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.feedList[section].post_list.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return ProfileEventsCellNode(post_list: self.feedList[indexPath.section].post_list[indexPath.row], indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ProfileEventsHeaderView(listItem: self.feedList[section])
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ProfileEventsHeaderView.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return ProfileEventsHeaderView.footerHeight
    }
}
