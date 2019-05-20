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

class HomeTagCellNode: BaseCellNode {
    
    let imageNode: ASNetworkImageNode
    let coverImageNode: ASImageNode
    let titelNode: ASTextNode
    let model: HomePage_More_Item_Model
    
    private let insetForTitleNode = UIEdgeInsets(top: CGFloat.infinity, left: 0, bottom: 4, right: 0)
    
    init(with itemModel: HomePage_More_Item_Model) {
        model = itemModel
        imageNode = ASNetworkImageNode()
        titelNode = ASTextNode()
        coverImageNode = ASImageNode()
        super.init()
    }
    
    override func didLoad() {
        coverImageNode.image = R.image.profile_cover()
        imageNode.contentMode = .scaleAspectFill
        imageNode.url = URL(string: model.image.urlString)
        titelNode.setAttributdWith(string: model.tag_name, font: UIFont.normalFont_14(), color: Color.flatWhite, aligement: .center)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backgroundLayout = ASBackgroundLayoutSpec(child: self.createTitleLayoutSpec(), background: self.imageNode)
        return ASOverlayLayoutSpec(child: backgroundLayout, overlay: ASInsetLayoutSpec(insets: insetForTitleNode, child: self.titelNode))
    }
    
    private func createTitleLayoutSpec() -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            ASStackLayoutSpec().styled({ (style) in
                style.flexGrow = 1.0
            }),
            self.coverImageNode.styled({ (style) in
                style.maxHeight = ASDimensionMake(80)
            })
        ])
        return stack
    }
}

// MARK: - SectionHeaderNode &&  SectionHeaderView

class CollectionSectionHeaderNode: ASCellNode {
    
    private let insetForHeader = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0)
    
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
        super.didLoad()
        self.backgroundColor = Color.backGroundColor
        let color = Color.lineColor
        separator.image = UIImage.as_resizableRoundedImage(withCornerRadius: 8.0, cornerColor: color, fill: color)
        titleNode.attributedText = NSAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        separator.style.preferredSize = CGSize(width: 4, height: 12)
        let horizontal = ASStackLayoutSpec.init(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .center, children: [separator, titleNode])
        return ASInsetLayoutSpec(insets: insetForHeader, child: horizontal)
    }
}

// MARK: - TableSectionHeaderView

class TableSectionHeaderView: UIView {
    
    static let headerHeight: CGFloat = 44
    static let footerHeight: CGFloat = 0.000001

    let headerTitle: String
    let titleNode: ASTextNode
    let separator: ASImageNode
    
    init(with sectionTitle: String) {
        self.headerTitle = sectionTitle
        self.titleNode = ASTextNode()
        self.separator = ASImageNode()
        let frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: TableSectionHeaderView.headerHeight)
        super.init(frame: frame)
        self.setProperty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setProperty() {
        backgroundColor = Color.backGroundColor
        self.addSubnode(titleNode)
        self.addSubnode(separator)
        separator.image = UIImage.as_resizableRoundedImage(withCornerRadius: 8.0, cornerColor: Color.lineColor, fill: Color.lineColor)
        titleNode.attributedText = NSAttributedString(string: headerTitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        /// layouts
        separator.view.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 4, height: 12))
        }
        
        titleNode.view.snp.makeConstraints { (make) in
            make.left.equalTo(separator.view.snp.right).offset(8)
            make.centerY.equalTo(separator.view)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(14)
        }
    }
}
