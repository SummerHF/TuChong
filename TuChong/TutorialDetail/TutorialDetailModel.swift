//  TutorialDetailModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/23.
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

// MARK: - enum

enum Tutorial {
    
    static let count = 3
    case head
    case webView
    case info
    case unknow
    
    init(index: Int) {
        switch index {
        case 0:
            self = .head
        case 1:
            self = .webView
        case 2:
            self = .info
        default:
            self = .unknow
        }
    }
}

enum TutorialGroup {
    /// section count
    static let section = 2
    static let groupOne = 1
    static let footerHeight: CGFloat = 0.00001
    static let headerHeight: CGFloat = 64.0

    case top
    case comment
    case unknow
    
    init(section: Int) {
        switch section {
        case 0:
            self = .top
        case 1:
            self = .comment
        default:
            self = .unknow
        }
    }
    
    /// num of section
    static func numOfSection(isRequestFinished: Bool) -> Int {
        return isRequestFinished ? TutorialGroup.section : 0
    }
    
    /// num of rows
    static func numOfRows(in section: Int, isRequestFinished: Bool) -> Int {
        if isRequestFinished {
            switch TutorialGroup(section: section) {
            case .top:
                return Tutorial.count
            case .comment:
                return 1
            case .unknow:
                return 0
            }
        } else {
            return 0
        }
    }
    
    static func heightFotHeader(at section: Int, isRequestFinished: Bool, commentCount: Int) -> CGFloat {
        if isRequestFinished && commentCount > 0 {
        switch TutorialGroup(section: section) {
        case .top:
            return TutorialGroup.footerHeight
        case .comment:
            return TutorialGroup.headerHeight
        default:
            return TutorialGroup.footerHeight
            }
        } else {
            return TutorialGroup.footerHeight
        }
    }
}

// MARK: - Tutorial_Detail_Profile_Model

struct Tutorial_Detail_Profile_Model: HandyJSON {
    var result: String = ""
    var post: Recommend_Feedlist_Eentry_Model = Recommend_Feedlist_Eentry_Model()
}

struct Tutorial_Detail_Reward_Post_Model: HandyJSON {
    var rewards: String = ""
    var reward_money: Int = 0
    var reward_list: [Recommend_Feedlist_Site_Model] = []
    
    var reward_desc: NSMutableAttributedString {
        guard let reward = reward_list.first else { return NSMutableAttributedString() }
        let reward_user_name = reward.name
        let reward_count = reward_list.count
        let string = reward_count > 1 ? String(format: "%@等共%d人赞助", reward_user_name, reward_count) :
        String(format: "%@共%d人赞助", reward_user_name, reward_count)
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attr = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_13(),
            NSAttributedString.Key.foregroundColor: Color.lightGray,
            NSAttributedString.Key.paragraphStyle: style
            ])
        attr.addAttributes([
            NSAttributedString.Key.foregroundColor: Color.blueColor
            ], range: NSString(string: string).range(of: reward_user_name))
        attr.addAttributes([
            NSAttributedString.Key.foregroundColor: Color.orangerColor
            ], range: NSString(string: string).range(of: "\(reward_count)"))
        return attr
    }
}

struct Tutorial_Detail_Reward_Info_Model: HandyJSON {
    var post: Tutorial_Detail_Reward_Post_Model = Tutorial_Detail_Reward_Post_Model()
}

struct Tutorial_Detail_Reward_Model: HandyJSON {
    var result: String = ""
    var message: String = ""
    var data: Tutorial_Detail_Reward_Info_Model = Tutorial_Detail_Reward_Info_Model()
    
    /// Fast creaet model
    static func build(with dict: [String: Any]) -> Tutorial_Detail_Reward_Post_Model? {
        guard let model = Tutorial_Detail_Reward_Model.deserialize(from: dict) else { return nil }
        return model.data.post.reward_list.count > 0 ? model.data.post : nil
    }
}

// MARK: - Tutorial_Detail_Comment_Model

struct Tutorial_Comment_Item_Model: HandyJSON {
    var note_id: String = ""
    var post_id: String = ""
    var type: String = ""
    var content: String = ""
    var created_at: String = ""
    var delete: Bool = false
    var reply: Bool = false
    var author_id: String = ""
    var anonymous: Int = 0
    var likes: Int = 0
    var sub_notes_count: Int = 0
    var parent_note_id: String = ""
    var reply_to_note_id: String = ""
    var liked: Bool = false
    var author: Recommend_Feedlist_Site_Model = Recommend_Feedlist_Site_Model()
    /// 最后回复
    var last_replied: Recommend_Feedlist_Site_Model = Recommend_Feedlist_Site_Model()
    var reply_to: [Recommend_Feedlist_Site_Model] = []
    var reply_to_array: [String] = []
    var sub_notes: [Tutorial_Comment_Item_Model] = []
}

struct Tutorial_Detail_Comment_Model: HandyJSON {
    var before_timestamp: String = ""
    var comments: String = ""
    var parent_comments: String = ""
    var more: Bool = false
    var baseUrl: String = ""
    var result: String = ""
    var commentlist: [Tutorial_Comment_Item_Model] = []
    
    /// comments count
    var comment_count: Int {
        return NSString(string: comments).integerValue
    }
    
    static func build(with dict: [String: Any]) -> Tutorial_Detail_Comment_Model {
        guard let model = Tutorial_Detail_Comment_Model.deserialize(from: dict)  else { return  Tutorial_Detail_Comment_Model() }
        return model
    }
}
