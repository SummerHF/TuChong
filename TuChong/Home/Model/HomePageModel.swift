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

struct HomePageNav_Data_Entry_Data_Tab_Model: HandyJSON {
    var name: String = ""
    var site_ids: String = ""
    var total: Int = 0
}

struct HomePageNav_Data_Entry_Data_Model: HandyJSON {
    var tabs: [HomePageNav_Data_Entry_Data_Tab_Model] = []
}

struct HomePageNav_Data_Entry_Model: HandyJSON {
    var id: Int = 0
    var url: String = ""
    var module: String = ""
    var channel: String = ""
    var data: HomePageNav_Data_Entry_Data_Model = HomePageNav_Data_Entry_Data_Model()
    var category: String = ""
}

enum HomePage_Nav_Type: String {
    case none
    case follow
    case tag
    case wallpaper
    case recommend
    case video_recommend
    case rn
}

struct HomePageNav_Data_Model: HandyJSON {
    var name: String = ""
    var type: String = ""
    var entry: HomePageNav_Data_Entry_Model = HomePageNav_Data_Entry_Model()
    var `default`: Bool = false
    /// nav item type
    var itemType: HomePage_Nav_Type {
        return HomePage_Nav_Type(rawValue: type) ?? .none
    }
}

struct HomePaga_Wallpaper_Data_Model: HandyJSON {
    var tag_id: Int = 0
    var tag_name: String = ""
    var `default`: Bool = false
}

// MARK: - 首页, 导航

struct HomePage_Nav: HandyJSON {
    var result: String = ""
    var data: [HomePageNav_Data_Model] = []
}

// MARK: - 首页, 壁纸, 导航

struct HomePage_Wallpaper_Nav: HandyJSON {
    var result: String = ""
    var tags: [HomePaga_Wallpaper_Data_Model] = []
    
    /// fast create model and default selected index `One`
    static func build(with parameters: [String: Any]?) -> [HomePaga_Wallpaper_Data_Model]? {
        guard let model = HomePage_Wallpaper_Nav.deserialize(from: parameters) else { return nil }
        var array: [HomePaga_Wallpaper_Data_Model] = []
        for (index, var model) in model.tags.enumerated() {
            if index == 0 {
                model.default = true
            }
            array.append(model)
        }
        return array
    }
}

// MARK: - 首页, 壁纸, 横幅

struct HomePage_Wallpaper_Banner: HandyJSON {
    var banner_id: Int = 0
    var url: String = ""
    var src: String = ""
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    var ratio: CGFloat {
        return height / width
    }
}

// MARK: - 首页, 壁纸

struct HomePage_Wallpaper: HandyJSON {
    var result: String = ""
    var more: Bool = false
    var tos_name: String = ""
    var feedList: [Recommend_Feedlist_Model] = []
    var banner: HomePage_Wallpaper_Banner?
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

struct HomePage_Recommend_FeedList_Model: HandyJSON {
    var type: String = ""
    var is_marked: Bool = false
    var entry: HomePage_Entry_Model = HomePage_Entry_Model()
}

// MARK: - 首页, 推荐

/// 首页推荐模型
struct HomePage_Recommend_Model: HandyJSON {
    var is_history: Bool = false
    var counts: Int = 0
    var feedList: [HomePage_Recommend_FeedList_Model] = []
    var message: String = ""
    var result: String = ""
    var more: Bool = false
}

// MARK: - 首页，更多

struct HomePage_More_Image_Model: HandyJSON {
    var img_id: Int = 0
    var user_id: String = ""
    var title: String = ""
    var description: String = ""
    var originalwidth: String = ""
    var originalheight: String = ""
    var created_at: String = ""
    var deleted_by: String = ""
    var camera_id: String = ""
    var md5: String = ""
    var lens_id: String = ""
    var urlString: String {
        return macro.homeNavMoreItemsBasePictureUrlString + "\(user_id)" + "/g/" + "\(img_id)" + ".jpg"
    }
}

struct HomePage_More_Item_Model: HandyJSON {
    var tag_name: String = ""
    var url: String = ""
    var tag_id: String = ""
    var image: HomePage_More_Image_Model = HomePage_More_Image_Model()
}

struct HomePage_More_Model: HandyJSON {
    var categoryName: String = ""
    var items: [HomePage_More_Item_Model] = []
    
    /// 快速的从字典构建模型
    static func build(with dict: [String: Any]) -> [HomePage_More_Model]? {
        guard let result = dict["data"] as? [String: Any] else { return nil }
        var modelsArray = [HomePage_More_Model]()
        for (key, value) in result {
            var model = HomePage_More_Model()
            model.categoryName = key
            guard let subDict = value as? [String: Any] else { return nil }
            for(_, subValue) in subDict {
                guard let dictionary = subValue as? [String: Any], let transfor = HomePage_More_Item_Model.deserialize(from: dictionary) else { return nil }
                model.items.append(transfor)
            }
            modelsArray.append(model)
        }
        return modelsArray
    }
}
