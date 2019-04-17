//  FollowViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/17.
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

// MARK: - FollowViewController

/// `Type` is Follow
class FollowViewController: BaseViewControlle {
    
    private let index: Int
    private let model: HomePageNav_Data_Model
    private let page: Int = 1
    
    private var loginNode: FollowViewUserLoginNode?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: HomePageNav_Data_Model, index: Int) {
        self.model = model
        self.index = index
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    override func addSubviews() {
        if !UserManager.manager.isLogin {
            let node = FollowViewUserLoginNode()
            self.view.addSubnode(node)
            node.view.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.6)
            }
            self.loginNode = node
        }
    }
    
    override func initialHidden() -> Bool {
        return true
    }
}
