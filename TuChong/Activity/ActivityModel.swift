//  ActivityModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/29.
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
import SwiftyJSON

/// top banner
/// 横幅
struct Activity_Top_Banner_Model: HandyJSON {
    var url: String = ""
    var src: String = ""
}

struct Activity_Top_Categories_Model: HandyJSON {
    var tag_name: String = ""
    var tag_id: Int = 0
}

struct Activity_Events_Model: HandyJSON {
    var tag_id: Int = 0
    var tag_name: String = ""
    var created_at: String = ""
    var status: String = ""
    var posts: String = ""
    var new_posts: String = ""
    var participants: String = ""
    var end_at: String = ""
    var title: String = ""
    var url: String = ""
    var event_type: String = ""
    var image_count: Int = 0
    var deadline: String = ""
    var prize_desc: String = ""
    var prize_url: String = ""
    var introduction_url: String = ""
    var introduction_id: Int = 0
    var competition_type: Int = 0
    var remainingDays: Int = 0
    var dueDays: Int = 0
    var list_banner: Bool = false
    var app_url: String = ""
    var category: [String] = []
    var images: [String] = []
    var image_posts: [String] = []
    var is_packet: Bool = false
    
    var image_count_value: String {
        if image_count < 10000 {
            return "\(image_count)"
        } else {
            return String(format: "%.1f", CGFloat(image_count) / 10000.0) + "万"
        }
    }
    
    var image_count_string: String {
        return image_count_value + "件作品"
    }
    
    var remainingDays_string: String {
        var str = ""
        for c in "距截稿\(remainingDays)天" {
            str.append("\(c) ")
        }
        return str
    }
    
    /// 是否显示截止日期
    var showDeadline: Bool {
        return end_at != ""
    }
}

struct Activity_Top_Model: HandyJSON {
    var result: String = ""
    var banners: [Activity_Top_Banner_Model] = []
    var categories: [Activity_Top_Categories_Model] = []
    var hotEvents: [Activity_Events_Model] = []
}

/// 底部热点
struct Activity_Bottom_List_Model: HandyJSON {
    var more: Bool = false
    var total: Int = 0
    var result: String = ""
    var eventList: [Activity_Events_Model] = []
}
