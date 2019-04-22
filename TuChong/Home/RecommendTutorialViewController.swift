//  RecommendTutorialViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/22.
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

class RecommendTutorialViewController: RecommendBaseViewController {
    
    private var baseURL: String = ""
    
    /// 头部的导航视图
    private var navView: TutorialNavNode? {
        didSet {
            self.node.addSubnode(navView!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(model: HomePageNav_Data_Model, index: Int, path: String, parameters: [String : Any]) {
        super.init(model: model, index: index, path: path, parameters: parameters)
    }
    
    convenience init(model: HomePageNav_Data_Model, index: Int, baseURL: String, path: String, parameters: [String : Any]) {
        self.init(model: model, index: index, path: path, parameters: parameters)
        self.baseURL = baseURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func addSubviews() {
        
    }
    
    override func loadData() {
        Network.request(target: .homepage(baseURL: baseURL, path: path, parameters: paramerers), success: { (responseData) in
            self.navView = TutorialNavNode(delegate: self)
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

extension RecommendTutorialViewController: TutorialNavNodeProtocol {
    
}
