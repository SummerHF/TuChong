//  TutorialDetailWebViewCell.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/23.
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

/// 教程详情 ---- 用户信息
class TutorialDetailWebViewCell: ASCellNode {
    
    private let webView: WebView
    private let webViewHeight: CGFloat
    
    private let insetForWebView = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)

    /// using this container to wrap webView
    lazy var webViewNode: ASDisplayNode = {
        let webViewNode = ASDisplayNode(viewBlock: { [weak self] () -> UIView in
            guard let `self` = self else { return UIView() }
            return self.webView
        })
        return webViewNode
    }()
    
    init(webView: WebView, height: CGFloat) {
        self.webView = webView
        self.webViewHeight = height
        super.init()
        self.automaticallyManagesSubnodes = true
        self.selectionStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        self.webViewNode.style.maxHeight = ASDimension(unit: .points, value: self.webViewHeight)
        return ASInsetLayoutSpec(insets: insetForWebView, child: self.webViewNode)
    }
}
