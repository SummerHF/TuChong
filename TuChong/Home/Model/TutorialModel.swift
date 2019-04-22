//  TutorialModel.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/22.
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

struct Tutorial_Data_Model {
    
    let tutorial_id: String
    let tutorial_name: String
    var `default`: Bool
    
    init(tutorial_id: String, tutorial_name: String, index: Int) {
        /// default selected all category
        self.default = index == 0 ? true : false
        self.tutorial_id = tutorial_id
        self.tutorial_name = tutorial_name
    }
    
    /// Get all category of tutorials
    /// https://tuchong.com/rest/sites/1615439,1615432,1615443,1615461,1615437/posts?page=1&count=10
    static func allTutorial() -> [Tutorial_Data_Model] {
        let idArray = ["1615439,1615432,1615443,1615461,1615437", "1615439", "1615432", "1615443", "1615461", "1615437"]
        let titleArray = [R.string.localizable.all(),
                          R.string.localizable.portrait(),
                          R.string.localizable.post_revision(),
                          R.string.localizable.phone_photo(),
                          R.string.localizable.equipment_application(),
                          R.string.localizable.shooting_skills()
                         ]
        var modelArray: [Tutorial_Data_Model] = []
        for i in 0..<idArray.count {
            let item = Tutorial_Data_Model(tutorial_id: idArray[i], tutorial_name: titleArray[i], index: i)
            modelArray.append(item)
        }
        return modelArray
    }
}
