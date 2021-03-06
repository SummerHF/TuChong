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
    var width: CGFloat = 0
    var height: CGFloat = 0
    var description: String = ""
    var isAuthorTK: Bool = false
    /// the url for photo
    var url: String {
        return "https://photo.tuchong.com/\(user_id)/lr/\(img_id).jpg"
    }
    /// the image scale
    var ratio: CGFloat {
        return height / width
    }
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
    var cover_url: String = ""
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

struct Recommend_Feedlist_Subnotes_Model: HandyJSON {
    var note_id: Int = 0
    var author: Recommend_Feedlist_CommensAuthor_Model = Recommend_Feedlist_CommensAuthor_Model()
    var content: String = ""
    var liked: Bool = false
}

struct Recommend_Feedlist_CommensList_Model: HandyJSON {
    var note_id: Int = 0
    var content: String = ""
    var liked: Bool = false
    var author: Recommend_Feedlist_CommensAuthor_Model = Recommend_Feedlist_CommensAuthor_Model()
    var sub_notes: [Recommend_Feedlist_Subnotes_Model] = []
}

struct Music_Beats_Item: HandyJSON {
    var sec: String = ""
    var icon_width: String = ""
    var icon_height: String = ""
    var url: String = ""
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
    var music_beats: [Music_Beats_Item] = []
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

struct Recommend_Feedlist_Site_Appearence_Model: HandyJSON {
    var color: String = ""
    var image: String = ""
}

struct Recommend_Feedlist_Site_Model: HandyJSON {
    var posts: Int = 0
    var intro: String = ""
    var site_id: String = ""
    var type: String = ""
    var comment_name: String {
        return "\(name):"
    }
    var images: [String] = []
    var name: String = ""
    var domain: String = ""
    var has_everphoto_note: Bool = false
    var recommend_reason: String = ""
    var appearance: Recommend_Feedlist_Site_Appearence_Model = Recommend_Feedlist_Site_Appearence_Model()
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
    var iconURL: URL? {
        if NSString(string: icon).contains("l_u_0") {
            return URL(string: macro.staticReplaceAvatorPlaceHolderURL)
        } else {
            return URL(string: icon)
        }
    }
    var verified_image: UIImage? {
        if 11 == verified_type {
            return R.image.verifications_green()
        } else {
             return R.image.verifications()
        }
    }
    
    var recommend_photographer_verified: Bool {
        return verification_list.count > 0
    }
    
    var recommend_photographer_verified_reason: String? {
        if let model = verification_list.first {
            return model.verification_reason
        } else {
            return nil
        }
    }

    var recommend_photographer_verified_image: UIImage? {
        if let model = verification_list.first {
            if 11 == model.verification_type {
                return R.image.verifications_green()
            } else {
                return R.image.verifications()
            }
        }
        return nil
    }
}

struct Recommend_Feedlist_RecomType_Model {
    var type: String = ""
    var reason: String = ""
    var recall_type: String = ""
}

struct Recommend_Feedlist_Eentry_Model: HandyJSON {
    /// for video
    var vid: String = ""
    var video_id: String = ""
    var cover: String = ""
    var raw_cover: String = ""
    var video_width: CGFloat = 0.0
    var video_height: CGFloat = 0.0
    var share_url: String = ""
    var share_cover: String = ""
    var duration: CGFloat = 0.0
    var is_recommend: Bool = false
    var is_ultra: Bool = false
    var category: [String] = []
    var gif_cover: String = ""
    var author: Recommend_Feedlist_Site_Model = Recommend_Feedlist_Site_Model()
    var is_hot: Bool = false
    var passed_time: String = ""
    ///
    var vote: Int = 0
    var rank: Int = 0
    var in_vote: Bool = false
    var post_id: String = ""
    var site_id: String = ""
    var excerpt: String = ""
    var author_id: String = ""
    var type: String = ""
    var url: String = ""
    var published_at: String = ""
    var parent_comments: Int = 0
    var favorites: Int = 0
    var comments: Int = 0
    var title: String = ""
    var app_url: String = ""
    var image_count: Int = 0
    var iamge_count_desc: String {
        return "\(image_count) " + R.string.localizable.pictures()
    }
    var rewardable: Bool = false
    var rewards: Int = 0
    var wallpaper: Bool = false
    var views: Int = 0
    
    func text_length_with(count: Int, font: UIFont) -> CGFloat {
        let contentSpacing: CGFloat = 4
        let imageWidth: CGFloat = 15
        return "\(count)".size(withAttributes: [NSAttributedString.Key.font: font]).width + contentSpacing + imageWidth
    }
    
    var collected: Bool = false
    var downloads: Int = 0
    var shares: Int = 0
    var collect_num: Int = 0
    var delete: Bool = false
    var content: String = ""
    var update: Bool = false
    var is_favorite: Bool = false
    var is_top: Bool = false
    var data_type: String = ""
    var created_at: String = ""
    /// wait to confirm
    var attend_event: String = ""
    var rqt_id: String = ""
    var users: [Recommend_Feedlist_Users_Model] = []
    var site: Recommend_Feedlist_Site_Model = Recommend_Feedlist_Site_Model()
    /// wait to confirm
    var sites: String?
    var recom_type: Recommend_Feedlist_RecomType_Model = Recommend_Feedlist_RecomType_Model()
    var music: Recommend_Feedlist_Music_Model?
    var comment_list: [Recommend_Feedlist_CommensList_Model]?
    var equip: Recommend_Feedlist_Equip_Model?
    var images: [Recommend_Feedlist_Images_Model] = []
    var image_srcs: [String] = []
    var image_srcs_cover: String {
        return image_srcs.first ?? ""
    }
    var title_image: HomePage_Entry_TitleImage_Model = HomePage_Entry_TitleImage_Model()
    /// Take the first photo as the cover
    var image_cover: String {
        guard let image = images.first else { return "" }
        return image.url
    }
    /// Take the first photo as the cover and caculate cover ratio
    var image_cover_ratio: CGFloat {
        guard let image = images.first else { return 1.0 }
        return image.height / image.width
    }
    var tags: [Recommend_Feedlist_Tags_Model] = []
    var favorites_description: String {
        return "\(favorites)" + R.string.localizable.likes() + " >"
    }
    var favorites_desc: NSMutableAttributedString {
        let string = "\(favorites)" + R.string.localizable.likes()
        let mutableAttr = NSMutableAttributedString(string: string, attributes: [NSAttributedString.Key.font: UIFont.normalFont_13(),
                                                                                  NSAttributedString.Key.foregroundColor: UIColor.black
                                                                                  ])
        mutableAttr.addAttributes([NSAttributedString.Key.font: UIFont.boldFont_13(),
                                   NSAttributedString.Key.foregroundColor: UIColor.black], range: NSString(string: string).range(of: "\(favorites)"))
        return mutableAttr
    }
    
    /// Profile activity cover image url
    func setCoverUrl(with decorate: String) -> URL? {
        guard let image = images.first else { return nil }
        return URL(string: "https://photo.tuchong.com/\(image.user_id)/\(decorate)/\(image.img_id).jpg")
    }
    
    var summary_desc: String {
        return "\(favorites)喜欢 \(comments)评论"
    }
}

// MARK: - Feedlist

/// use this enum to decide how to show image
enum StageType: String {
    case banner
    case text
    case multi_photo
    case collection
    case music
    case video
    case none
    case site_list
    case topic
    
    init(outType: String, innerType: String, isMusic: Bool) {
        if outType == "banner" {
            self = .banner
        } else if outType == "video" {
            self = .video
        } else if outType == "post" {
            if innerType == "text" {
                self = .text
            } else if innerType == "multi-photo" {
                self = .multi_photo
            } else if innerType == "collection" {
                self = .collection
            } else if isMusic {
                self = .music
            } else {
                self = .none
            }
        } else if outType == "site-list" {
            self = .site_list
        } else if outType == "topic" {
            self = .topic
        } else {
            self = .none
        }
    }
}

struct Recommend_Feedlist_Model: HandyJSON {
    /// whether the cell folds
    var isFolding: Bool = true
    var type: String = ""
    var is_marked: Bool = false
    var entry: Recommend_Feedlist_Eentry_Model = Recommend_Feedlist_Eentry_Model()
    /// how to show the content
    var stageType: StageType {
        return StageType(outType: type, innerType: entry.type, isMusic: entry.music != nil)
    }
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

struct RecommendTagsModel: HandyJSON {
    var result: String = ""
    var post_list: [Recommend_Feedlist_Eentry_Model] = []
}

//sites": [{
//"site_id": "4873279",
//"type": "user",
//"name": "Frank\u90d1\u5e06",
//"domain": "zhengfanfrank.tuchong.com",
//"url": "https:\/\/zhengfanfrank.tuchong.com\/",
//"icon": "http:\/\/sf3-tccdn-tos.pstatp.com\/obj\/tuchong-avatar\/ll_4873279_1",
//"description": "\u81ea\u7531\u6444\u5f71\u5e08 \u5fae\u535a:@Frank\u90d1\u5e06",
//"intro": "\u81ea\u7531\u6444\u5f71\u5e08 \u5fae\u535a:@Frank\u90d1\u5e06",
//"posts": 43,
//"appearance": {
//    "color": "#000",
//    "image": "http:\/\/sf3-tccdn-tos.pstatp.com\/obj\/tuchong-avatar\/h_u_0"
//},
//"is_bind_everphoto": false,
//"followers": 1995,
//"members": 0,
//"group_posts": 0,
//"recommend_reason": "\u4f5c\u54c1 43  \u7c89\u4e1d 1995",
//"verified": false,
//"verified_type": 0,
//"verified_reason": "",
//"verifications": 0,
//"verification_list": [],
//"images": [{
//"img_id": 324473171,
//"user_id": 4873279,
//"title": "001",
//"excerpt": "",
//"width": 1666,
//"height": 2499,
//"is_authorized_tc": 0
//}, {
//"img_id": 276500724,
//"user_id": 4873279,
//"title": "001",
//"excerpt": "",
//"width": 1666,
//"height": 2499,
//"is_authorized_tc": 0
//}, {
//"img_id": 67111818,
//"user_id": 4873279,
//"title": "001",
//"excerpt": "",
//"width": 1666,
//"height": 2499,
//"is_authorized_tc": 1
//}],
//"is_following": false,
//"is_follower": false
//}
