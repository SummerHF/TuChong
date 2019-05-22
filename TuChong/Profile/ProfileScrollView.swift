//  ProfileScrollView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/8.
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

import UIKit

// MARK: - ProfileScrollViewDelegate

protocol ProfileScrollViewProtocol: NSObjectProtocol {
    func scrollViewNeedToChange(_ barStyle: ProfileBarStyle)
    func backgroundViewNeedToShrinkWith(offSet: CGFloat)
}

// MARK: - ProfileScrollView

class ProfileScrollView: UIScrollView {
    
    weak var profileScrollViewDelegate: ProfileScrollViewProtocol?
    
    private var defaultBarStyle: ProfileBarStyle = .light
    private var profile: ProfileModel = ProfileModel()
    
    /// 是否可以滚动, 默认false
    private var canScroll: Bool = true
    
    private lazy var container: ProfileContainer = {
        let container = ProfileContainer()
        return container
    }()
    
    private var deltaY: CGFloat {
        return self.container.contentSizeHeight - self.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.showsVerticalScrollIndicator = false 
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(container)
        self.addNotification()
    }
    
    func configureWith(profile: ProfileModel) {
        self.profile = profile
        self.container.configureWith(profile: profile)
        self.contentSize = self.container.contentSize
    }
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: NotificationName.detailViewHasScrollToTop, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableScrollWhenDetailViewHasEndScrolled), name: NotificationName.detailViewHasBeginScroll, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableScrollWhenDetailViewHasBenginScrolled), name: NotificationName.detailViewHasEndScroll, object: nil)
    }
    
    @objc private func handleNotification() {
        self.canScroll = true
    }
    
    @objc private func enableScrollWhenDetailViewHasBenginScrolled() {
        self.isScrollEnabled = true
    }
    
    @objc private func disableScrollWhenDetailViewHasEndScrolled() {
        self.isScrollEnabled = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Method UIScrollViewDelegate

extension ProfileScrollView: UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self == scrollView {
            self.needToChangeScrollStatusWith(contentOffSetY: scrollView.contentOffset.y)
            self.needToChangeBarStyleWith(contentOffSetY: scrollView.contentOffset.y)
            self.needToShrinkImageWhenCoverNodeHasOneImageWith(contentOffSetY: scrollView.contentOffset.y)
        }
    }
    
    /// 设置联动
    private func needToChangeScrollStatusWith(contentOffSetY: CGFloat) {
        /// disable scroll
        if contentOffSetY >= self.deltaY {
            self.contentOffset.y = self.deltaY
            if self.canScroll {
                self.canScroll = false
                self.container.scroll(enabled: true)
            }
        } else {
            if !self.canScroll {
                self.contentOffset.y = self.deltaY
            }
        }
        
    }
    
    /// 改变状态栏样式
    private func needToChangeBarStyleWith(contentOffSetY: CGFloat) {
        /// change bar style
        if contentOffSetY >= macro.topHeight {
            guard defaultBarStyle != .dark else { return }
            self.profileScrollViewDelegate?.scrollViewNeedToChange(.dark)
            self.defaultBarStyle = .dark
        } else {
            guard defaultBarStyle != .light else { return }
            self.profileScrollViewDelegate?.scrollViewNeedToChange(.light)
            self.defaultBarStyle = .light
        }
    }
    
    /// 缩放背景图片
    private func needToShrinkImageWhenCoverNodeHasOneImageWith(contentOffSetY: CGFloat) {
        guard profile.coverType == .singleHorizentalImage else { return }
        if contentOffSetY <= 0 {
            self.profileScrollViewDelegate?.backgroundViewNeedToShrinkWith(offSet: contentOffSetY)
        }
    }
}
