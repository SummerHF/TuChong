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

enum Tutorial {
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
