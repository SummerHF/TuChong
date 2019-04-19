//  WallpaperNavNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/19.
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

@objc protocol WallpaperNavNodeProtocol {
    @objc optional func wllpaperNav(node: WallpaperNavNode, selectedBtn: NavItemButton, with index: Int, and tagID: Int)
}

class WallpaperNavNode: ASDisplayNode {
    
    private var dataArray: [HomePaga_Wallpaper_Data_Model]
    private var buttonArray: [WallpaperNavItemButton] = []
    private var defaultSelectedButton: WallpaperNavItemButton?
    
    weak var delegate: WallpaperNavNodeProtocol?
    
    private let innerInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private let spacing: CGFloat = 20
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    init(data: [HomePaga_Wallpaper_Data_Model], delegate: WallpaperNavNodeProtocol) {
        self.dataArray = data
        self.delegate = delegate
        super.init()
        addNavItems()
    }
    
    private func addNavItems() {
        self.view.addSubview(scrollView)
    }
    
    override func didLoad() {
        self.backgroundColor = Color.backGroundColor
        self.frame = CGRect(x: 0, y: macro.videoNavTop, width: macro.screenWidth, height: macro.videonavHeight)
        self.scrollView.frame = self.bounds
        
        /// add subBtn
        var lastView = UIView()
        for (index, model) in dataArray.enumerated() {
            let button = WallpaperNavItemButton(model: model, index: index)
            button.setTitle(model.tag_name, for: .normal)
            let buttonX: CGFloat = index == 0 ? innerInsets.left : spacing + lastView.frame.maxX
            let buttonY: CGFloat = (self.view.height - button.buttonHeight) / 2.0
            /// set frame
            button.frame = CGRect(x: buttonX, y: buttonY, width: button.buttonWidth, height: button.buttonHeight)
            scrollView.addSubview(button)
            lastView = button
            /// set default state
            button.setDefaultState()
            /// set default selected
            if model.default {
                defaultSelectedButton = button
                /// nofify delegate
                self.delegate?.wllpaperNav?(node: self, selectedBtn: button, with: index, and: model.tag_id)
            }
            /// add button event
            button.addTarget(self, action: #selector(selectedBtnEvent(selectedButton:)), for: .touchUpInside)
        }
        
        /// set contentSize
        self.scrollView.contentSize = CGSize(width: lastView.frame.maxX + innerInsets.right, height: self.view.height)
    }
    
    @objc private func selectedBtnEvent(selectedButton: WallpaperNavItemButton) {
        guard let defaultButton = defaultSelectedButton,  defaultButton != selectedButton else { return }
        defaultButton.selected(isSelected: false)
        selectedButton.selected(isSelected: true)
        defaultSelectedButton = selectedButton
        /// nofify delegate
        self.delegate?.wllpaperNav?(node: self, selectedBtn: selectedButton, with: selectedButton.index, and: selectedButton.itemModel.tag_id)
        /// animate
        self.scrollAnimate(with: selectedButton, scrollView: scrollView, containerView: self.view)
    }
}
