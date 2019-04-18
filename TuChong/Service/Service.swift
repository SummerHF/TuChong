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

enum RequestType: String {
    case refresh
    case loadmore
}

// MARK: - API

enum TuChong {
    /// 启动广告
    case launch_ad
    /// 首页分类
    case home_nav
    /// 首页
    case homepage(path: String, parameters: [String: Any]?)
    /// 首页关注 ----- will not available
    case homepage_attention(page: Int, before_timestamp: Int?)
    /// 首页推荐 ----- will not available
    case homepage_recommend(page: Int, type: RequestType)
    /// 首页更多
    case home_more
    /// 活动 - 头部banner
    case activity
    /// 活动 - 底部的热门活动
    case activity_event(page: Int)
    /// 搜索
    case search_hot(page: Int)
    /// 点击关注后推荐
//    /site-recommend/1350538/?page=1&count=10
}

extension TuChong: TargetType {
    var headers: [String : String]? {
        /// 请求头处内容写死
        return ["content-type": "application/json",
                "platform": "ios",
                "version": "5.0.1",
                "device": "51857464990",
                "language": macro.language
        ]
    }
    var baseURL: URL {
        switch self {
        case .home_more:
            return URL(string: "https://tuchong.com")!
        default:
            return URL(string: "https://api.tuchong.com")!
        }
    }
    var path: String {
        switch self {
        case .home_more:
            return "/rest/app-tag-nav"
        case .launch_ad:
            return "/2/welcome-images"
        case .home_nav:
            return "/4/app-nav"
        case .homepage_attention:
            return "/4/users/self/activities"
        case .homepage_recommend:
            return "/2/feed-app"
        case .activity:
            return "/discover-app"
        case .activity_event:
            return "/4/events"
        case .search_hot:
            return "/users/hot"
        case let .homepage(path, _):
            return path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .homepage, .search_hot, .activity_event, .activity, .home_more, .launch_ad, .home_nav, .homepage_attention, .homepage_recommend:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .home_more, .home_nav, .homepage_attention, .activity:
            return .requestPlain
        case let .homepage(_, parameters):
            if let para = parameters {
                return .requestParameters(parameters: para, encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        case .activity_event(page: let page):
            if page == 0 {
                return .requestPlain
            }
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        case .launch_ad:
            /// 启动图, 此处宽高写死
            return .requestParameters(parameters: ["height": "750", "width": "1334"], encoding: URLEncoding.default)
        case let .homepage_recommend(page, type):
            let type = type == .refresh ? "refresh" : "loadmore"
            return .requestParameters(parameters: ["page": page, "type": type], encoding: URLEncoding.default)
            /// 搜索
        case let .search_hot(page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case .homepage,
             .search_hot,
             .activity_event,
             .activity,
             .home_more,
             .launch_ad,
             .home_nav,
             .homepage_attention,
             .homepage_recommend:
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
