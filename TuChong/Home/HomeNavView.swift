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

class HomeNavView: ASDisplayNode {
    
    let buttonWidth: CGFloat = 40
    var dataArray: [HomePageNav_Data_Model] = []
    weak var delegate: HomeNavViewDlegate?
    
    /// scrollNode
    lazy var scrollNode: ASScrollNode = {
        let node = ASScrollNode()
        return node
    }()
    
    /// moreBtnNode
    lazy var moreBtnNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.purple
        node.addTarget(self, action: #selector(moreBtnEvent), forControlEvents: .touchUpInside)
        return node
    }()
    
    init(data: [HomePageNav_Data_Model]) {
        super.init()
        self.backgroundColor = UIColor.yellow
        self.dataArray = data
        self.addNavItems()
    }
    
    private func addNavItems() {
        self.addSubnode(scrollNode)
        self.addSubnode(moreBtnNode)
    }
    
    override func didLoad() {
        self.frame = CGRect(x: 0, y: macro.topHeight, width: macro.screenWidth, height: macro.homenavHeight)
        self.scrollNode.frame = CGRect(x: 0, y: 0, width: self.view.width - buttonWidth, height: self.view.height)
        self.moreBtnNode.frame = CGRect(x: self.view.width - buttonWidth, y: 0, width: buttonWidth, height: self.view.height)
    }
    
    @objc func moreBtnEvent() {
        self.delegate?.homeNavViewMoreBtnEvent?()
    }
}
