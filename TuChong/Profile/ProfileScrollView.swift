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
import Kingfisher
import AsyncDisplayKit

// MARK: - ProfileContainer

class ProfileContainer: UIView {
    
    private let bgImageView: UIImageView
    private let avatorImageNode: ASNetworkImageNode
    private let margin: CGFloat = 20.0
    private let avatorImageViewSize = CGSize(width: 72, height: 72)
    
    let topMargin: CGFloat = macro.statusBarHeight + 20

    var topOffSet: CGFloat {
        switch profile.coverType {
        case .none:
            return topMargin
        case let .singleImage(showType):
            if showType == .horizental {
                return macro.screenHeight * 0.4
            } else {
                return macro.screenHeight * 0.6
            }
        case .moreImage:
            return macro.screenHeight * 0.6
        }
    }
    
    private var profile: ProfileModel = ProfileModel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.bgImageView = UIImageView()
        self.avatorImageNode = ASNetworkImageNode()
        super.init(frame: CGRect.zero)
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(bgImageView)
        self.addSubview(avatorImageNode.view)
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.avatorImageNode.view.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalTo(self.snp.top)
            make.size.equalTo(avatorImageViewSize)
        }
        self.bgImageView.image = UIImage(color: UIColor.white)?.byResize(to: UIScreen.main.bounds.size)?.byRoundCornerRadius(15.0)
    }
    
    func configureWith(profile: ProfileModel) {
        self.profile = profile
        self.frame = CGRect(x: 0, y: topOffSet, width: macro.screenWidth, height: macro.screenHeight)
        self.avatorImageNode.url = URL(string: profile.site.icon)
        self.avatorImageNode.imageModificationBlock = {
            image in
            image.byRoundCornerRadius(image.size.width / 2.0, borderWidth: 2.0, borderColor: Color.backGroundColor)
        }
    }
}

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
        self.contentSize = scrollViewContentSize
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
        self.needToChangeBarStyleWith(contentOffSetY: scrollView.contentOffset.y)
    }
}
