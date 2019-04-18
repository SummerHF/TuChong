//
//  VideoNavNode.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/4/18.
//  Copyright © 2019 Summer. All rights reserved.
//

import AsyncDisplayKit

@objc protocol VideoNavNodeProtocol {
    @objc optional func homeNav(node: HomeNavNode, selectedBtn: HomeNavItemButton, with index: Int)
    @objc optional func homeNavNodeMoreBtnEvent(node: HomeNavNode)
}

class VideoNavNode: ASDisplayNode {
    
    private var dataArray: [HomePageNav_Data_Model]
    weak var delegate: VideoNavNodeProtocol?
    
    init(data: [HomePageNav_Data_Model], delegate: VideoNavNodeProtocol) {
        self.dataArray = data
        self.delegate = delegate
        super.init()
    }
    
    override func didLoad() {
        self.backgroundColor = Color.lineColor
        self.frame = CGRect(x: 0, y: macro.videoNavTop, width: macro.screenWidth, height: macro.videonavHeight)
    }
}
