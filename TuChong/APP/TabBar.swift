//  TabBar.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/9.
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
import DeviceKit

enum BarItemType {
    /// 首页
    case home
    /// 照片电影
    case photoFilm
    /// 中间按钮
    case plus
    /// 活动
    case activity
    /// 我的
    case profile
}

// MARK: - BarItemModel

class BarItemModel: NSObject {
    var title: String
    var defaultImage: UIImage?
    var selectedImage: UIImage?
    /// use this image when selected photoFilm
    var whiteImage: UIImage?
    var type: BarItemType
    var index: Int
    
    /// default index is Four, for center plus button
    init(title: String = "", defaultImage: UIImage? = nil, selectedImage: UIImage? = nil, whiteImage: UIImage? = nil, type: BarItemType, index: Int = 4) {
        self.title = title
        self.defaultImage = defaultImage
        self.selectedImage = selectedImage
        self.whiteImage = whiteImage
        self.type = type
        self.index = index
        super.init()
    }
    
    /// Create items array
    static func buildModels() -> [BarItemModel] {
        let homeItemModel = BarItemModel(title: R.string.localizable.home(), defaultImage: R.image.home(), selectedImage: R.image.home_selected(), whiteImage: R.image.home_white(), type: .home, index: 0)
        let photoFilmItemModel = BarItemModel(title: R.string.localizable.film(), defaultImage: R.image.film_play(), selectedImage: R.image.film_play_selected(), type: .photoFilm, index: 1)
        let centerItemModel = BarItemModel(defaultImage: R.image.plus(), whiteImage: R.image.plus_white(), type: .plus)
        let activityItemModel = BarItemModel(title: R.string.localizable.avtivity(), defaultImage: R.image.activity(), selectedImage: R.image.activity_selcted(), type: .activity, index: 2)
        let userItemModel = BarItemModel(title: R.string.localizable.user(), defaultImage: R.image.user_profile(), selectedImage: R.image.use_profile_selected(), type: .profile, index: 3)
        return [homeItemModel, photoFilmItemModel, centerItemModel, activityItemModel, userItemModel]
    }
}

// MARK: - BarItemButton

class BarItemButton: ASButtonNode {
    
    let itemModel: BarItemModel
    let spacing: CGFloat = 10.0
    
    /// Disable highlited state
    override var isHighlighted: Bool {
        set {
          
        }
        get {
            return false
        }
    }
    
    init(itemModel: BarItemModel) {
        self.itemModel = itemModel
        super.init()
    }
    
    override func didLoad() {
        super.didLoad()
        
        self.laysOutHorizontally = false
        self.setImage(itemModel.defaultImage, for: .normal)

        if itemModel.type != .plus {
            self.setImage(itemModel.selectedImage, for: .selected)
            self.setAttributedTitle(NSAttributedString(string: itemModel.title, attributes: [NSAttributedString.Key.font: UIFont.normalFont_10(),
                                                                                             NSAttributedString.Key.foregroundColor: UIColor.black
                ]), for: .normal)
        }
        self.contentSpacing = spacing
    }
    
    /// Create ASButton array
    static func buildNodes() -> [BarItemButton] {
        var nodeArray: [BarItemButton] = []
        let arrays = BarItemModel.buildModels()
        for item in arrays {
            let node = BarItemButton(itemModel: item)
            nodeArray.append(node)
        }
        return nodeArray
    }
}

// MARK: - TabBarNode

@objc protocol TabBarNodeProtocol {
    @objc optional func tabbarNode(node: TabBarNode, hasSelcted Index: Int)
    @objc optional func tabbarNodePresentAlbumViewController(node: TabBarNode)
}

class TabBarNode: ASDisplayNode {
    
    private var defaultIndex: Int = 0
    
    lazy var nodeArray: [BarItemButton] = {
        return BarItemButton.buildNodes()
    }()
    
    weak var delegate: TabBarNodeProtocol?
    
    /// default selected
    private var defaultSelectedItemNode: BarItemButton?
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        for i in 0..<nodeArray.count {
            if defaultIndex == i {
                defaultSelectedItemNode = nodeArray[i]
                defaultSelectedItemNode?.isSelected = true
            }
            nodeArray[i].addTarget(self, action: #selector(barItemEvent(button:)), forControlEvents: .touchUpInside)
        }
    }
    
    @objc private func barItemEvent(button: BarItemButton) {
        guard let node = defaultSelectedItemNode , node != button else { return }
        /// when selected center plust, ignore animate
        if button.itemModel.type == .plus {
            self.delegate?.tabbarNodePresentAlbumViewController?(node: self)
        } else {
            animateWith(currentNode: node, selectedNode: button)
            self.delegate?.tabbarNode?(node: self, hasSelcted: button.itemModel.index)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = macro.screenWidth / CGFloat(nodeArray.count)
        let height = macro.tabBarHeight
        _ = nodeArray.map { $0.style.preferredSize = CGSize(width: width, height: height) }
        return ASStackLayoutSpec(direction: .horizontal, spacing: 0.0, justifyContent: .center, alignItems: .stretch, children: nodeArray)
    }
    
    /// set button node animate for selected event
    private func animateWith(currentNode: BarItemButton, selectedNode: BarItemButton) {
        
        if selectedNode.itemModel.type == .photoFilm {
            /// selected
            resetButtonNodeAttributes(isSelectedPhotoFilm: true)
        } else if currentNode.itemModel.type == .photoFilm {
            /// cancel selected
            resetButtonNodeAttributes(isSelectedPhotoFilm: false)
        }
        currentNode.isSelected = false
        selectedNode.isSelected = true
        defaultSelectedItemNode = selectedNode
    }
    
    private func resetButtonNodeAttributes(isSelectedPhotoFilm: Bool) {
        /// change tabbar backgroundcolor
        self.backgroundColor = isSelectedPhotoFilm ? UIColor.black : UIColor.clear
        /// change title color
        for value in nodeArray {
            value.setAttributedTitle(NSAttributedString(string: value.itemModel.title, attributes: [
                NSAttributedString.Key.font: UIFont.normalFont_10(),
                NSAttributedString.Key.foregroundColor: (isSelectedPhotoFilm ? UIColor.white : UIColor.black)
                ]), for: .normal)
            value.setImage(isSelectedPhotoFilm ? value.itemModel.whiteImage : value.itemModel.defaultImage, for: .normal)
        }
    }
}

// MARK: - TabBar

@objc protocol TabBarProtocol {
    @objc optional func tabbar(tabBar: UITabBar, hasSelcted Index: Int)
    @objc optional func tabbarPresentAlbumViewController(tabBar: UITabBar)
}

class TabBar: UITabBar {
    
    lazy var tabBarNode: TabBarNode = {
        let view = TabBarNode()
        view.delegate = self
        return view
    }()
    
    weak var agency: TabBarProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubnode(tabBarNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        /// Set frame to zero
        for item in subviews {
            if let objc = NSClassFromString("UITabBarButton"), item.isKind(of: objc) {
                item.frame = CGRect.zero
            }
        }
        tabBarNode.frame = self.bounds
        self.bringSubviewToFront(tabBarNode.view)
    }
}

extension TabBar: TabBarNodeProtocol {
    
    func tabbarNode(node: TabBarNode, hasSelcted Index: Int) {
        self.agency?.tabbar?(tabBar: self, hasSelcted: Index)
    }
    
    func tabbarNodePresentAlbumViewController(node: TabBarNode) {
        self.agency?.tabbarPresentAlbumViewController?(tabBar: self)
    }
}
