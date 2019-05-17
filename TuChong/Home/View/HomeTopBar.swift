//  HomeTopBar.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/16.
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

import Foundation
import AsyncDisplayKit

class HomeTopBar: UIView {
    
    private let margin: CGFloat = 10
    private let sellBtnNodeWidth: CGFloat = 44
    
    /// 供稿页
    private let feedsViewController = FeedsViewController()
    
    /// 输入框
    lazy var textField: BaseTextField = {
        let textField = BaseTextField()
        textField.isEnabled = false
        let leftImageView = UIImageView(image: R.image.search_topic())
        leftImageView.contentMode = .center
        leftImageView.size = CGSize(width: 28, height: 28)
        textField.leftView = leftImageView
        textField.leftViewMode = .always
        textField.background = R.image.searchBar_background()
        return textField
    }()
    
    /// 出售照片
    lazy var sellBtnNode: ASButtonNode = {
        let sellBtnNode = ASButtonNode()
        sellBtnNode.setImage(R.image.sale_photo(), for: .normal)
        sellBtnNode.addTarget(self, action: #selector(sellBtnNodeEvent), forControlEvents: .touchUpInside)
        return sellBtnNode
    }()
    
    lazy var searchBtn: UIButton = {
        let searchBtn = UIButton(type: .custom)
        searchBtn.set(title: R.string.localizable.search_bar_placeholder(), font: UIFont.normalFont_13())
        searchBtn.setTitleColor(Color.highlightedGray, for: UIControl.State.highlighted)
        searchBtn.setTitleColor(Color.lightGray, for: .normal)
        searchBtn.addTarget(self, action: #selector(searchBtnEvent), for: .touchUpInside)
        return searchBtn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.backGroundColor
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(sellBtnNode.view)
        self.addSubview(textField)
        self.addSubview(searchBtn)
        
        sellBtnNode.view.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(sellBtnNodeWidth)
        }
        textField.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(sellBtnNode.view.snp.left).offset(-margin)
        }
        searchBtn.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(textField)
            make.left.equalTo(textField).offset(margin * 2.5)
            make.right.equalTo(textField).offset(-margin * 0.5)
        }
    }
    
    /// 跳转到搜索页
    @objc private func searchBtnEvent() {
        printLog("tapBtnNodeEvent")
    }
    
    /// 跳转到供稿页
    @objc private func sellBtnNodeEvent() {
        macro.currentSelectedNavgationController?.pushViewController(feedsViewController, animated: true)
    }
}
