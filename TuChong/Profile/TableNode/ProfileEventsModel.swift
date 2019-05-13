//  ProfileEventsModel.swift
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

struct Profile_Events_List_Model: HandyJSON {
    var tag_id: Int = 0
    var type: String = ""
    var tag_name: String = ""
    var event_type: String = ""
    var vote: String = ""
    var title: String = ""
    var posts: String = ""
    var end_at: String = ""
    var status: String = ""
    var vote_banner: String = ""
    var prize_desc: String = ""
    var post_list: [Recommend_Feedlist_Eentry_Model] = []
    var remainingDays: Int = 0
}

struct Profile_Events_Model: HandyJSON {
    var more: Bool = false
    var counts: Int = 0
    var result: String = ""
    var event_list: [Profile_Events_List_Model] = []
    
    static func buildWith(dict: [String: Any]) -> [Profile_Events_List_Model] {
        guard let model = Profile_Events_Model.deserialize(from: dict) else { return [] }
        return model.event_list
    }
}
