//  TutorialDetailHeadView.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/26.
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

// MARK: - TutorialDetailHeadViewDelegate

@objc protocol TutorialDetailHeadViewProtocol: class {
    @objc optional func headView(view: TutorialDetailHeadView, selected type: Int)
}

class TutorialDetailHeadView: UIView {
    
    weak var delegate: TutorialDetailHeadViewProtocol?
    
    lazy var commentCountLable: UILabel = {
        let commentCountLable = UILabel()
        return commentCountLable
    }()
    
    lazy var newestBtn: UIButton = {
        let newestBtn = UIButton(type: .custom)
        newestBtn.set(title: R.string.localizable.newest(), font: UIFont.normalFont_13())
        newestBtn.setTitleColor(Color.orangerColor, for: .selected)
        newestBtn.setTitleColor(Color.lightGray, for: .normal)
        newestBtn.tag = RequestparameterKey.newest
        return newestBtn
    }()
    
    lazy var middleLine: UIView = {
        let middleLine = UIView()
        middleLine.backgroundColor = Color.lineGray
        return middleLine
    }()
    
    lazy var hotestBtn: UIButton = {
        let hotestBtn = UIButton(type: .custom)
        hotestBtn.set(title: R.string.localizable.hotest(), font: UIFont.normalFont_13())
        hotestBtn.setTitleColor(Color.orangerColor, for: .selected)
        hotestBtn.setTitleColor(Color.lightGray, for: .normal)
        hotestBtn.tag = RequestparameterKey.hotest
        return hotestBtn
    }()
    
    private var defaultSelectedBtn = UIButton()
    private let margin: CGFloat = 20
    private let littleMargin: CGFloat = -3.0
    private let btnWidth: CGFloat = 50

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: TutorialGroup.headerHeight)
        super.init(frame: frame)
        self.backgroundColor = Color.backGroundColor
        self.addSubItems()
    }
    
    private func addSubItems() {
        self.addSubview(commentCountLable)
        self.addSubview(newestBtn)
        self.addSubview(hotestBtn)
        self.addSubview(middleLine)
        
        self.commentCountLable.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(margin)
        }
        
        self.newestBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-margin)
            make.width.equalTo(btnWidth)
        }
        
        self.middleLine.snp.makeConstraints { (make) in
            make.right.equalTo(newestBtn.snp.left).offset(littleMargin)
            make.centerY.equalToSuperview()
            make.height.equalTo(newestBtn).multipliedBy(0.15)
            make.width.equalTo(1)
        }
        
        self.hotestBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(middleLine.snp.left).offset(littleMargin)
            make.width.equalTo(btnWidth)
        }
        
        self.hotestBtn.addTarget(self, action: #selector(btnEvent(btn:)), for: .touchUpInside)
        self.newestBtn.addTarget(self, action: #selector(btnEvent(btn:)), for: .touchUpInside)
    }
    
    func configure(with commentCount: Int, commentType: Int) {
        self.commentCountLable.setAttributdWith(string: "全部\(commentCount)条评论", font: UIFont.normalFont_13(), color: Color.lightGray)
        if commentType == RequestparameterKey.hotest {
            hotestBtn.isSelected = true
            newestBtn.isSelected = false
            defaultSelectedBtn = hotestBtn
        } else {
            hotestBtn.isSelected = false
            newestBtn.isSelected = true
            defaultSelectedBtn = newestBtn
        }
    }
    
    @objc private func btnEvent(btn: UIButton) {
        guard btn != defaultSelectedBtn else { return }
        btn.isSelected = true
        defaultSelectedBtn.isSelected = false
        defaultSelectedBtn = btn
        self.delegate?.headView?(view: self, selected: btn.tag)
    }
}
