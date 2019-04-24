//  WebView.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/24.
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
import WebKit

// MARK: - WebView

/// Using this `WebView` to load webpage, global use

enum WebViewRequestResult {
    case success(height: CGFloat)
    case failure(error: String)
}

typealias Completion = (_ result: WebViewRequestResult) -> Void

class WebView: WKWebView {
    
    let keyPath = "scrollView.contentSize"
    let caculateHeightJS = "document.body.offsetHeight"

    private var completion: Completion?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        let configuration = WKWebViewConfiguration()
        super.init(frame: CGRect.zero, configuration: configuration)
        self.backgroundColor = Color.themeColor
        self.navigationDelegate = self
        self.addObserver(self, forKeyPath: keyPath, options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    /// Load request for webpage
    ///
    /// - parameter url: webpage url
    /// - completion: closure, including `Success` and `Failure`
    ///
    func load(with url: String, completion: @escaping Completion) {
        guard url.count > 0 else { return }
        self.completion = completion
        self.load(URLRequest(url: URL(string: url)!))
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: keyPath)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let path = keyPath, path == keyPath {
            printLog(change)
            printLog("observeValue: \(self.scrollView.contentSize)")
        }
    }
}

extension WebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript(caculateHeightJS) { (result, _) in
            printLog("didFinish \(result)")
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        printLog("error:\(error)")
    }
}
