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
    private var work_model = Profile_Work_Model()
    private var layouts: UICollectionViewFlowLayout
    
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
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        self.layouts = layout
        super.init(frame: CGRect.zero, collectionViewLayout: layout, layoutFacilitator: nil)
        self.backgroundColor = Color.backGroundColor
        self.dataSource = self
        self.delegate = self
        self.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
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
            self.work_model = Profile_Work_Model.buildWith(dict: responseData)
            self.reloadData()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
}

extension ProfileCollectionNode: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return self.work_model.work_list.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return ProfileCollectionCell(work_list: self.work_model.work_list[indexPath.row], index: indexPath.row)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let paddding: CGFloat =  15
        let column: CGFloat = 2
        let oneItemWidth = (self.view.width - (column - 1.0) * paddding - self.contentInset.left * 2.0 ) / column
        let size = CGSize(width: oneItemWidth, height: oneItemWidth)
        return ASSizeRange(min: size, max: size)
    }
}
