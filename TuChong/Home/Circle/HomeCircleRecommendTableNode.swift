//  HomeCircleRecommendTableNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/17.
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

class HomeCircleRecommendTableNode: ASTableNode {
    
    private var page: Int = 1
    
    private var parameters: [String: Any] {
        return [
            RequestparameterKey.page : page,
            RequestparameterKey.category: RequestparameterKey.all,
            RequestparameterKey.type: RequestparameterKey.recommend
        ]
    }
    
    init() {
        super.init(style: .plain)
        self.view.separatorStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
        self.loadData()
    }
    
    private func loadData() {
        Network.request(target: TuChong.home_circle_more(parameters: parameters), success: { (responseData) in
            printLog(responseData)
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}
