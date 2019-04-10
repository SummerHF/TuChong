//  HomeContainerViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/20.
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

class HomeContainerViewController: BaseViewControlle {
    
    var navArray: [HomePageNav_Data_Model] = []
    /// 搜索框
    private let searchBar = SearchBar()
    /// 头部的导航视图
    var navView: HomeNavNode? {
        didSet {
            self.node.addSubnode(navView!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init() {
        let node = ASDisplayNode()
        super.init(node: node)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenLfetBackItem = true
        addSearchBar()
        initContainer()
    }
    
    /// addSearchBar
    private func addSearchBar() {
        self.navigationBar.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(macro.bottomMargin)
            make.size.equalTo(macro.searchBarSize)
        }
    }
    
    /// 初始化容器视图
    func initContainer() {
        Network.request(target: .home_nav, success: { (response) in
            guard let model = HomePage_Nav.deserialize(from: response) else { return }
            self.navArray = model.data
            self.navView = HomeNavNode(data: model.data, delegate: self)
        }, error: { (error) in
            print(error)
        }) { (moyaError) in
            print(moyaError)
        }
    }
    
}

// MARK: - HomeNavViewDlegate

extension HomeContainerViewController: HomeNavNodeDlegate {
    
    func homeNavNodeMoreBtnEvent(node: HomeNavNode) {
        /// 标签页
        let tagVC = HomeTagViewController()
        self.navigationController?.pushViewController(tagVC, animated: true)
    }
    
    func homeNav(node: HomeNavNode, selectedBtn: HomeNavItemButton, with index: Int) {
        print(index)
        print(selectedBtn.itemModel.name)
    }
}
