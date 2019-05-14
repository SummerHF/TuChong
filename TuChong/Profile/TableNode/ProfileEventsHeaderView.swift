//  ProfileEventsHeaderView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/10.
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

class ProfileEventsHeaderView: UIView {
    
    static let headerHeight: CGFloat = 80.0
    static let footerHeight: CGFloat = 0.0001

    private let listItem: Profile_Events_List_Model
    /// size
    private let margin: CGFloat = 8.0
    private let edgue: CGFloat = 15.0

    lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = Color.backGroundColor
        return container
    }()
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        return titleLable
    }()
    
    lazy var subTitleLable: UILabel = {
        let subTitleLable = UILabel()
        return subTitleLable
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = Color.lineGray
        return lineView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(listItem: Profile_Events_List_Model) {
        self.listItem = listItem
        let frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: ProfileEventsHeaderView.headerHeight)
        super.init(frame: frame)
        self.backgroundColor = Color.simpleGray
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(container)
        self.container.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(margin)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        /// add subview to container
        self.container.addSubview(titleLable)
        self.container.addSubview(subTitleLable)
        self.container.addSubview(lineView)
        
        self.titleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(edgue)
            make.right.equalToSuperview().offset(-2 * edgue)
            make.top.equalToSuperview()
        }
        self.subTitleLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(edgue)
            make.top.equalTo(titleLable.snp.bottom).offset(margin)
        }
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(edgue)
            make.right.equalToSuperview().offset(-edgue)
            make.bottom.equalToSuperview().offset(-margin)
            make.height.equalTo(0.5)
        }
        /// set values
        self.titleLable.set(title: listItem.tag_name, font: UIFont.boldFont_16(), color: Color.orangerColor)
        self.subTitleLable.set(title: listItem.posts, font: UIFont.normalFont_13(), color: Color.lightGray)
    }
}
