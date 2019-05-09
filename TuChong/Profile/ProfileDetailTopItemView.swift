//  ProfileDetailTopItemView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/9.
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

// MARK: - ProfileDetailTopItemViewProtocol

protocol ProfileDetailTopItemViewProtocol: NSObjectProtocol {
    func hasSelected(view:ProfileDetailTopItemView, type: ProfileDetailType)
}

// MARK: - ProfileDetailTopItemView

/// using this class to show count of category
class ProfileDetailTopItemView: UIView {
    
    weak var delegate: ProfileDetailTopItemViewProtocol?
    
    var type: ProfileDetailType = .none
    
    private let lableHeight: CGFloat = 24
    private let countLable = UILabel()
    private let categoryNameLable = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                self.countLable.font = UIFont.boldFont_15()
                self.categoryNameLable.font = UIFont.normalFont_16()
            } else {
                self.countLable.font = UIFont.boldFont_14()
                self.categoryNameLable.font = UIFont.normalFont_15()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(countLable)
        self.addSubview(categoryNameLable)
        self.countLable.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
            make.height.equalTo(lableHeight)
        }
        self.categoryNameLable.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.snp.centerY)
            make.height.equalTo(lableHeight)
        }
    }
    
    func configureWith(title: String, count: Int, type: ProfileDetailType, delegate: ProfileDetailTopItemViewProtocol) {
        self.type = type
        self.delegate = delegate
        self.countLable.set(title: "\(count)", font: UIFont.boldFont_14(), color: Color.black, aligment: .center)
        self.categoryNameLable.set(title: title, font: UIFont.boldFont_15(), color: Color.black, aligment: .center)
        /// add tap event
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapEvent)))
    }
    
    @objc private func tapEvent() {
        self.delegate?.hasSelected(view: self, type: self.type)
    }
}
