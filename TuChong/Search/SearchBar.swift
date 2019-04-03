//  SearchBar.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/3.
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

class BaseTextField: UITextField {}

class SearchBar: UIView {
    
    private let buttonWidth: CGFloat = 60
    private let offset: CGFloat = 100

    /// 取消
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setAttributedTitle(NSAttributedString(string: R.string.localizable.cancel_button_title(), attributes: [NSAttributedString.Key.font: UIFont.normalFont_16(),
                                                                                                                      NSAttributedString.Key.foregroundColor: UIColor.black
                                                                                                                      ]), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonEvent), for: .touchUpInside)
        return button
    }()
    
    /// 输入框
    lazy var textField: BaseTextField = {
        let textField = BaseTextField()
        textField.tintColor = UIColor.black
        textField.attributedPlaceholder = NSAttributedString(string: R.string.localizable.search_bar_placeholder(), attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_13(),
            NSAttributedString.Key.foregroundColor: Color.lightGray
            ])
        textField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                           NSAttributedString.Key.font: UIFont.normalFont_13()
        ]
        let leftImageView = UIImageView(image: R.image.search_topic())
        leftImageView.contentMode = .center
        leftImageView.size = CGSize(width: 28, height: 28)
        textField.leftView = leftImageView
        textField.leftViewMode = .always
        textField.background = R.image.searchBar_background()
        return textField
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textField.delegate = self
        addSubview(textField)
        addSubview(cancelButton)
        
        textField.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right).offset(offset)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: buttonWidth, height: macro.searchBarSize.height))
        }
    }
}

// MARK: - UITextFieldDelegate

extension SearchBar: UITextFieldDelegate {
    
    /// begin editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        remakeConstraints()
    }
    
    /// remakeConstraints and add cancel button
    private func remakeConstraints() {
        textField.snp.remakeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: self.width - buttonWidth, height: self.height))
        }
        cancelButton.snp.remakeConstraints { (make) in
            make.left.equalTo(textField.snp.right)
            make.centerY.equalToSuperview()
            make.size.equalTo(cancelButton.size)
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func cancelButtonEvent() {
        textField.resignFirstResponder()
        cancelButton.snp.remakeConstraints { (make) in
            make.left.equalTo(self.snp.right).offset(offset)
            make.centerY.equalToSuperview()
            make.size.equalTo(cancelButton.size)
        }
        textField.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
}
