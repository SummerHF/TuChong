//
//  VideoNavNode.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/4/18.
//  Copyright © 2019 Summer. All rights reserved.
//

import AsyncDisplayKit

@objc protocol VideoNavNodeProtocol {
    @objc optional func homeNav(node: HomeNavNode, selectedBtn: HomeNavItemButton, with index: Int)
    @objc optional func homeNavNodeMoreBtnEvent(node: HomeNavNode)
}

class VideoNavNode: ASDisplayNode {
    
    private var dataArray: [HomePageNav_Data_Model]
    private var buttonArray: [HomeNavItemButton] = []
    private var defaultSelectedButton: HomeNavItemButton?
    
    weak var delegate: VideoNavNodeProtocol?
    
    private let innerInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    private let spacing: CGFloat = 20
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    init(data: [HomePageNav_Data_Model], delegate: VideoNavNodeProtocol) {
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
            let button = HomeNavItemButton(model: model, index: index)
            button.setTitle(model.name, for: .normal)
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
            }
            /// add button event
            button.addTarget(self, action: #selector(selectedBtnEvent(selectedButton:)), for: .touchUpInside)
        }
        
        /// set contentSize
        self.scrollView.contentSize = CGSize(width: lastView.frame.maxX + innerInsets.right, height: self.view.height)
    }
    
    @objc private func selectedBtnEvent(selectedButton: HomeNavItemButton) {
        guard let defaultButton = defaultSelectedButton,  defaultButton != selectedButton else { return }
        defaultButton.selected(isSelected: false)
        selectedButton.selected(isSelected: true)
        defaultSelectedButton = selectedButton
        self.scrollAnimate(with: selectedButton, scrollView: scrollView, containerView: self.view)
    }
}
