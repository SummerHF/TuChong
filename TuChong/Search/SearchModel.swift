//  SearchModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/4.
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

struct Search_Hot_Photographer_User_Verification: HandyJSON {
    var verification_type: Int = 0
    var verification_reason: String = ""
}

struct Search_Hot_Photographer_User: HandyJSON {
    var site_id: Int = 0
    var type: String = ""
    var name: String = ""
    var domain: String = ""
    var description: String = ""
    var followers: Int = 0
    var url: String = ""
    var icon: String = ""
    var verifications: Int = 0
    var verification_list: [Search_Hot_Photographer_User_Verification] = []
    var images: [String] = []
    var is_following: Bool = false
    var is_follower: Bool = false
}

struct Search_Hot_Photographer: HandyJSON {
    var result: String = ""
    var hot_day: String = ""
    var author_list: [Search_Hot_Photographer_User] = []
}
