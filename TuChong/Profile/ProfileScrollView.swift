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
}

// MARK: - ProfileScrollView

class ProfileScrollView: UIScrollView {
    
    weak var profileScrollViewDelegate: ProfileScrollViewProtocol?
    
    private var defaultBarStyle: ProfileBarStyle = .light
    private var profile: ProfileModel = ProfileModel()
    
    private lazy var container: ProfileContainer = {
        let container = ProfileContainer()
        return container
    }()
    
    private lazy var scrollViewContentSize: CGSize = {
        return CGSize(width: macro.screenWidth, height: macro.screenHeight + self.container.topOffSet)
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(container)
    }
    
    func configureWith(profile: ProfileModel) {
        self.profile = profile
        self.container.configureWith(profile: profile)
        self.contentSize = self.container.contentSize
    }
}

// MARK: - Method UIScrollViewDelegate

extension ProfileScrollView: UIScrollViewDelegate {
    
    /// 改变状态栏样式
    private func needToChangeBarStyleWith(contentOffSetY: CGFloat) {
        /// disable scroll
        if contentOffSetY <= self.container.topOffSet {
            self.isScrollEnabled = true
        } else {
            self.isScrollEnabled = false
        }
        /// change bar style
        if contentOffSetY >= self.container.topOffSet - self.container.topMargin {
            guard defaultBarStyle != .dark else { return }
            self.profileScrollViewDelegate?.scrollViewNeedToChange(.dark)
            self.defaultBarStyle = .dark
        } else {
            guard defaultBarStyle != .light else { return }
            self.profileScrollViewDelegate?.scrollViewNeedToChange(.light)
            self.defaultBarStyle = .light
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        printLog(scrollView.contentOffset.y)
//        printLog(scrollView.contentSize)
//        printLog(scrollView.frame)
//        printLog(container.frame)
//        self.needToChangeBarStyleWith(contentOffSetY: scrollView.contentOffset.y)
    }
}
