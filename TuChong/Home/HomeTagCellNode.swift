//  HomeTagCellNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/26.
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

// MARK: - HomeTagCellNode

class HomeTagCellNode: ASCellNode {
    
    let imageNode: ASNetworkImageNode
    let titelNode: ASTextNode
    let model: HomePage_More_Item_Model
    
    init(with itemModel: HomePage_More_Item_Model) {
        imageNode = ASNetworkImageNode()
        titelNode = ASTextNode()
//        imageNode.isLayerBacked = true
//        titelNode.isLayerBacked = true
        model = itemModel
        super.init()
        self.addSubnode(imageNode)
        self.addSubnode(titelNode)
    }
    
    override func didLoad() {
        imageNode.url = URL(string: model.image.urlString)!
        titelNode.attributedText = NSAttributedString(string: model.tag_name, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
            ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        titelNode.style.alignSelf = .center
        let insetImageLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2), child: imageNode)
        let insetLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity, left: 0, bottom: 0, right: 0), child: titelNode)
        let centerLayoutSpec = ASCenterLayoutSpec(centeringOptions: .X, sizingOptions: .minimumXY, child: insetLayoutSpec)
        return ASOverlayLayoutSpec(child: insetImageLayoutSpec, overlay: centerLayoutSpec)
    }
}

class HomeTagSectionHeaderNode: ASCellNode {
    
    let headerTitle: String
    let titleNode: ASTextNode
    let separator: ASImageNode
    
    init(with sectionTitle: String) {
        headerTitle = sectionTitle
        titleNode = ASTextNode()
        separator = ASImageNode()
        titleNode.isLayerBacked = true
        separator.isLayerBacked = true
        super.init()
        self.addSubnode(titleNode)
        self.addSubnode(separator)
    }
    
    override func didLoad() {
        self.backgroundColor = UIColor.white
        let color = UIColor(red: 239.0 / 255.0, green: 45.0 / 255.0, blue: 88.0 / 255.0, alpha: 1.0)
        separator.image = UIImage.as_resizableRoundedImage(withCornerRadius: 8.0, cornerColor: color, fill: color)
        titleNode.attributedText = NSAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        separator.style.preferredSize = CGSize(width: 4, height: 12)
        let horizontal = ASStackLayoutSpec.init(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .center, children: [separator, titleNode])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: horizontal)
    }
}
