//  HomeCircleModel.swift
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

import Foundation
import HandyJSON

struct Home_Circle_Tag_Model: HandyJSON {
    var tag_id: Int = 0
    var tag_type: String = ""
    var tag_name: String = ""
    var descriptio: String = ""
    var cover_url: String = ""
    var subscribers: Int = 0
    var posts: Int = 0
    var participants: Int = 0
    var is_following: Bool = false
    
    var detail_info: String {
        return "\(participants)人 · \(posts)件作品"
    }
}

struct Home_Circle_Model: HandyJSON {
    var total: Int = 0
    var more: Bool = false
    var result: String = ""
    var list: [Home_Circle_Tag_Model] = []
    
    static func buildWith(dict: [String: Any]) -> [Home_Circle_Tag_Model] {
        guard let model = Home_Circle_Model.deserialize(from: dict) else { return [] }
        return model.list
    }
}
