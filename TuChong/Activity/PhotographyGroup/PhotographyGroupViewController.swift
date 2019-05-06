//  PhotographyGroupViewController.swift
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

class PhotographyGroupViewController: BaseViewControlle {
    
    private let tableNode: ASTableNode
    
    private var feedList: [Photography_Group_Item_ModeL] = []
    private var page = 1
    private let count = 20
    
    lazy var parameters: [String: Any] = {
        return [RequestparameterKey.page: page, RequestparameterKey.count: count]
    }()
    
    override init() {
        tableNode = ASTableNode()
        super.init(node: tableNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableNode()
        loadData()
    }
    
    override func configureTableNode() {
        tableNode.view.separatorStyle = .none
        tableNode.dataSource = self
    }
    
    override func loadData() {
        Network.request(target: TuChong.activity_photography_group(parameters: parameters), success: { (responseData) in
            self.feedList = Photography_Group_ModeL.build(with: responseData)
            self.tableNode.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

extension PhotographyGroupViewController: ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.feedList.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return PhotographyGroupCell(item: self.feedList[indexPath.row], index: indexPath.row)
    }
}
