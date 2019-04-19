//  HomeNavNode.swift
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

@objc protocol HomeNavNodeDlegate {
    @objc optional func homeNav(node: HomeNavNode, selectedBtn: HomeNavItemButton, with index: Int)
    @objc optional func homeNavNodeMoreBtnEvent(node: HomeNavNode)
}
// MARK: - HomeNavNode

class HomeNavNode: ASDisplayNode {
    
    private let moreBtnNodeWidth: CGFloat = 40
    private let itemWidth: CGFloat = 64
    private var dataArray: [HomePageNav_Data_Model]
    private var buttonArray: [HomeNavItemButton] = []
    private var defaultSelectedButton: HomeNavItemButton?
    private let indicatorSize = CGSize(width: 14, height: 4)
    private let indicatorBottom: CGFloat = -2

    weak var delegate: HomeNavNodeDlegate?
    
    /// using scrollView
    lazy var scrollView: ScrollView = {
        let view = ScrollView()
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    /// moreBtnNode
    lazy var moreBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.addTarget(self, action: #selector(moreBtnEvent), forControlEvents: .touchUpInside)
        node.setImage(R.image.right_arrow(), for: .normal)
        node.backgroundColor = Color.flatWhite
        return node
    }()
    
    /// bottom indicator
    lazy var indicator: UIView = {
        let view =  UIView()
        view.backgroundColor = Color.lineColor
        return view
    }()
    
    init(data: [HomePageNav_Data_Model], delegate: HomeNavNodeDlegate) {
        self.dataArray = data
        self.delegate = delegate
        super.init()
        self.addNavItems()
    }
    
    private func addNavItems() {
        self.view.addSubview(scrollView)
        self.addSubnode(moreBtnNode)
    }
    
    override func didLoad() {
        self.frame = CGRect(x: 0, y: macro.topHeight, width: macro.screenWidth, height: macro.homenavHeight)
        self.scrollView.frame = self.bounds
        self.moreBtnNode.frame = CGRect(x: self.view.width - moreBtnNodeWidth, y: 0, width: moreBtnNodeWidth, height: self.view.height)
        /// add subButton
        var lastView: UIView = self.scrollView
        for (index, model) in dataArray.enumerated() {
            let button = HomeNavItemButton(model: model, index: index)
            button.setAttributdWith(string: model.name, font: UIFont.normalFont_15(), color: Color.lightGray, state: .normal)
            button.setAttributdWith(string: model.name, font: UIFont.normalFont_20(), color: Color.black, state: .selected)
            buttonArray.append(button)
            /// add button event
            button.addTarget(self, action: #selector(selectedBtnEvent(selectedButton:)), for: .touchUpInside)
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
            /// default selected,
            if model.default {
                button.isSelected = true
                defaultSelectedButton = button
                self.delegate?.homeNav?(node: self, selectedBtn: button, with: index)
                
                /// add bottom indicator
                self.scrollView.addSubview(indicator)
                indicator.snp.makeConstraints { (make) in
                    make.bottom.equalTo(button).offset(indicatorBottom)
                    make.centerX.equalTo(button)
                    make.size.equalTo(indicatorSize)
                }
            }
            lastView = button
        }
        /// set content size
        let totalWidth: CGFloat = itemWidth * CGFloat(dataArray.count)
        if lastView != self.scrollView && totalWidth <= self.view.width - moreBtnNodeWidth {
            /// don't need to add unnecessary offset
            self.scrollView.contentSize = CGSize(width: totalWidth, height: self.view.height)
        } else {
            self.scrollView.contentSize = CGSize(width: totalWidth + moreBtnNodeWidth, height: self.view.height)
        }
    }
    
    /// more tag event
    @objc private func moreBtnEvent() {
        self.delegate?.homeNavNodeMoreBtnEvent?(node: self)
    }
    
    @objc private func selectedBtnEvent(selectedButton: HomeNavItemButton) {
        guard let button = defaultSelectedButton , selectedButton != button else { return }
        button.isSelected = false
        selectedButton.isSelected = true
        defaultSelectedButton = selectedButton
        /// selected event
        self.delegate?.homeNav?(node: self, selectedBtn: selectedButton, with: selectedButton.index)
        /// animate
        scrollAnimate(with: selectedButton)
        /// update indicator
        indicator.snp.remakeConstraints { (make) in
            make.size.equalTo(indicatorSize)
            make.centerX.equalTo(selectedButton)
            make.bottom.equalTo(selectedButton).offset(indicatorBottom)
        }
    }
    
    /// set animate for button
    private func scrollAnimate(with selectedBtn: HomeNavItemButton) {
        guard self.scrollView.contentSize.width > self.view.width - moreBtnNodeWidth else { return }
        let contentWidth = self.scrollView.contentSize.width
        let offsetX = (self.view.width - selectedBtn.width) / 2.0
        if selectedBtn.left <= self.view.width / 2.0 {
            /// don't need
            self.scrollView.setContentOffset(CGPoint.zero, animated: false)
        } else if selectedBtn.frame.maxX > contentWidth - self.view.width / 2.0 {
            let x = contentWidth - self.view.width
            self.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        } else {
            let x = selectedBtn.frame.minX - offsetX
            self.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
    }
    
    open func hasSelected(index: Int) {
        selectedBtnEvent(selectedButton: buttonArray[index])
    }
}
