//  AppDelegate+Extension.swift
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

import AsyncDisplayKit

// MARK: - AppDelegate

extension AppDelegate {

    /// 设置主窗口
    func setKeyWindow() {
        /// TabBar
        let tabBarController = BaseTabBarController()
        /// Window
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    /// 设置开机广告
    func setLaunchAdvertiseMent() {
        LaunchManager.manager.show()
    }
}

// MARK: - ASTextNode

let kLinkAttributeName = "kLinkAttributeName"

extension ASTextNode {
    ///
    /// setting `ASTextNode` attributed
    ///
    ///
    /// - parameter name:  user name
    /// - parameter title:  title
    /// - parameter content:  description of picture
    /// - parameter tags: tags array
    /// - parameter isFloding: Whether the cell folds, Default is `True`
    ///
    func setAttributedWith(name: String, title: String, content: String, tags: [Recommend_Feedlist_Tags_Model], isFloding: Bool = true) {
        var contentString = ""
        if !title.isEmpty && !content.isEmpty {
            contentString = title + "·" + content
        } else if !title.isEmpty {
            contentString = title
        } else if !content.isEmpty {
            contentString = content
        }
        var tagString = ""
        for item in tags {
            tagString += String(format: " #%@", item.tag_name)
        }
        contentString = String(format: "%@%@", contentString, tagString)
        if contentString.count == 0 {
            self.attributedText = nil
        } else {
            /// add addAttributesString
            contentString = String(format: "%@ %@", name, contentString)
            let attr = NSMutableAttributedString(string: contentString, attributes: [
                NSAttributedString.Key.font: UIFont.normalFont_13(),
                NSAttributedString.Key.foregroundColor: UIColor.black
                ])
            attr.addAttributes([NSAttributedString.Key.font: UIFont.boldFont_13()], range: NSString(string: contentString).range(of: name))
            /// add tap event for tags
            self.linkAttributeNames = [kLinkAttributeName]
            for item in tags {
                let value = String(format: " #%@", item.tag_name)
                attr.addAttributes([
                    NSAttributedString.Key.init(rawValue: kLinkAttributeName): value,
                    NSAttributedString.Key.underlineColor: UIColor.clear
                    ],
                                   range: NSString(string: contentString).range(of: value))
            }
            self.attributedText = attr
            if isFloding {
                /// add truncationAttributedText
                self.maximumNumberOfLines = 2
                let truncationStr = "...\(R.string.localizable.more())"
                let truncationAttr = NSMutableAttributedString(string: truncationStr, attributes: [
                    NSAttributedString.Key.font: UIFont.normalFont_13(),
                    NSAttributedString.Key.foregroundColor: Color.lightGray])
                truncationAttr.addAttributes([
                    NSAttributedString.Key.foregroundColor: UIColor.black
                    ], range: NSString(string: truncationStr).range(of: "..."))
                self.truncationAttributedText = truncationAttr
            } else {
                self.truncationAttributedText = nil
                self.maximumNumberOfLines = 0
            }
        }
    }
    
    func setAttributedWith(name: String, content: String, maxLines: UInt) {
        let string = "\(name)  \(content)"
        let attr = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_13(),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ])
        attr.addAttributes([
            NSAttributedString.Key.font: UIFont.boldFont_13(),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], range: NSString(string: string).range(of: name))
        
        self.attributedText = attr
        self.maximumNumberOfLines = maxLines
        self.truncationMode = .byTruncatingTail
    }
    
    ///
    /// setting `ASTextNode` attributed
    ///
    ///
    /// - parameter replyName:   commenter
    /// - parameter repiedName:  the user who is repied
    /// - parameter content:  reply content
    ///
    func setAttributedWith(replyName: String, repiedName: String, content: String) {
        let string = "\(replyName)  @\(repiedName)  \(content)"
        let attr = NSMutableAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: UIFont.normalFont_13(),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ])
        attr.addAttributes([
            NSAttributedString.Key.font: UIFont.boldFont_13(),
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], range: NSString(string: string).range(of: replyName))
        self.attributedText = attr
        self.maximumNumberOfLines = 1
        self.truncationMode = .byTruncatingTail
    }
    
    func setAttributdWith(string: String, font: UIFont, color: UIColor = UIColor.black, aligement: NSTextAlignment? = nil) {
        if let aligeValue = aligement {
            let style = NSMutableParagraphStyle()
            style.alignment = aligeValue
            self.attributedText = NSAttributedString(string: string, attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color,
                NSAttributedString.Key.paragraphStyle: style
                ])
        } else {
            self.attributedText = NSAttributedString(string: string, attributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: color
                ])
        }
    }
}

// MARK: - ASButtonNode

extension ASButtonNode {
    
    func setAttributdWith(string: String, font: UIFont, color: UIColor = UIColor.black, state: UIControl.State) {
        
        self.setAttributedTitle(NSAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
            ]), for: state)
    }
}

// MARK: - UIButton

extension UIButton {
    
    func setAttributdWith(string: String, font: UIFont, color: UIColor = UIColor.black, state: UIControl.State) {
        self.setAttributedTitle(NSAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
            ]), for: state)
    }
}

// MARK: - ASDisplayNode

extension ASDisplayNode {
    
    /// fast to add corner and border
    func set(cornerRadius: CGFloat = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor = UIColor.clear) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.view.clipsToBounds = true
    }
    
    /// use this method to change `ScrollView` contetOffset to adjust subItem's location
    func scrollAnimate(with selectedBtn: NavItemButton, scrollView: UIScrollView, containerView: UIView) {
        guard scrollView.contentSize.width > containerView.width else { return }
        let contentWidth = scrollView.contentSize.width
        let offsetX = (containerView.width - selectedBtn.width) / 2.0
        if selectedBtn.left <= containerView.width / 2.0 {
            /// don't need
            scrollView.setContentOffset(CGPoint.zero, animated: false)
        } else if selectedBtn.frame.maxX > contentWidth - containerView.width / 2.0 {
            let x = contentWidth - containerView.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        } else {
            let x = selectedBtn.frame.minX - offsetX
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        }
    }
}

// MARK: - UIView

extension UIView {
    
    /// fast to add corner and border
    func set(cornerRadius: CGFloat = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor = UIColor.clear) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
}
