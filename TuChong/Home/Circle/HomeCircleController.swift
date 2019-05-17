//  HomeCircleController.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/16.
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

enum HomeCircleType {
    case recommend
    case focus
    
    init(index: Int) {
        if index == 0 {
            self = .recommend
        } else {
            self = .focus
        }
    }
    
    var rawValue: Int {
        switch self {
        case .recommend:
            return 0
        case .focus:
            return 1
        }
    }
}

class HomeCircleController: BaseViewControlle {
    
    lazy var topBar: HomeCircleTopBar = {
        let frame = CGRect(x: 0, y: macro.topHeight, width: macro.screenWidth, height: macro.homenavHeight)
        let topBar = HomeCircleTopBar(frame: frame)
        topBar.delegate = self
        return topBar
    }()
    
    lazy var container: HomeCircleContainer = {
        let y: CGFloat = topBar.frame.maxY
        let frame = CGRect(x: 0, y: y, width: macro.screenWidth, height: macro.screenHeight - y)
        let container = HomeCircleContainer(frame: frame)
        container.containerDelegate = self
        return container
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = R.string.localizable.circle()
        self.addSubviews()
    }
    
    override func addSubviews() {
        self.view.addSubview(topBar)
        self.view.addSubview(container)
    }
}

extension HomeCircleController: HomeCircleContainerProtocol, HomeCircleTopBarProtocol {
    
    func container(view: UIScrollView, selectedIndex: Int) {
        self.topBar.selected(type: HomeCircleType(index: selectedIndex))
    }
    
    func hasSelected(index: Int) {
        self.container.scrollTo(index: index)
    }
}
