//  HomeCircleTopBar.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/17.
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
import SnapKit

class HomeCircleTopBar: UIView {
    
    private let margin: CGFloat = 20
    private let indicatorSize = CGSize(width: 8, height: 3)
    private var centerXConstraint: Constraint?
    
    private var previousSelectedBtn: NavItemButton?
    
    private lazy var recommendNavItem: NavItemButton = {
        let recommendNavItem = NavItemButton(type: .custom)
        recommendNavItem.set(title: R.string.localizable.circle_recommend(), font: UIFont.normalFont_14(), color: Color.black, state: .normal)
        recommendNavItem.addTarget(self, action: #selector(btnEvent(button:)), for: .touchUpInside)
        recommendNavItem.tag = HomeCircleType.recommend.rawValue
        return recommendNavItem
    }()
    
    private lazy var focusNavItem: NavItemButton = {
        let focusNavItem = NavItemButton(type: .custom)
        focusNavItem.set(title: R.string.localizable.attention(), font: UIFont.normalFont_14(), color: Color.black, state: .normal)
        focusNavItem.addTarget(self, action: #selector(btnEvent(button:)), for: .touchUpInside)
        focusNavItem.tag = HomeCircleType.focus.rawValue
        return focusNavItem
    }()
    
    private lazy var bottomLine: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = Color.lineGray
        return bottomLine
    }()
    
    private lazy var indicator: UIView = {
        let indicator = UIView()
        indicator.backgroundColor = Color.lineColor
        indicator.layer.cornerRadius = 1.5
        indicator.clipsToBounds = true 
        return indicator
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setPropertys()
        /// set default selected
        self.btnEvent(button: recommendNavItem)
    }

    private func setPropertys() {
        self.addSubview(recommendNavItem)
        self.addSubview(focusNavItem)
        self.addSubview(bottomLine)
        self.addSubview(indicator)
        
        self.recommendNavItem.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(self.snp.centerX).offset(-margin)
            make.size.equalTo(CGSize(width: recommendNavItem.itemWidth, height: self.height))
        }
        
        self.focusNavItem.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.centerX).offset(margin)
            make.size.equalTo(CGSize(width: focusNavItem.itemWidth, height: self.height))
        }
        
        self.bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    @objc private func btnEvent(button: NavItemButton) {
        if let previousBtn = self.previousSelectedBtn {
            guard button != previousBtn else { return }
            previousBtn.setSelected = false
            button.setSelected = true
            previousSelectedBtn = button
            self.centerXConstraint?.deactivate()
            self.indicator.snp.makeConstraints { (make) in
                self.centerXConstraint = make.centerX.equalTo(button).constraint
            }
            self.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            button.setSelected = true
            previousSelectedBtn = button
            self.indicator.snp.makeConstraints { (make) in
                make.bottom.equalTo(bottomLine.snp.top)
                self.centerXConstraint = make.centerX.equalTo(button).constraint
                make.size.equalTo(indicatorSize)
            }
        }
    }
}
