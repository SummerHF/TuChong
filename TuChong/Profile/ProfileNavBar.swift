//  ProfileNavBar.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/6.
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
import SnapKit

// MARK: - ProfileNavBarProtocol

@objc protocol ProfileNavBarProtocol: class {
    /// pop event
    @objc optional func navBarBackEvent(bar: ProfileNavBar)
}

// MARK: - ProfileNavBar

class ProfileNavBar: UIView {
    
    weak var delegate: ProfileNavBarProtocol?
    
    private var profile: ProfileModel?
    private var style: ProfileBarStyle = .light
    
    private let backBtnNode: ASButtonNode
    private let actionBtnNode: ASButtonNode
    private let shareBtnNode: ASButtonNode
    private let messageBtnNode: ASButtonNode

    private let profileAvatorImageNode: ASNetworkImageNode
    private let focusBtnNode: ASButtonNode

    private let margin: CGFloat = 20.0
    private let backBtnNodeSize = CGSize(width: 30, height: 30)
    private let btnNodeSize = CGSize(width: 40, height: 40)
    private let actionBtnNodeSize = CGSize(width: 30, height: 40)
    private let profileAvatorImageNodeSize = CGSize(width: 36, height: 36)
    private let focusBtnNodeSize = CGSize(width: 70, height: 28)

    private let backBtnNodeBgColor: UIColor = RGBA(R: 182, G: 182, B: 182, A: 0.2)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.backBtnNode = ASButtonNode()
        self.actionBtnNode = ASButtonNode()
        self.shareBtnNode = ASButtonNode()
        self.messageBtnNode = ASButtonNode()
        self.profileAvatorImageNode = ASNetworkImageNode()
        self.focusBtnNode = ASButtonNode()
        super.init(frame: frame)
        self.setPropertys()
        self.addEvents()
    }
    
    private func setPropertys() {
        backBtnNode.setImage(R.image.profile_back_black(), for: .normal)
        actionBtnNode.setImage(R.image.profile_dot_white(), for: .normal)
        shareBtnNode.setImage(R.image.profile_share_white(), for: .normal)
        messageBtnNode.setImage(R.image.profile_message_white(), for: .normal)
        focusBtnNode.add(cornerRadius: focusBtnNodeSize.height / 2.0, backgroundColor: Color.lineColor, cornerRoundingType: .defaultSlowCALayer)
        focusBtnNode.setAttributdWith(string: R.string.localizable.focus(), font: UIFont.normalFont_12(), color: Color.backGroundColor, state: .normal)
        
        self.addSubview(backBtnNode.view)
        self.addSubview(actionBtnNode.view)
        self.addSubview(shareBtnNode.view)
        self.addSubview(messageBtnNode.view)
        self.addSubview(profileAvatorImageNode.view)
        self.addSubview(focusBtnNode.view)
        
        self.actionBtnNode.view.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-margin)
            make.bottom.equalToSuperview()
            make.size.equalTo(actionBtnNodeSize)
        }
        self.shareBtnNode.view.snp.makeConstraints { (make) in
            make.right.equalTo(actionBtnNode.view.snp.left).offset(-margin * 0.5)
            make.bottom.equalToSuperview()
            make.size.equalTo(btnNodeSize)
        }
        self.messageBtnNode.view.snp.makeConstraints { (make) in
            make.right.equalTo(shareBtnNode.view.snp.left).offset(-margin * 0.5)
            make.bottom.equalToSuperview()
            make.size.equalTo(btnNodeSize)
        }
        
        self.backBtnNode.view.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalTo(actionBtnNode.view)
            make.size.equalTo(backBtnNodeSize)
        }
        
        self.profileAvatorImageNode.view.snp.makeConstraints { (make) in
            make.left.equalTo(self.backBtnNode.view.snp.right)
            make.centerY.equalTo(self.backBtnNode.view)
            make.size.equalTo(profileAvatorImageNodeSize)
        }
        
        self.focusBtnNode.view.snp.makeConstraints { (make) in
            make.left.equalTo(self.profileAvatorImageNode.view.snp.right).offset(margin)
            make.centerY.equalTo(self.backBtnNode.view)
            make.size.equalTo(self.focusBtnNodeSize)
        }
        
        /// hidden
        self.profileAvatorImageNode.isHidden = true
        self.focusBtnNode.isHidden = true
        self.shareBtnNode.isHidden = true
        self.actionBtnNode.isHidden = true
        self.messageBtnNode.isHidden = true
    }
    
    private func addEvents() {
        self.backBtnNode.addTarget(self, action: #selector(backBtnNodeEvent), forControlEvents: .touchUpInside)
    }
    
    @objc private func backBtnNodeEvent() {
        self.delegate?.navBarBackEvent?(bar: self)
    }
    
    func configure(with profile: ProfileModel, barStyle: ProfileBarStyle) {
        self.profile = profile
        /// show
        self.shareBtnNode.isHidden = false
        self.actionBtnNode.isHidden = false
        self.messageBtnNode.isHidden = false
        /// user avator
        self.profileAvatorImageNode.url = URL(string: profile.site.icon)
        self.profileAvatorImageNode.imageModificationBlock = { image in
            image.byRoundCornerRadius(image.size.width / 2.0, borderWidth: 2.4, borderColor: Color.lightGray)
        }
        self.backBtnNode.setImage(R.image.profile_back_white(), for: .normal)
        self.backBtnNode.add(cornerRadius: backBtnNodeSize.width / 2.0, backgroundColor: backBtnNodeBgColor, cornerRoundingType: .defaultSlowCALayer)
        
        self.profileAvatorImageNode.isHidden = true
        self.focusBtnNode.isHidden = true
        
        /// 特殊处理 没有图片的情形
        if profile.coverType == .none {
            self.changeBarStyleToDark(isDark: true)
        }
    }
    
    func configureWith(statusBarStyle: ProfileBarStyle) {
        guard let model = self.profile else { return }
        if model.coverType == .none {
            if statusBarStyle == .dark {
                self.hiddenUserAvatorAndFocusBtn(isHidden: false)
            } else {
                self.hiddenUserAvatorAndFocusBtn(isHidden: true)
            }
        } else {
            if statusBarStyle == .dark {
                self.changeBarStyleToDark(isDark: true)
                self.hiddenUserAvatorAndFocusBtn(isHidden: false)
            } else {
                self.changeBarStyleToDark(isDark: false)
                self.hiddenUserAvatorAndFocusBtn(isHidden: true)
            }
        }
    }
    
    func hiddenUserAvatorAndFocusBtn(isHidden: Bool) {
        self.profileAvatorImageNode.isHidden = isHidden
        self.focusBtnNode.isHidden = isHidden
    }
    
    func changeBarStyleToDark(isDark: Bool) {
        if isDark {
            UIView.animate(withDuration: 0.5) {
                self.backgroundColor = Color.backGroundColor
            }
            self.backBtnNode.backgroundColor = Color.clearColor
            self.backBtnNode.setImage(R.image.profile_back_black(), for: .normal)
            self.actionBtnNode.setImage(R.image.profile_dot_black(), for: .normal)
            self.shareBtnNode.setImage(R.image.profile_share_black(), for: .normal)
            self.messageBtnNode.setImage(R.image.profile_message_black(), for: .normal)
        } else {
            self.backgroundColor = Color.clearColor
            self.backBtnNode.backgroundColor = backBtnNodeBgColor
            self.backBtnNode.setImage(R.image.profile_back_white(), for: .normal)
            self.actionBtnNode.setImage(R.image.profile_dot_white(), for: .normal)
            self.shareBtnNode.setImage(R.image.profile_share_white(), for: .normal)
            self.messageBtnNode.setImage(R.image.profile_message_white(), for: .normal)
        }
    }
}
