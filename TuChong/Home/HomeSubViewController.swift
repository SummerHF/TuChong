//  HomeSubViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/11.
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

class HomeSubViewController: BaseViewControlle {
    
    private let index: Int
    private let model: HomePageNav_Data_Model
    private let page: Int = 1
    
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
//        self.loadData()
    }
    
    override func loadData() {
        /// build parameters
        var path: String = ""
        var parameters: [String: Any] = [:]
        switch model.itemType {
        case .follow:
            print("follow")
//            need to login in
        case .recommend:
            path = "/2/feed-app"
            parameters = [RequestparameterKey.page: page, RequestparameterKey.type: RequestType.refresh.rawValue]
        case .tag:
            path = "/discovery/\(model.entry.id)/category"
            parameters = [RequestparameterKey.page: page]
        case .video_recommend:
//            /2/video/app/fav?page=1&type=refresh
            /// to do
            /// 首先获取banner
            path = "/2/app-video-nav"
            parameters = [RequestparameterKey.page: page, RequestparameterKey.type: RequestType.refresh.rawValue]
        case .wallpaper:
//            /4/wall-paper/app?first_refresh=1&page=1&tag=-3
            path = "/4/wall-paper/app"
            parameters = [RequestparameterKey.first_refresh: true,
                          RequestparameterKey.page: page,
                          RequestparameterKey.tag: model.entry.id]
        case .rn:
            print("rn To do")
//            https://tuchong.com/rest/sites/1615439,1615432,1615443,1615461,1615437/posts?page=1&count=10
        default:
            print("default To do")
        }
//        Network.request(target: TuChong.homepage(path: path, parameters: parameters), success: { response in
//            print(response)
//        }, error: { _ in
//
//        }) { _ in
//
//        }
        print(path)
        print(parameters)
    }
    
    override func initialHidden() -> Bool {
        return true
    }
}
