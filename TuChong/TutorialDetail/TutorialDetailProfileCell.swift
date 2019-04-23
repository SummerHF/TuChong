//
//  TutorialDetailProfileCell.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/4/23.
//  Copyright © 2019 Summer. All rights reserved.
//

import AsyncDisplayKit

/// 教程详情 ---- 用户信息
class TutorialDetailProfileCell: ASCellNode {
    
    private let model: Recommend_Feedlist_Eentry_Model
    private let index: IndexPath
    
    init(post model: Recommend_Feedlist_Eentry_Model, indexPath: IndexPath) {
        self.model = model
        self.index = indexPath
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
    }
}
