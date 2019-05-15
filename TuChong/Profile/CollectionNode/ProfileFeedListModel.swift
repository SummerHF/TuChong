//  ProfileFeedListModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/10.
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
import HandyJSON

enum ProfileWorkType {
    case multi_photo
    case text
    case video
    case film
    case none
    
    init(outType: String, innerType: String) {
        if outType == "post" {
            if innerType == "text" {
                self = .text
            } else if innerType == "multi_photo" {
                self = .multi_photo
            } else {
                self = .none
            }
        } else if outType == "video" {
            self = .video
        } else if outType == "film" {
            self = .film
        } else {
            self = .none
        }
    }
}

struct Profile_Work_List_Model: HandyJSON {
    var type: String = ""
    var entry: Recommend_Feedlist_Eentry_Model = Recommend_Feedlist_Eentry_Model()
    /// 什么类型
    var workType: ProfileWorkType {
        return ProfileWorkType(outType: type, innerType: entry.type)
    }
}

struct Profile_Work_Model: HandyJSON {
    var count: Int = 0
    var before_timestamp: Int = 0
    var more: Bool = false
    var result: String = ""
    var work_list: [Profile_Work_List_Model] = []
    
    static func buildWith(dict: [String: Any]) -> Profile_Work_Model {
        guard let model = Profile_Work_Model.deserialize(from: dict) else { return Profile_Work_Model() }
        return model
    }
}
