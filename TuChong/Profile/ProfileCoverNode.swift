//
//  ProfileCoverNode.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/5/6.
//  Copyright © 2019 Summer. All rights reserved.
//

import AsyncDisplayKit

// MARK: - ProfileCoverNode

/// Using this 'Class' to realize the effect of round - robin diagram
class ProfileCoverNode: ASDisplayNode {
    
    private let site_id: String
    
    var cover: Profile_Cover_Model = Profile_Cover_Model()
    var timer: Timer?
    var index: Int = 0
    
    /// only have one image
    lazy var imageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        imageNode.frame = UIScreen.main.bounds
        return imageNode
    }()
    
    /// have more than one picture
    lazy var collectionNode: ProfileCoverCollectionNode = {
        let collectionNode = ProfileCoverCollectionNode(site_id: site_id)
        return collectionNode
    }()
    
    /// indicator
    lazy var indicator: CoverIndicatorView = {
        let indicator = CoverIndicatorView(frame: CGRect(x: 0, y: macro.statusBarHeight, width: macro.screenWidth, height: 1.0))
        return indicator
    }()
    
    init(site_id: String) {
        self.site_id = site_id
        super.init()
        self.backgroundColor = Color.backGroundColor
    }
    
    func configureWith(cover: Profile_Cover_Model) {
        self.cover = cover
        self.cover.images = [
            "https://photo.tuchong.com/5651394/f/110495284.jpg",
            "https://photo.tuchong.com/5651394/f/519964289.jpg",
            "https://photo.tuchong.com/5651394/f/92735104.jpg",
            "https://photo.tuchong.com/5651394/f/631899724.jpg",
            "https://photo.tuchong.com/5651394/f/382273140.jpg",
            "https://photo.tuchong.com/5651394/f/262801012.jpg",
            "https://photo.tuchong.com/5651394/f/326043254.jpg",
            "https://photo.tuchong.com/5651394/f/227542664.jpg",
            "https://photo.tuchong.com/5651394/f/443156084.jpg"
        ]
        self.reloadData()
    }
    
    private func reloadData() {
        if self.cover.images.count == 0 {
            /// do nothing
            printLog("cover iamge cont == 0")
        } else if self.cover.images.count == 1 {
            /// only have one picture
            /// 判断是否高大于宽, 是否有拉伸效果
            /// add subnode and set frame
            imageNode.url = URL(string: self.cover.images.first!)
            self.addSubnode(imageNode)
        } else {
            /// add collectionNode
            self.collectionNode.configureWith(covers: self.cover.images)
            self.collectionNode.frame = UIScreen.main.bounds
            self.addSubnode(collectionNode)
            /// set timer
            let timer = Timer(timeInterval: 1.5, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
            /// add timer to runloop
            RunLoop.current.add(timer, forMode: .common)
            self.timer = timer
        }
    }
    
    /// Change cover image
    @objc private func timerEvent() {
        self.collectionNode.triggerAnimation()
    }
    
    /// Close Timer
    func shutdownTimerImmediate() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
