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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        tableNode = ActivityTableNode(style: .grouped)
        super.init(node: tableNode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenLfetBackItem = true
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
}
