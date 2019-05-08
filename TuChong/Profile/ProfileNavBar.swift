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

class ProfileNavBar: UIView {
    
    private var profile: ProfileModel = ProfileModel()
    
    private let backBtnNode: ASButtonNode
    private let actionBtnNode: ASButtonNode
    private let shareBtnNode: ASButtonNode
    private let messageBtnNode: ASButtonNode

    private let margin: CGFloat = 20.0
    private let backBtnNodeSize = CGSize(width: 30, height: 30)
    private let btnNodeSize = CGSize(width: 40, height: 40)
    private let actionBtnNodeSize = CGSize(width: 30, height: 40)
    
    private let backBtnNodeBgColor: UIColor = RGBA(R: 182, G: 182, B: 182, A: 0.2)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.backBtnNode = ASButtonNode()
        self.actionBtnNode = ASButtonNode()
        self.shareBtnNode = ASButtonNode()
        self.messageBtnNode = ASButtonNode()
        super.init(frame: frame)
        self.setPropertys()
    }
    
    private func setPropertys() {
        backBtnNode.setImage(R.image.profile_back_black(), for: .normal)
        actionBtnNode.setImage(R.image.profile_dot_white(), for: .normal)
        shareBtnNode.setImage(R.image.profile_share_white(), for: .normal)
        messageBtnNode.setImage(R.image.profile_message_white(), for: .normal)

        self.addSubview(backBtnNode.view)
        self.addSubview(actionBtnNode.view)
        self.addSubview(shareBtnNode.view)
        self.addSubview(messageBtnNode.view)
        
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
    }
    
    func configure(with profile: ProfileModel) {
        self.profile = profile
        backBtnNode.setImage(R.image.profile_back_white(), for: .normal)
        backBtnNode.add(cornerRadius: backBtnNodeSize.width / 2.0, backgroundColor: backBtnNodeBgColor, cornerRoundingType: .defaultSlowCALayer)
    }
}
