//  String+Extension.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/19.
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

/**
 UIKit Extents
 */

// MARK: - String

public extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}

// MARK: - Int

public extension Int {
    
    /// 产生随机数
    /// [0, upper)
    static func randomIntValue(upper: Int) -> Int {
        return Int(arc4random_uniform(UInt32(upper)))
    }
}

// MARK: - UILabel

public extension UILabel {
    
    /// 快速创建lable
    static func lable(with title: String? = "", font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = UIColor.white) -> UILabel {
        let lable = UILabel()
        lable.text = title
        lable.font = font
        lable.textColor = textColor
        return lable
    }
    
    /// 快速赋值
     public func setLable(with title: String? = "", font: UIFont? = UIFont.systemFont(ofSize: 14), textColor: UIColor = UIColor.black) {
        self.text = title
        self.font = font
        self.textColor = textColor
    }
}

// MARK: - String

extension String {
    
    /// 发布时间与当前时间相隔多久
    func offsetTime() -> String {
        guard self.count > 0 else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let publishDate = dateFormatter.date(from: self) ?? Date()
        let currentDate = Date()
        let time = currentDate.timeIntervalSince(publishDate)
        
        _ = time.truncatingRemainder(dividingBy: 60)
        _ = (time / 60).truncatingRemainder(dividingBy: 60)
        /// 向下取整不保留小数点
        let hour = Int(floor((time / 3600).truncatingRemainder(dividingBy: 24)))
        let day = Int(floor(time / 3600 / 24))
        
        var timeStr: String
        if day == 0 {
            timeStr = "\(hour) 小时前"
        } else if day <= 10 {
            timeStr = "\(day) 天前"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            timeStr = dateFormatter.string(from: publishDate)
        }
        return timeStr
    }
}

// MARK: - UILabel

extension UILabel {
    
    func setAttributdWith(string: String, font: UIFont, color: UIColor = UIColor.black, aligment: NSTextAlignment? = .center) {
        self.attributedText = NSAttributedString(string: string, attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
            ])
        self.textAlignment = aligment ?? .center
    }
    
    func set(title: String, font: UIFont, color: UIColor) {
        self.text = title
        self.font = font
        self.textColor = color
    }
    
    func set(title: String, font: UIFont, color: UIColor, aligment: NSTextAlignment) {
        self.text = title
        self.font = font
        self.textColor = color
        self.textAlignment = aligment
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
    
    func set(title: String, font: UIFont) {
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
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

// MARK: - UIFont

public extension UIFont {
    
    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    /// 10号字体
    static func smallFont_10() -> UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
    /// 19号粗体
    static func boldFont_19() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 19)
    }
    
    /// 12号粗体
    static func boldFont_12() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 12)
    }
    
    /// 13号粗体
    static func boldFont_13() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 13)
    }
    
    static func boldFont_14() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 14)
    }
    
    /// 15号粗体
    static func boldFont_15() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }
    
    static func boldFont_16() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    static func boldFont_17() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 17)
    }
    
    /// 20号粗体
    static func boldFont_20() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    static func boldFont_25() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 25)
    }
    
    static func normalFont_10() -> UIFont {
        return UIFont.systemFont(ofSize: 10)
    }
    
    static func normalFont_12() -> UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
    
    static func thinFont_12() -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .thin)
    }
    
    static func normalFont_13() -> UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
    static func normalFont_14() -> UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    static func normalFont_15() -> UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    static func normalFont_16() -> UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    static func normalFont_17() -> UIFont {
        return UIFont.systemFont(ofSize: 17)
    }
    
    static func normalFont_18() -> UIFont {
        return UIFont.systemFont(ofSize: 18)
    }
    
    static func normalFont_20() -> UIFont {
        return UIFont.systemFont(ofSize: 20)
    }
}

/**
 AsyncDisplayKit Extents
 */

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
    
    ///
    /// setting `ASTextNode` attributed
    ///
    ///
    /// - parameter string:   string
    /// - parameter originalString:  originalString
    /// - parameter font:  font
    /// - parameter orignaleFont:   orignaleFont
    /// - parameter color:  color
    /// - parameter originalColor:  originalColor
    /// - parameter aligment:  text aligment, if nil, using `center`
    
    func setAttributdWith(string: String, originalString: String, font: UIFont, orignaleFont: UIFont, color: UIColor = UIColor.black, originalColor: UIColor = Color.lightGray, aligment: NSTextAlignment? = nil) {
        let style = NSMutableParagraphStyle()
        style.alignment = aligment ?? .center
        let attr = NSMutableAttributedString(string: string, attributes: [
                NSAttributedString.Key.font: orignaleFont,
                NSAttributedString.Key.foregroundColor: originalColor,
                NSAttributedString.Key.paragraphStyle: style
            ])
        attr.addAttributes([
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color
            ], range: NSString(string: string).range(of: originalString))
        self.attributedText = attr
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

// MARK: - ASDisplayNode

extension ASDisplayNode {
    
    /// fast to add corner and border
    func set(cornerRadius: CGFloat = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor = UIColor.clear) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.view.clipsToBounds = true
    }
    
    /// This method is efficiently add rounded corners
    /// Suitable for cell content
    func add(cornerRadius: CGFloat = 0.0, backgroundColor: UIColor = Color.backGroundColor) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.cornerRoundingType = .clipping
    }
    
    func add(cornerRadius: CGFloat = 0.0, backgroundColor: UIColor = Color.backGroundColor, cornerRoundingType: ASCornerRoundingType) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.cornerRoundingType = cornerRoundingType
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

// MARK: - ASCollectionNode

extension ASCollectionNode {
    
    /// scroll to top
    func scrollToTop(animate: Bool) {
        self.setContentOffset(CGPoint(x: -self.contentInset.left, y: -self.contentInset.left), animated: animate)
    }
}

// MARK: - ASViewController

/// Add extension for generic type
extension ASViewController where DisplayNodeType == ASDisplayNode {
    
    /// remove dynamic and objc modifier
    /// add dynamic property
    private var loadingNode: ASDisplayNode? {
        get {
            return objc_getAssociatedObject(self, &Macro.loadingKey) as? ASDisplayNode
        }
        set {
            if let newLoadingView = newValue {
                if let oldLoadingView = loadingNode {
                    oldLoadingView.removeFromSupernode()
                }
                /// add new loading view
                self.node.addSubnode(newLoadingView)
                /// bring subview to front
                self.view.bringSubviewToFront(newLoadingView.view)
                /// save new loading view
                objc_setAssociatedObject(self, &Macro.loadingKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    /// use this method to add loading load
    open func showLoadingView(with Frame: CGRect? = CGRect.zero) {
        self.loadingNode = LoadingNode(frame: Frame)
    }
    
    /// remove
    open func removeLoadingView() {
        self.loadingNode?.removeFromSupernode()
    }
}
