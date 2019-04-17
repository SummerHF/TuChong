//  FollowViewUserLoginView.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/17.
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

/// This Login View is contained in `FollowViewController`

class FollowViewUserLoginNode: ASDisplayNode {
    
    private let logImageNode: ASImageNode
    private let textNode: ASTextNode
    private let loginBtn: ASButtonNode
    private let registerBtn: ASButtonNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        self.logImageNode = ASImageNode()
        self.textNode = ASTextNode()
        self.loginBtn = ASButtonNode()
        self.registerBtn = ASButtonNode()
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        self.addSubnode(logImageNode)
        self.addSubnode(textNode)
        self.addSubnode(loginBtn)
        self.addSubnode(registerBtn)
        
        self.layouts()
        self.configure()
    }
    
    private func layouts() {
        logImageNode.view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(R.image.login_logo()!.size)
        }
        textNode.view.snp.makeConstraints { (make) in
            make.top.equalTo(logImageNode.view.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 28))
        }
        loginBtn.view.snp.makeConstraints { (make) in
            make.top.equalTo(textNode.view.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 32))
        }
        registerBtn.view.snp.makeConstraints { (make) in
            make.top.equalTo(loginBtn.view.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.size.equalTo(loginBtn.view)
        }
    }
    
    private func configure() {
        self.logImageNode.image = R.image.login_logo()
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        self.textNode.attributedText = NSAttributedString(string: R.string.localizable.login_prompt(), attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_12(),
            NSAttributedString.Key.foregroundColor: Color.lightGray,
            NSAttributedString.Key.paragraphStyle: style
            ])
        self.loginBtn.setAttributedTitle(NSAttributedString(string: R.string.localizable.login(), attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_13(),
            NSAttributedString.Key.foregroundColor: Color.orangerColor
            ]), for: .normal)
        self.registerBtn.setAttributedTitle(NSAttributedString(string: R.string.localizable.register(), attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_13(),
            NSAttributedString.Key.foregroundColor: UIColor.white
            ]), for: .normal)
        self.registerBtn.backgroundColor = Color.lineColor
        self.loginBtn.set(cornerRadius: 16, borderWidth: 1.0, borderColor: Color.orangerColor)
        self.registerBtn.set(cornerRadius: 16)
    }
}
