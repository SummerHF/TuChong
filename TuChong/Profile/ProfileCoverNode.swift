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
    
    lazy var firstImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        return imageNode
    }()
    
    lazy var secondImageNode: ASNetworkImageNode = {
        let imageNode = ASNetworkImageNode()
        return imageNode
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
            printLog("cover iamge cont == 0")
        } else if self.cover.images.count == 1 {
            /// only have one picture
            /// 判断是否高大于宽, 是否有拉伸效果
            /// add subnode and set frame
            self.addSubnode(firstImageNode)
            firstImageNode.frame = UIScreen.main.bounds
        } else {
            /// add subnode and set frame
            self.addSubnode(firstImageNode)
            self.addSubnode(secondImageNode)
            firstImageNode.frame = UIScreen.main.bounds
            secondImageNode.frame = CGRect(x: macro.screenWidth, y: 0, width: macro.screenWidth, height: macro.screenHeight)
            /// have more than one picture
            self.firstImageNode.url = URL(string: self.cover.images[index])
            index += 1
            self.secondImageNode.url = URL(string: self.cover.images[index])
            /// set timer
            let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
            /// add timer to runloop
            RunLoop.current.add(timer, forMode: .common)
            self.timer = timer
        }
    }
    
    /// Change cover image
    @objc private func timerEvent() {
        UIView.animate(withDuration: 1.0, animations: {
            if self.firstImageNode.view.left > self.secondImageNode.view.left {
                self.firstImageNode.view.left -= macro.screenWidth
                self.secondImageNode.view.left -= macro.screenWidth
            } else {
                self.secondImageNode.view.left -= macro.screenWidth
                self.firstImageNode.view.left -= macro.screenWidth
            }
        }) { _ in
            if self.firstImageNode.view.left == -macro.screenWidth {
                self.firstImageNode.view.left = macro.screenWidth
            }
            if self.secondImageNode.view.left == -macro.screenWidth {
                self.secondImageNode.view.left = macro.screenWidth
            }
        }
    }
    
    /// Close Timer
    func shutdownTimerImmediate() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
