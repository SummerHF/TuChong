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

// MARK: - API

enum PX {
    case homepage
}

extension PX: TargetType {
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    var baseURL: URL { return URL(string: "https://500px.me")! }
    var path: String {
        switch self {
        case .homepage:
            return "/community/discover/recommendContests"
        }
    }
    var method: Moya.Method {
        switch self {
        case .homepage:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .homepage:
            return .requestPlain
        }
    }
    var sampleData: Data {
        switch self {
        case .homepage:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
}

// MARK: - Network

struct Network {
    static let Service = MoyaProvider<PX>()
    
    
//    static func request(target: TargetType, success successCallback: (JSON) -> Void) {
//        
//    }
}
