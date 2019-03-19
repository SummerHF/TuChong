//  DiscoveryRecommendModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/19.
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

struct HomePage_Entry_TitleImage_Model: HandyJSON {
    var width: String = ""
    var height: String = ""
    var url: String = ""
}

struct HomePage_Entry_Tags_Model: HandyJSON {
    var tag_id: Int = 0
    var type: String = ""
    var tag_name: String = ""
    var event_type: String = ""
    var vote: String = ""
    var status: String = ""
}

struct HomePage_Entry_Site_Model: HandyJSON {
    var site_id: Int = 0
    var type: String = ""
    var name: String = ""
    var domain: String = ""
    var description: String = ""
    var followers: Int = 0
    var url: String = ""
    var icon: String = ""
    var verified: Bool = false
    var verified_type: Int = 0
    var verified_reason: String = ""
    var is_following: Bool = false
    var is_follower: Bool = false
}

struct HomePage_Entry_Model: HandyJSON {
    var post_id: Int = 0
    var author_id: String = ""
    var type: String = ""
    var url: String = ""
    var published_at: String = ""
    var excerpt: String = ""
    var favorites: Int = 0
    var comments: Int = 0
    var title: String = ""
    var image_count: Int = 0
    var rewardable: Bool = false
    var rewards: Int = 0
    var wallpaper: Bool = false
    var views: Int = 0
    var collected: Bool = false
    var downloads: Int = 0
    var shares: Int = 0
    var collect_num: Int = 0
    var delete: Bool = false
    var app_url: String = ""
    var update: Bool = false
    var title_image: HomePage_Entry_TitleImage_Model = HomePage_Entry_TitleImage_Model()
    var tags: [HomePage_Entry_Tags_Model] = []
    var site: HomePage_Entry_Site_Model = HomePage_Entry_Site_Model()
    var created_at: String = ""
    var music: String = ""
    var is_top: Bool = false
    var is_favorite: Bool = false
}

struct HomePage_ActivityList_Model: HandyJSON {
    var type: String = ""
    var entry: HomePage_Entry_Model = HomePage_Entry_Model()
}

// MARK: - 首页, 关注

struct HomePage_Attention_Model: HandyJSON {
    var before_timestamp: Int = 0
    var new_activities: Int = 0
    var more: Bool = false
    var type: String = ""
    var result: String = ""
    var activity_list: [HomePage_ActivityList_Model] = []
}
