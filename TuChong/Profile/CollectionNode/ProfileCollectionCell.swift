//  ProfileCollectionCell.swift
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

class ProfileCollectionCell: BaseCellNode {
    
    private let work_list_model: Profile_Work_List_Model
    private let index: Int
    
    private let insetForImageNode = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private let imageNode: ASNetworkImageNode
    
    init(work_list: Profile_Work_List_Model, index: Int) {
        self.work_list_model = work_list
        self.index = index
        self.imageNode = ASNetworkImageNode()
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        self.imageNode.url = work_list_model.entry.setCoverUrl(with: "g")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        /// set corner radius
        self.imageNode.add(cornerRadius: 4.0, backgroundColor: Color.backGroundColor, cornerRoundingType: .clipping)
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: self.imageNode)
    }
}
