//  ProfileCollectionNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/10.
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

import AsyncDisplayKit

class ProfileCollectionNode: ASCollectionNode {
    
    let type: ProfileDetailType

    private var site_id: String = ""
    private var page: Int = 0
    
    var path: String {
        switch type {
        case .work:
            return "/sites/\(site_id)/works"
        case .like:
            return "/sites/\(site_id)/favorites"
        default:
            return ""
        }
    }
    
    init(type: ProfileDetailType) {
        self.type = type
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout(), layoutFacilitator: nil)
        self.backgroundColor = Color.backGroundColor
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func configureWith(site_id: String) {
        self.site_id = site_id
        self.loadData()
    }
    
    private func loadData() {
        Network.request(target: TuChong.profile_work(path: path), success: { (responseData) in
            printLog(responseData)
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}
