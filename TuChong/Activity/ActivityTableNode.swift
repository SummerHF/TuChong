//  ActivityTableNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/29.
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
import UIKit

// MARK: - ActivityBannerCell

class ActivityBannerCell: ASCellNode {
    
    private let bannerModel: Activity_Top_Banner_Model
    private let imageNode: ASNetworkImageNode
    
    init(banner model: Activity_Top_Banner_Model) {
        bannerModel = model
        imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        imageNode.url = URL(string: bannerModel.src)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: imageNode)
    }
}

// MARK: - ActivityBannerCollectionNode

class ActivityBannerCollectionNode : ASCollectionNode {
    
    var bannerModel: [Activity_Top_Banner_Model] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("failure")
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout, layoutFacilitator: nil)
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false 
    }
}

// MARK: - ASCollectionDataSource, ASCollectionDelegate

extension ActivityBannerCollectionNode: ASCollectionDataSource, ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return bannerModel.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return ActivityBannerCell(banner: bannerModel[indexPath.row])
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: self.view.width, height: self.view.height)
        return ASSizeRange(min: size, max: size)
    }
}

// MARK: - ActivityCategoryNode

/// 4个分类
class ActivityCategoryNode: ASDisplayNode {
    
    /// 标题
    var titles = [R.string.localizable.photography_club(), R.string.localizable.recommended_photographer(), R.string.localizable.lecture(), R.string.localizable.photography_tutorial()]
    /// 标题
    var images = [R.image.photography_club(), R.image.recommend_Cameraman(), R.image.lecture(), R.image.photography_tutorial()]
    /// 按钮
    var buttons: [ASButtonNode] = []
    
    override init() {
        super.init()
        self.backgroundColor = Color.backGroundColor
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        
        for index in 0..<titles.count {
            let title = titles[index]
            let image = images[index]
            let button = ASButtonNode()
            /// binding tag
            button.view.tag = index
            /// property
            button.imageNode.style.preferredSize = CGSize(width: 40, height: 40)
            button.titleNode.style.preferredSize = CGSize(width: 60, height: 30)
            button.titleNode.maximumNumberOfLines = 1
            button.titleNode.truncationMode = .byTruncatingTail
            button.laysOutHorizontally = false
            button.setImage(image, for: UIControl.State.normal)
            /// text style
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributed = NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.smallFont_10(),
                                                                            NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                            NSAttributedString.Key.foregroundColor: UIColor.black])
            button.setAttributedTitle(attributed, for: UIControl.State.normal)
            buttons.append(button)
            /// add target
            button.addTarget(self, action: #selector(handleTapEvent(button:)), forControlEvents: .touchUpInside)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .spaceBetween, alignItems: .stretch, children: buttons)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), child: stackLayout)
    }

    /// button event
    @objc private func handleTapEvent(button: ASButtonNode) {
        print(button.view.tag)
    }
}

// MARK: - ActivityTitileNode

class ActivityTitileNode: ASDisplayNode {
    
    let titleNode: ASTextNode
    let imageNode: ASImageNode
    
    override init() {
        titleNode = ASTextNode()
        imageNode = ASImageNode()
        super.init()
        titleNode.isLayerBacked = true
        imageNode.isLayerBacked = true
        self.automaticallyManagesSubnodes = true
    }
    
    override func didLoad() {
        super.didLoad()
        imageNode.image = R.image.iconNearbyHot_15x15_()
        titleNode.attributedText = NSAttributedString(string: R.string.localizable.hot_activity_title(), attributes: [
            NSAttributedString.Key.font : UIFont.boldFont_19(),
            NSAttributedString.Key.foregroundColor: UIColor.flatBlack
            ])
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        imageNode.style.preferredSize = CGSize(width: 20, height: 20)
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .center, alignItems: .center, children: [imageNode, titleNode])
        return stack
    }
}

// MARK: - ActivityTableNode

class ActivityBannerView: UIView {
    
    var heights: CGFloat = 360
    
    var collectionNodeHeight: CGFloat {
        return heights * 0.5
    }
    
    var titleNodeHeight: CGFloat {
        return heights * 0.2
    }
    
    var categoryNodeHeight: CGFloat {
        return heights * 0.3
    }
    
    private let layout: UICollectionViewFlowLayout
    private var collectionNode: ActivityBannerCollectionNode
    private var titleNode: ActivityTitileNode
    private var categoryNode: ActivityCategoryNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: heights)
        layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        collectionNode = ActivityBannerCollectionNode(collectionViewLayout: layout)
        titleNode = ActivityTitileNode()
        categoryNode = ActivityCategoryNode()
        super.init(frame: frame)
        addSubnode(collectionNode)
        addSubnode(titleNode)
        addSubnode(categoryNode)
        setNodeProperty()
    }
    
    private func setNodeProperty() {
        layout.scrollDirection = .horizontal
        collectionNode.frame = CGRect(x: 0, y: 0, width: self.width, height: collectionNodeHeight)
        titleNode.frame = CGRect(x: 0, y: heights - titleNodeHeight, width: self.width, height: titleNodeHeight)
        categoryNode.frame = CGRect(x: 0, y: collectionNode.view.bottom, width: self.width, height: categoryNodeHeight)
        collectionNode.view.isPagingEnabled = true
    }
    
    func configureTopBanner(with data: [Activity_Top_Banner_Model]) {
        collectionNode.bannerModel = data
    }
}

// MARK: - ActivityTableCell

class ActivityTableCell: ASCellNode {
    
    let event: Activity_Events_Model
    let imageNode: ASNetworkImageNode
    let titleNode: ASTextNode
    let prizecountNode: ASTextNode
    let dotImageNode: ASImageNode
    let trophyImageNode: ASImageNode
    
    init(with model: Activity_Events_Model) {
        self.event = model
        self.imageNode = ASNetworkImageNode()
        self.titleNode = ASTextNode()
        self.prizecountNode = ASTextNode()
        self.dotImageNode = ASImageNode()
        self.trophyImageNode = ASImageNode()
        super.init()
        self.selectionStyle = .none
        self.automaticallyManagesSubnodes = true
        /// layer backed
        self.imageNode.isLayerBacked = true
        self.titleNode.isLayerBacked = true
        self.prizecountNode.isLayerBacked = true
        self.dotImageNode.isLayerBacked = true
        self.trophyImageNode.isLayerBacked = true
    }
    
    override func didLoad() {
        super.didLoad()
        imageNode.contentMode = .scaleAspectFill
        imageNode.url = URL(string: event.images.first ?? "")
        /// titleNode
        let attributed = NSMutableParagraphStyle()
        titleNode.maximumNumberOfLines = 1
        titleNode.truncationMode = .byTruncatingTail
        titleNode.attributedText = NSAttributedString(string: event.title, attributes: [
            NSAttributedString.Key.font: UIFont.boldFont_19(),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: attributed
            ])
        /// prizecountNode
        let mutableAttributed = NSMutableAttributedString(string: event.image_count_string, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.normalFont_12()])
        let range = NSString(string: event.image_count_string).range(of: event.image_count_value)
        mutableAttributed.addAttributes([NSAttributedString.Key.font: UIFont.boldFont_12()], range: range)
        prizecountNode.attributedText = mutableAttributed
        /// dotImageNode
        dotImageNode.image = R.image.dot()
        /// trophyImageNode
        trophyImageNode.image = R.image.trophy()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let offset: CGFloat = 36
        titleNode.style.preferredSize = CGSize(width: macro.screenWidth - offset, height: offset)
        imageNode.style.preferredSize = CGSize(width: 40, height: 40)
        trophyImageNode.style.preferredSize = CGSize(width: 20, height: 20)
        /// Price desc ared
        let horizontalLayoutSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 2, justifyContent: .start, alignItems: .center, children: [
            prizecountNode,
            dotImageNode,
            trophyImageNode
            ])
        /// Main stack
        let mainStackLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .center, children: [
            ASRatioLayoutSpec(ratio: 0.6, child: imageNode),
            titleNode,
            horizontalLayoutSpec
            ])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10), child: mainStackLayoutSpec)
    }
}

// MARK: - ActivityTableNode

class ActivityTableNode: ASTableNode {
    
    private var bannerView = ActivityBannerView()
    private var eventsModel: [Activity_Events_Model] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = Color.backGroundColor
        self.view.separatorStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func reload(topBanner: [Activity_Top_Banner_Model], bottomEvents: [Activity_Events_Model]) {
        eventsModel = bottomEvents
        reloadTopBanner(banner: topBanner)
    }
    
    private func reloadTopBanner(banner: [Activity_Top_Banner_Model]) {
        bannerView.configureTopBanner(with: banner)
    }
}

// MARK: - DataSource, Delegate

extension ActivityTableNode: ASTableDataSource, ASTableDelegate {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return eventsModel.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return ActivityTableCell(with: eventsModel[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return bannerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return bannerView.heights
    }
}
