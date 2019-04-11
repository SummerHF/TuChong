//  HomepageViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/20.
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
import AsyncDisplayKit

// MARK: - HomeNavViewDlegatee

@objc protocol HomeNavViewDlegate: class {
    @objc optional func homeNavViewMoreBtnEvent()
}

class HomeNavItemButton: UIButton {
    
    override var isHighlighted: Bool {
        set {
            
        }
        get {
            return false
        }
    }
    
    private var itemModel: HomePageNav_Data_Model
    private var index: Int
    
    init(model: HomePageNav_Data_Model, index: Int) {
        self.itemModel = model
        self.index = index
        super.init(frame: CGRect.zero)
        
        self.setAttributedTitle(NSAttributedString(string: model.name, attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_15(),
            NSAttributedString.Key.foregroundColor: Color.lightGray
            ]), for: .normal)
        
        self.setAttributedTitle(NSAttributedString(string: model.name, attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_20(),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ]), for: .selected)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - HomeNavView

class HomeNavView: ASDisplayNode {
    
    let moreBtnNodeWidth: CGFloat = 40
    let itemWidth: CGFloat = 60
    var dataArray: [HomePageNav_Data_Model]
    var buttonArray: [HomeNavItemButton] = []
    
    weak var delegate: HomeNavViewDlegate?
    
    /// using scrollView
    lazy var scrollView: ScrollView = {
        let view = ScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    /// moreBtnNode
    lazy var moreBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.purple
        node.addTarget(self, action: #selector(moreBtnEvent), forControlEvents: .touchUpInside)
        return node
    }()
    
    init(data: [HomePageNav_Data_Model]) {
        self.dataArray = data
        super.init()
        self.addNavItems()
    }
    
    private func addNavItems() {
        self.view.addSubview(scrollView)
        self.addSubnode(moreBtnNode)
    }
    
    override func didLoad() {
        self.frame = CGRect(x: 0, y: macro.topHeight, width: macro.screenWidth, height: macro.homenavHeight)
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.width - moreBtnNodeWidth, height: self.view.height)
        self.moreBtnNode.frame = CGRect(x: self.view.width - moreBtnNodeWidth, y: 0, width: moreBtnNodeWidth, height: self.view.height)
        
        /// add subButton
        var lastView: UIView = self.scrollView
        for (index, model) in dataArray.enumerated() {
            let button = HomeNavItemButton(model: model, index: index)
            buttonArray.append(button)
            
            /// default selected,
            if model.default {
                button.isSelected = true 
            }
            
            /// add button to scrollView
            self.scrollView.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                if index == 0 {
                    make.left.equalTo(lastView)
                } else {
                    make.left.equalTo(lastView.snp.right)
                }
                make.size.equalTo(CGSize(width: itemWidth, height: self.view.height))
            }
            lastView = button
        }
        /// set content offset
        self.scrollView.contentSize = CGSize(width: CGFloat(dataArray.count) * itemWidth, height: self.view.height)
    }
    
    @objc func moreBtnEvent() {
        self.delegate?.homeNavViewMoreBtnEvent?()
    }
}
