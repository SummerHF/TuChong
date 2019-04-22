//  NavItemButtonNode.swift
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

import UIKit
import Foundation

// MARK: - NavItemButton `Base`

class NavItemButton: UIButton {
    
    override var isHighlighted: Bool {
        set {
            
        }
        get {
            return false
        }
    }
}

// MARK: - HomeNavItemButton

/// for `VideoNavNode`
class HomeNavItemButton: NavItemButton {
    
    var itemModel: HomePageNav_Data_Model
    var index: Int
    
    let buttonFont: UIFont = UIFont.normalFont_13()
    let selectedFont: UIFont = UIFont.normalFont_15()
    let buttonHeight: CGFloat = 24
    var buttonWidth: CGFloat {
        /// fast caculate `string` size
        return itemModel.name.size(withAttributes: [NSAttributedString.Key.font: buttonFont]).width + floatWidth
    }
    private let floatWidth: CGFloat = 28
    
    init(model: HomePageNav_Data_Model, index: Int) {
        self.itemModel = model
        self.index = index
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Whether selected or deselected
    open func setDefaultState() {
        self.titleLabel?.font = buttonFont
        selected(isSelected: itemModel.default)
    }
    
    open func selected(isSelected: Bool) {
        if isSelected {
            self.isSelected = true
            self.titleLabel?.font = selectedFont
            self.setTitleColor(Color.black, for: .selected)
            self.set(cornerRadius: 0.0, borderWidth: 0.0, borderColor: UIColor.clear)
        } else {
            self.isSelected = false
            self.titleLabel?.font = buttonFont
            self.setTitleColor(Color.lightGray, for: .normal)
            self.set(cornerRadius: buttonHeight / 2.0, borderWidth: 1.2, borderColor: Color.flatGray)
        }
    }
}

// MARK: - WallpaperNavItemButton

/// for `WallpaperNavNode`
class WallpaperNavItemButton: NavItemButton {
    
    var itemModel: HomePaga_Wallpaper_Data_Model
    var index: Int
    
    let buttonFont: UIFont = UIFont.normalFont_13()
    let selectedFont: UIFont = UIFont.normalFont_15()
    let buttonHeight: CGFloat = 24
    var buttonWidth: CGFloat {
        /// fast caculate `string` size
        return itemModel.tag_name.size(withAttributes: [NSAttributedString.Key.font: buttonFont]).width + floatWidth
    }
    private let floatWidth: CGFloat = 28
    
    init(model: HomePaga_Wallpaper_Data_Model, index: Int) {
        self.itemModel = model
        self.index = index
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Whether selected or deselected
    open func setDefaultState() {
        self.titleLabel?.font = buttonFont
        selected(isSelected: itemModel.default)
    }
    
    open func selected(isSelected: Bool) {
        if isSelected {
            self.isSelected = true
            self.titleLabel?.font = selectedFont
            self.setTitleColor(Color.black, for: .selected)
            self.set(cornerRadius: 0.0, borderWidth: 0.0, borderColor: UIColor.clear)
        } else {
            self.isSelected = false
            self.titleLabel?.font = buttonFont
            self.setTitleColor(Color.lightGray, for: .normal)
            self.set(cornerRadius: buttonHeight / 2.0, borderWidth: 1.0, borderColor: Color.flatGray)
        }
    }
}

// MARK: - TutorialNavItemButton

/// for `TutorialNavNode`
class TutorialNavItemButton: NavItemButton {
    
    var itemModel: Tutorial_Data_Model
    var index: Int
    
    let buttonFont: UIFont = UIFont.normalFont_13()
    let selectedFont: UIFont = UIFont.normalFont_15()
    let buttonHeight: CGFloat = 24
    var buttonWidth: CGFloat {
        /// fast caculate `string` size
        return itemModel.tutorial_name.size(withAttributes: [NSAttributedString.Key.font: buttonFont]).width + floatWidth
    }
    private let floatWidth: CGFloat = 28
    
    init(model: Tutorial_Data_Model, index: Int) {
        self.itemModel = model
        self.index = index
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Whether selected or deselected
    open func setDefaultState() {
        self.titleLabel?.font = buttonFont
        selected(isSelected: itemModel.default)
    }
    
    open func selected(isSelected: Bool) {
        if isSelected {
            self.isSelected = true
            self.titleLabel?.font = selectedFont
            self.setTitleColor(Color.black, for: .selected)
            self.set(cornerRadius: 0.0, borderWidth: 0.0, borderColor: UIColor.clear)
        } else {
            self.isSelected = false
            self.titleLabel?.font = buttonFont
            self.setTitleColor(Color.lightGray, for: .normal)
            self.set(cornerRadius: buttonHeight / 2.0, borderWidth: 1.0, borderColor: Color.flatGray)
        }
    }
}
