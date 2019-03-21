//  Service.swift
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

import Foundation
import Moya
import SwiftyJSON

// MARK: - Type

enum RequestType {
    case refresh
    case loadmore
}

// MARK: - API

enum TuChong {
    /// 启动广告
    case launch_ad
    /// 首页
    case home_nav
    /// 首页关注
    case homepage_attention(page: Int, before_timestamp: Int?)
    /// 首页推荐
    case homepage_recommend(page: Int, type: RequestType)
}

extension TuChong: TargetType {
    var headers: [String : String]? {
        /// 请求头处内容写死
        return ["content-type": "application/json",
                "platform": "ios",
                "version": "4.15.0"
        ]
    }
    var baseURL: URL { return URL(string: "https://api.tuchong.com")! }
    var path: String {
        switch self {
        case .launch_ad:
            return "/2/welcome-images"
        case .home_nav:
            return "/4/app-nav"
        case .homepage_attention:
            return "/4/users/self/activities"
        case .homepage_recommend:
            return "/2/feed-app"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .launch_ad, .home_nav, .homepage_attention, .homepage_recommend:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .home_nav, .homepage_attention:
            return .requestPlain
        case .launch_ad:
            /// 此处宽高写死
            return .requestParameters(parameters: ["height": "750", "width": "1334"], encoding: URLEncoding.default)
        case .homepage_recommend(page: let page, type: let type):
            let type = type == .refresh ? "refresh" : "loadmore"
            return .requestParameters(parameters: ["page": page, "type": type], encoding: URLEncoding.default)
        }
    }
   
    var sampleData: Data {
        switch self {
        case .launch_ad, .home_nav, .homepage_attention, .homepage_recommend:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
}

// MARK: - Network

struct Network {
    
    static let service = MoyaProvider<TuChong>()
    
    /**
     Sending request with parameters.
     
     - parameter target: target
     - parameter successCallback: success call back
     - parameter errorCallback: error call back.
     - parameter failureCallback: failure call back.

     - returns: The created JSON
     */
    static func request(target: TuChong, success successCallback: @escaping ([String: Any]) -> Void, error errorCallback: @escaping (_ statusCode: Int) -> Void, failure failureCallback: @escaping (MoyaError) ->Void) {
        service.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    _ = try response.filterSuccessfulStatusCodes()
                    guard let value = JSON(response.data).dictionaryObject else { return errorCallback(response.statusCode)}
                    successCallback(value)
                } catch {
                    errorCallback(response.statusCode)
                }
            case let .failure(error):
                failureCallback(error)
            }
        }
    }
}
