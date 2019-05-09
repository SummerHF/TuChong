//  ProfileModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/6.
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

struct Profile_AC_Camera_Model: HandyJSON {
    var obtained_num: Int = 0
    var adorned: String = ""
}

// MARK: - Profile Site

struct Profile_Site_Model: HandyJSON {
    var site_id: String = ""
    var type: String = ""
    var name: String = ""
    var domain: String = ""
    var url: String = ""
    var icon: String = ""
    var description: String = ""
    var intro: String = ""
    var appearance: Recommend_Feedlist_Site_Appearence_Model = Recommend_Feedlist_Site_Appearence_Model()
    var followers: Int = 0
    var members: Int = 0
    var group_posts: Int = 0
    var recommend_reason: String = ""
    var verified: Bool = false
    var verified_type: Int = 0
    var verified_reason: String = ""
    var verifications: Int = 0
    var verification_list: [Recommend_Feedlist_Verification_List_Model] = []
    var point_level: Int = 0
    var is_following: Bool = false
    var is_follower: Bool = false
    var ac_camera: Profile_AC_Camera_Model = Profile_AC_Camera_Model()
    var owner_tag: [String] = []
    var qualified: Bool = false
    var following: Int = 0
    var favorites: Int = 0
    var favorites_v1: Int = 0
    var user_gender: String = ""
    var user_location: String = ""
    var tags: [HomePage_Entry_Tags_Model] = []
    var cover_url: String = ""
    
    var intro_desc: String {
        return intro.count > 0 ? intro : "他注定是个低调的大侠, 所以什么都没写"
    }
    
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
            /// 12, 13, 14
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
    
    func intro_attributedtext(desc: String, count: Int) -> NSMutableAttributedString {
        let string = "\(desc) \(count)"
        let attr = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: UIFont.thinFont_12(),
            NSAttributedString.Key.foregroundColor: Color.black
            ])
        attr.addAttributes([NSAttributedString.Key.font: UIFont.boldFont_20(),
            NSAttributedString.Key.baselineOffset: -1
            ], range: NSString(string: string).range(of: "\(count)"))
        return attr
    }
}

// MARK: - Profile Cover

struct Profile_Cover_Size_Model: HandyJSON {
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
}

struct Profile_Cover_Model: HandyJSON {
    var post_id: String = ""
    var images: [String] = []
    var sizes: [Profile_Cover_Size_Model] = []
}

// MARK: - Profile Statistics

struct Profile_Statistics_Model: HandyJSON {
    var works: Int = 0
    var favorites: Int = 0
    var events: Int = 0
}

// MARK: - Profile Relationship

struct Profile_Relationship_Model: HandyJSON {
    var to_id: String = ""
    var is_following: Int = 0
}

// MARK: - ProfileModel

enum ProfileCoverSingleImageShowType {
    case vertical
    case horizental
}

enum ProfileCoverType {
    case none
    case singleImage(showType: ProfileCoverSingleImageShowType)
    case moreImage
}

struct ProfileModel: HandyJSON {
    var result: String = ""
    var site: Profile_Site_Model = Profile_Site_Model()
    var cover: Profile_Cover_Model = Profile_Cover_Model()
    var statistics: Profile_Statistics_Model = Profile_Statistics_Model()
    var relationship: Profile_Relationship_Model = Profile_Relationship_Model()

    /// 图片的显示类型
    var coverType: ProfileCoverType {
        if cover.images.count == 0 {
            return .none
        } else if cover.images.count == 1 {
            let size = cover.sizes.first!
            if size.width >= size.height {
                return .singleImage(showType: .horizental)
            } else {
                return .singleImage(showType: .vertical)
            }
        } else {
            return .moreImage
        }
    }
}
