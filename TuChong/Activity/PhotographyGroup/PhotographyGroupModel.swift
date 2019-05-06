//  PhotographyGroupModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/5.
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

struct Photography_Group_Post_Image_ModeL: HandyJSON {
    var img_id: Int = 0
    var user_id: Int = 0
    var title: String = ""
    var excerpt: String = ""
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    var is_authorized_tc: Int = 0
    var url: String = ""
}

struct Photography_Group_Post_ModeL: HandyJSON {
    var post_id: String = ""
    var type: String = ""
    var url: String = ""
    var site_id: String = ""
    var author_id: String = ""
    var published_at: String = ""
    var passed_time: String = ""
    var excerpt: String = ""
    var favorites: Int = 0
    var comments: Int = 0
    var rewardable: Bool = false
    var parent_comments: String = ""
    var rewards: String = ""
    var views: Int = 0
    var collected: Bool = false
    var shares: Int = 0
    var title: String = ""
    var image_count: Int = 0
    var cover_image: Photography_Group_Post_Image_ModeL = Photography_Group_Post_Image_ModeL()
    var images: [Photography_Group_Post_Image_ModeL] = []
}

struct Photography_Group_Item_ModeL: HandyJSON {
    var site_id: String = ""
    var type: String = ""
    var name: String = ""
    var domain: String = ""
    var url: String = ""
    var icon: String = ""
    var description: String = ""
    var intro: String = ""
    var posts: Int = 0
    var appearance: Recommend_Feedlist_Site_Appearence_Model = Recommend_Feedlist_Site_Appearence_Model()
    var is_bind_everphoto: Bool = false
    var has_everphoto_note: Bool = false
    var followers: Int = 0
    var members: Int = 0
    var group_posts: Int = 0
    var recommend_reason: String = ""
    var verified: Bool = false
    var verified_reason: String = ""
    var verified_type: Int = 0
    var verifications: Int = 0
    var verification_list: [String] = []
    var joined: Bool = false
    var post_list: [Photography_Group_Post_ModeL] = []
}

struct Photography_Group_Info_ModeL: HandyJSON {
    var more: Bool = false
    var before_timestamp: String = ""
    var group_list: [Photography_Group_Item_ModeL] = []
}

struct Photography_Group_ModeL: HandyJSON {
    var message: String = ""
    var result: String = ""
    var data: Photography_Group_Info_ModeL = Photography_Group_Info_ModeL()
    
    static func build(with dict: [String: Any]) -> [Photography_Group_Item_ModeL] {
        guard let model = Photography_Group_ModeL.deserialize(from: dict) else { return [] }
        return model.data.group_list
    }
}
