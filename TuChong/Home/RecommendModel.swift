//  RecommendModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/20.
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

struct Recommend_Feedlist_Images_Model: HandyJSON {
    var img_id: Int = 0
    var user_id: Int = 0
    var title: String = ""
    var excerpt: String = ""
    var width: Int = 0
    var height: Int = 0
    var description: String = ""
    var isAuthorTK: Bool = false
}

struct Recommend_Feedlist_Equip_Model: HandyJSON {
    var equip_id: String = ""
    var display_name: String = ""
}

struct Recommend_Feedlist_Tags_Model: HandyJSON {
    var tag_id: Int = 0
    var type: String = ""
    var tag_name: String = ""
    var event_type: String = ""
    var vote: String = ""
    var status: String = ""
    var description: String = ""
    var cover_img_id: String = ""
}

struct Recommend_Feedlist_Verification_List_Model: HandyJSON {
    var verification_type: Int = 0
    var verification_reason: String = ""
}

struct Recommend_Feedlist_CommensAuthor_Model: HandyJSON {
    var site_id: String = ""
    var type: String = ""
    var name: String = ""
    var domain: String = ""
    var description: String = ""
    var followers: Int = 0
    var url: String = ""
    var icon: String = ""
    var is_bind_everphoto: Bool = false
    var verified: Bool = false
    var verified_type: Int = 0
    var verified_reason: String = ""
    var verifications: String = ""
    var verification_list: [Recommend_Feedlist_Verification_List_Model] = []
}

struct Recommend_Feedlist_Subnotes_Model {
    var note_id: Int = 0
    var author: Recommend_Feedlist_CommensAuthor_Model = Recommend_Feedlist_CommensAuthor_Model()
}

struct Recommend_Feedlist_CommensList_Model: HandyJSON {
    var note_id: Int = 0
    var content: String = ""
    var liked: Bool = false
    var author: Recommend_Feedlist_CommensAuthor_Model = Recommend_Feedlist_CommensAuthor_Model()
    var sub_notes: [Recommend_Feedlist_Subnotes_Model] = []
}

struct Recommend_Feedlist_Music_Model: HandyJSON {
    var music_id: String = ""
    var common_music_id: String = ""
    var name: String = ""
    var author: String = ""
    var duration: Int = 0
    var status: Int = 0
    var url: String = ""
    var cover_url: String = ""
    /// wait to confirm
    var music_beats: [String] = []
    var desc: String = ""
    var prefetch: Bool = false
    var prefetch_count: Int = 0
    var real_duration: CGFloat = 0.0
    /// wait to confirm
    var timers: [String] = []
    var type: String = ""
    var background_color: String = ""
    var special_preview: Bool = false
}

struct Recommend_Feedlist_Users_Model: HandyJSON {
    var site_id: String = ""
    var name: String = ""
    var icon: String = ""
}

struct Recommend_Feedlist_Site_Model: HandyJSON {
    var site_id: String = ""
    var type: String = ""
    var name: String = ""
    var domain: String = ""
    var description: String = ""
    var followers: Int = 0
    var url: String = ""
    var icon: String = ""
    var is_bind_everphoto: Bool = false
    var verified: Bool = false
    var verified_type: Int = 0
    var verified_reason: String = ""
    var verifications: Int = 0
    var verification_list: [Recommend_Feedlist_Verification_List_Model] = []
    var is_following: Bool = false
    var is_follower: Bool = false
    var iconURL: URL {
        return URL(string: icon)!
    }
}

struct Recommend_Feedlist_RecomType_Model {
    var type: String = ""
    var reason: String = ""
    var recall_type: String = ""
}

struct Recommend_Feedlist_Eentry_Model: HandyJSON {
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
    var content: String = ""
    var update: Bool = false
    var title_image: String = ""
    var is_favorite: Bool = false
    var is_top: Bool = false
    var data_type: String = ""
    var created_at: String = ""
    /// wait to confirm
    var attend_event: String = ""
    var rqt_id: String = ""
    var users: [Recommend_Feedlist_Users_Model] = []
    var site: Recommend_Feedlist_Site_Model = Recommend_Feedlist_Site_Model()
    var recom_type: Recommend_Feedlist_RecomType_Model = Recommend_Feedlist_RecomType_Model()
    var music: Recommend_Feedlist_Music_Model = Recommend_Feedlist_Music_Model()
    var comment_list: [Recommend_Feedlist_CommensList_Model] = []
    var equip: Recommend_Feedlist_Equip_Model = Recommend_Feedlist_Equip_Model()
    var images: [Recommend_Feedlist_Images_Model] = []
    var tags: [Recommend_Feedlist_Tags_Model] = []
}

// MARK: - Feedlist

struct Recommend_Feedlist_Model: HandyJSON {
    var type: String = ""
    var is_marked: Bool = false
    var entry: Recommend_Feedlist_Eentry_Model = Recommend_Feedlist_Eentry_Model()
}

// MARK: - RecommendModel

struct RecommendModel: HandyJSON {
    var is_history: Bool = false
    var counts: Int = 0
    var feedList: [Recommend_Feedlist_Model] = []
    var message: String = ""
    var more: Bool = false
    var result: String = ""
}
