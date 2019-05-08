//  ProfileCoverNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/7.
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

// MARK: - ProfileCoverNode

/// Using this 'Class' to realize the effect of round - robin diagram
class ProfileCoverNode: ASDisplayNode {
    
    private let site_id: String
    
    var cover: Profile_Cover_Model = Profile_Cover_Model()
    var timer: Timer?
    var index: Int = 1
    
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
        let x: CGFloat = 20
        let y: CGFloat = macro.statusBarHeight + 1.0
        let width: CGFloat = macro.screenWidth - x * 2
        let indicator = CoverIndicatorView(frame: CGRect(x: x, y: y, width: width, height: 1.8))
        return indicator
    }()
    
    /// shadowImage
    lazy var shadowImage: ASImageNode = {
        let shadowImage = ASImageNode()
//        shadowImage.image = R.image.cover()
        return shadowImage
    }()
    
    init(site_id: String) {
        self.site_id = site_id
        super.init()
        self.backgroundColor = Color.backGroundColor
    }
    
    func configureWith(cover: Profile_Cover_Model) {
        self.cover = cover
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
            /// add shadow
//            self.shadowImage.frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: macro.shadowHeight)
//            self.addSubnode(shadowImage)
            /// add indicator
            self.view.addSubview(indicator)
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
        /// indcator
        index += 1
        let count = self.cover.images.count
        if index <= count {
            let percent = CGFloat(index) / CGFloat(count)
            self.indicator.triggerAnimation(with: percent, animated: true)
        } else {
            index = 1
            let percent = CGFloat(index) / CGFloat(count)
            self.indicator.triggerAnimation(with: percent, animated: false)
        }
    }
    
    /// Close Timer
    func shutdownTimerImmediate() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
