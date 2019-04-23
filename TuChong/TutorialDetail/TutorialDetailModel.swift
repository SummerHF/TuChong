//
//  TutorialDetailModel.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/4/23.
//  Copyright © 2019 Summer. All rights reserved.
//

import Foundation
import HandyJSON

enum Tutorial {
    case head
    case webView
    case unknow
    
    init(index: Int) {
        switch index {
        case 0:
            self = .head
        case 1:
            self = .webView
        default:
            self = .unknow
        }
    }
}

struct Tutorial_Detail_Profile_Model: HandyJSON {
    var result: String = ""
    var post: Recommend_Feedlist_Eentry_Model = Recommend_Feedlist_Eentry_Model()
}
