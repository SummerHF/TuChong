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
    private let avatorImageViewSize = CGSize(width: 70, height: 70)
    private let focusBtnNodeSize = CGSize(width: 70, height: 28)
    private let focusBtnNode: ASButtonNode

    private let nameLable: UILabel = UILabel()
    private let vertificationImageView: UIImageView = UIImageView()
    private let vertificationImageViewWidth: CGFloat = 12.0
    private let vertificationReasonLable: UILabel = UILabel()
    private let introLable: UILabel = UILabel()
    private let introLableMaxWidth: CGFloat = macro.screenWidth - 4.8 * 20
    private let moreBtnNode: ASButtonNode = ASButtonNode()
    private let moreBtnNodeSize = CGSize(width: 44, height: 14)

    let topMargin: CGFloat = macro.statusBarHeight + 20

    var topOffSet: CGFloat {
        switch profile.coverType {
        case .none:
            return topMargin
        case let .singleImage(showType):
            if showType == .horizental {
                return macro.screenHeight * 0.4
            } else {
                return macro.screenHeight * 0.732
            }
        case .moreImage:
            return macro.screenHeight * 0.732
        }
    }
    
    private var profile: ProfileModel = ProfileModel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.bgImageView = UIImageView()
        self.avatorImageNode = ASNetworkImageNode()
        self.focusBtnNode = ASButtonNode()
        super.init(frame: CGRect.zero)
        self.setPropertys()
        self.addEvents()
    }
    
    private func setPropertys() {
        self.addSubview(bgImageView)
        self.addSubview(avatorImageNode.view)
        self.addSubview(nameLable)
        self.addSubview(focusBtnNode.view)
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.bgImageView.image = UIImage(color: UIColor.white)?.byResize(to: UIScreen.main.bounds.size)?.byRoundCornerRadius(15.0)
        
        /// user info
        self.avatorImageNode.view.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalTo(self.snp.top).offset(margin * 0.5)
            make.size.equalTo(avatorImageViewSize)
        }
        self.nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(avatorImageNode.view)
            make.top.equalToSuperview().offset(margin * 3.10)
        }
        self.focusBtnNode.view.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-margin)
            make.centerY.equalTo(nameLable)
            make.size.equalTo(focusBtnNodeSize)
        }
    }
    
    func configureWith(profile: ProfileModel) {
        self.profile = profile
        /// avator
        self.avatorImageNode.url = profile.site.iconURL
        self.avatorImageNode.imageModificationBlock = {
            image in
            image.byRoundCornerRadius(image.size.width / 2.0, borderWidth: 2.0, borderColor: Color.backGroundColor)
        }
        self.nameLable.set(title: profile.site.name, font: UIFont.boldFont_20(), color: Color.black)
        self.focusBtnNode.setAttributdWith(string: R.string.localizable.focus(), font: UIFont.normalFont_12(), color: Color.backGroundColor, state: .normal)
        self.focusBtnNode.add(cornerRadius: focusBtnNodeSize.height / 2.0, backgroundColor: Color.lineColor, cornerRoundingType: .defaultSlowCALayer)
        
        /// intro
        self.addSubview(introLable)
        if profile.site.recommend_photographer_verified {
            self.addSubview(vertificationImageView)
            self.addSubview(vertificationReasonLable)
            self.vertificationImageView.snp.makeConstraints { (make) in
                make.left.equalTo(nameLable)
                make.top.equalTo(nameLable.snp.bottom).offset(margin)
                make.size.equalTo(CGSize(width: vertificationImageViewWidth, height: vertificationImageViewWidth))
            }
            self.vertificationReasonLable.snp.makeConstraints { (make) in
                make.left.equalTo(vertificationImageView.snp.right).offset(margin * 0.2)
                make.centerY.equalTo(vertificationImageView)
            }
            self.introLable.snp.makeConstraints { (make) in
                make.top.equalTo(vertificationImageView.snp.bottom).offset(margin * 0.3)
                make.left.equalTo(vertificationImageView)
                make.width.equalTo(introLableMaxWidth)
            }
            self.vertificationImageView.image = profile.site.verified_image
            self.vertificationReasonLable.set(title: profile.site.verified_reason, font: UIFont.normalFont_12(), color: Color.black)
        } else {
            self.introLable.snp.makeConstraints { (make) in
                make.left.equalTo(nameLable)
                make.top.equalTo(nameLable.snp.bottom).offset(margin)
                make.width.equalTo(introLableMaxWidth)
            }
        }
        self.introLable.numberOfLines = 1
//        self.profile.site.intro = """
//        哈哈哈哈哈哈哈哈哈哈
//        哈哈哈哈哈哈哈哈哈哈哈哈哈
//        哈哈哈哈哈哈哈哈哈哈哈哈哈哈
//        哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈
//        """
        self.introLable.set(title: profile.site.intro, font: UIFont.normalFont_12(), color: Color.lightGray)
        
        /// need to show more button
        if profile.site.intro.size(withAttributes: [NSAttributedString.Key.font: UIFont.normalFont_12()]).width > introLableMaxWidth {
            self.addSubview(moreBtnNode.view)
            moreBtnNode.view.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-margin)
                make.bottom.equalTo(introLable)
                make.size.equalTo(moreBtnNodeSize)
            }
            moreBtnNode.setAttributdWith(string: R.string.localizable.profile_more(), font: UIFont.normalFont_12(), color: Color.lineColor, state: .normal)
        }
        /// frame
        self.frame = CGRect(x: 0, y: topOffSet, width: macro.screenWidth, height: macro.screenHeight)
    }
    
    private func addEvents() {
        self.moreBtnNode.addTarget(self, action: #selector(moreBtnNodeEvent), forControlEvents: .touchUpInside)
    }
    
    @objc private func moreBtnNodeEvent() {
        if self.introLable.numberOfLines == 0 {
           self.introLable.numberOfLines = 1
           self.layoutIfNeeded()
        } else {
            self.introLable.numberOfLines = 0
            self.layoutIfNeeded()
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
        self.alwaysBounceVertical = false
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
        printLog(scrollView.contentOffset.y)
        printLog(scrollView.contentSize)
        printLog(scrollView.frame)
        printLog(container.frame)
        self.needToChangeBarStyleWith(contentOffSetY: scrollView.contentOffset.y)
    }
}
