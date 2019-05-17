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
    case homepage(baseURL: String?, path: String, parameters: [String: Any]?)
    /// 首页关注 ----- will not available
    case homepage_attention(page: Int, before_timestamp: Int?)
    /// 首页推荐 ----- will not available
    case homepage_recommend(page: Int, type: RequestType)
    /// 首页更多
    case home_more
    /// 首页 - 圈子 - 更多
    case home_circle_more(parameters: [String: Any])
    /// 活动 - 头部banner
    case activity
    /// 活动 - 底部的热门活动
    case activity_event(page: Int)
    /// 活动 - Banner - 推荐摄影师
    case activity_recommend_photographer(page: Int)
    /// 活动 - Banner - 胶囊演讲
    case activity_lecture_vision
    /// 活动 - Banner - 摄影小组
    case activity_photography_group(parameters: [String: Any])
    /// 搜索
    case search_hot(page: Int)
    /// 首页 ---- 教程
    case tutorial(baseURL: String, path: String, parameters: [String: Any])
    /// 教程 ---- 用户信息
    case tutorial_profile(post_id: String)
    /// 教程 ---- 用户打赏
    case tutorial_reward(post_id: String)
    /// 教程 ---- 用户评论
    case tutorial_comments(post_id: String, parameters: [String: Any])
    /// 用户 ---- Site
    case profile_site(site_id: String)
    /// 用户 ---- Event
    case profile_event(site_id: String, page: Int)
    /// 用户 ---- Work and Favorites
    case profile_work(path: String)
}

extension TuChong: TargetType {
    
    var headers: [String : String]? {
        /// 请求头处内容写死
        switch self {
        case .tutorial:
            return ["content-type": "application/json",
                    "version": "5.2.0",
                    "device": "51857464990",
                    "language": macro.language
            ]
        /// 首页 - 圈子 - 更多: 需要登录, 此处Token写死
        case .home_circle_more:
            return ["content-type": "application/json",
                    "version": "5.2.0",
                    "device": "51857464990",
                    "token": "fc2770231dbc158a",
                    "language": macro.language,
                    "Cookie": "_ga=GA1.2.764396779.1557041063; token=fc2770231dbc158a; webp_enabled=0"
            ]
        default:
            return ["content-type": "application/json",
                    "platform": "ios",
                    "version": "5.2.0",
                    "device": "51857464990",
                    "language": macro.language
            ]
        }
    }
    
    var baseURL: URL {
        switch self {
        case .home_more, .activity_photography_group:
            return URL(string: "https://tuchong.com")!
        case let .homepage(baseURL, _, _):
            return URL(string: baseURL ?? "https://api.tuchong.com")!
        case let .tutorial(baseURL, _, _):
            return URL(string: baseURL)!
        default:
            return URL(string: "https://api.tuchong.com")!
        }
    }
    
    var path: String {
        switch self {
        case .home_more:
            return "/rest/app-tag-nav"
        case .home_circle_more:
            return "/tag-list"
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
        case .activity_recommend_photographer:
            return "/users/hot"
        case .activity_lecture_vision:
            return "/vision/tabs"
        case .activity_photography_group:
            return "/rest/groups-app/all"
        case .search_hot:
            return "/users/hot"
        case let .homepage(_, path, _):
            return path
        case let .tutorial(_, path, _):
            return path
        case let .tutorial_profile(post_id):
            return "/app-posts/\(post_id)"
        case let .tutorial_reward(post_id):
            return "/posts/\(post_id)/rewards"
        case let .tutorial_comments(post_id, _):
            return "/2/posts/\(post_id)/comments"
        case let .profile_site(site_id):
            return "/2/sites/\(site_id)"
        case let .profile_event(site_id, _):
            return "/users/\(site_id)/events"
        case let .profile_work(path):
            return path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .tutorial,
             .tutorial_profile,
             .tutorial_reward,
             .tutorial_comments,
             .homepage,
             .home_circle_more,
             .search_hot,
             .activity_event,
             .activity,
             .activity_recommend_photographer,
             .activity_lecture_vision,
             .activity_photography_group,
             .home_more,
             .launch_ad,
             .home_nav,
             .homepage_attention,
             .homepage_recommend,
             .profile_site,
             .profile_event,
             .profile_work:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .home_more, .home_nav, .homepage_attention, .activity, .tutorial_profile, .tutorial_reward, .activity_lecture_vision, .profile_site:
            return .requestPlain
        case let .homepage(_, _, parameters):
            if let para = parameters {
                return .requestParameters(parameters: para, encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        case let .home_circle_more(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .profile_event(_, page):
            return .requestParameters(parameters: [RequestparameterKey.page: page], encoding: URLEncoding.default)
        case .profile_work:
            return .requestParameters(parameters: [RequestparameterKey.count: RequestparameterKey.default_count], encoding: URLEncoding.default)
        case let .tutorial(_, _, parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case let .tutorial_comments(_, parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .activity_event(page: let page):
            if page == 0 { return .requestPlain }
            return .requestParameters(parameters: [RequestparameterKey.page: page], encoding: URLEncoding.default)
        case .activity_recommend_photographer(page: let page):
            return .requestParameters(parameters: [RequestparameterKey.page: page], encoding: URLEncoding.default)
        case let .activity_photography_group(parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .launch_ad:
            /// 启动图, 此处宽高写死
            return .requestParameters(parameters: ["height": "750", "width": "1334"], encoding: URLEncoding.default)
        case let .homepage_recommend(page, type):
            let type = type == .refresh ? RequestparameterKey.refresh : RequestparameterKey.loadmore
            return .requestParameters(parameters: [RequestparameterKey.page: page, RequestparameterKey.type: type], encoding: URLEncoding.default)
            /// 搜索
        case let .search_hot(page):
            return .requestParameters(parameters: [RequestparameterKey.page: page], encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case .homepage,
             .search_hot,
             .activity_event,
             .activity,
             .activity_recommend_photographer,
             .activity_lecture_vision,
             .activity_photography_group,
             .home_more,
             .launch_ad,
             .home_nav,
             .homepage_attention,
             .tutorial,
             .tutorial_profile,
             .tutorial_reward,
             .tutorial_comments,
             .homepage_recommend,
             .profile_site,
             .profile_event,
             .home_circle_more,
             .profile_work:
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
