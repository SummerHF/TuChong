//  LaunchManager.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/18.
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
import HandyJSON

// MARK: - 启动广告模型

struct LaunchAd_App: HandyJSON {
    var id: String = ""
    var title: String = ""
    var author_name: String = ""
    var image_url: String = ""
    var tuchong_url: String = ""
}

struct LaunchAd: HandyJSON {
    var app: [LaunchAd_App] = []
}

// MARK: - 启动广告协议
/// 关联类型协议
protocol LaunchMangerProtocol {
    associatedtype T
//    func write() -> T
    func read() -> T
    func update() -> T
    func show() -> T
}

class LaunchManager: LaunchMangerProtocol {
    
    typealias T = LaunchManager
    /// use this singleton to manager l
    static let manager = LaunchManager()
    
    @discardableResult
    func read() -> LaunchManager {
        print(NSHomeDirectory())
        return .manager
    }
    
    @discardableResult
    func update() -> LaunchManager {
        Network.request(target: .launch_ad, success: { (response) in
            guard let data = LaunchAd.deserialize(from: response) else { return }
            print(data.app.count)
        }, error: { (error) in
            print(error)
        }) { (moyaError) in
            print(moyaError)
        }
        return .manager
    }
    
    @discardableResult
    func show() -> LaunchManager {
        return .manager
    }
}
