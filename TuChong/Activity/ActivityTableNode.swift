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

class ActivityBannerCell: BaseCellNode {
    
    private let bannerModel: Activity_Top_Banner_Model
    private let imageNode: ASNetworkImageNode
    
    init(banner model: Activity_Top_Banner_Model) {
        bannerModel = model
        imageNode = ASNetworkImageNode()
        imageNode.contentMode = .scaleAspectFill
        super.init()
        imageNode.isLayerBacked = true
    }
    
    override func didLoad() {
        super.didLoad()
        imageNode.url = URL(string: bannerModel.src)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: imageNode)
    }
}

// MARK: - ActivityBannerCollectionNodeProtocol

@objc protocol ActivityBannerCollectionNodeProtocol: class {
    @objc optional func collection(node: ASCollectionNode, index: Int)
}

// MARK: - ActivityBannerCollectionNode

class ActivityBannerCollectionNode : ASCollectionNode {
    
    weak var collectionNodeDelegate: ActivityBannerCollectionNodeProtocol?
    
    private let max_section: Int = 50

    private var timer: Timer?

    var bannerModel: [Activity_Top_Banner_Model] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("failure")
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout, layoutFacilitator: nil)
        self.delegate = self
        self.dataSource = self
        self.showsHorizontalScrollIndicator = false 
    }
    
    func configureWith(bannerModel: [Activity_Top_Banner_Model]) {
        self.bannerModel = bannerModel
        self.reloadData()
        /// scroll to center
        self.scrollToItem(at: IndexPath(row: 0, section: max_section / 2), at: UICollectionView.ScrollPosition.left, animated: false)
        /// enable timer
        self.enableTimer()
    }
    
    /// timer start work
    private func enableTimer() {
        let timer = Timer(timeInterval: 2.0, block: { [weak self] (_) in
            guard let `self` = self else { return }
            self.handleTimerEvent()
        }, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        self.timer = timer
    }
    
    /// disable timer
    private func disableTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    private func handleTimerEvent() {
        guard let indexPath = self.indexPathsForVisibleItems.first else { return }
        var row = indexPath.row + 1
        var section = indexPath.section
        if row >= bannerModel.count {
            row = 0
            section += 1
            if section >= max_section {
                section = max_section / 2
            }
            self.scrollToItem(at: IndexPath(row: row, section: section), at: UICollectionView.ScrollPosition.left, animated: false)
        }
        self.scrollToItem(at: IndexPath(row: row, section: section), at: UICollectionView.ScrollPosition.left, animated: true)
    }
}

// MARK: - ASCollectionDataSource, ASCollectionDelegate

extension ActivityBannerCollectionNode: ASCollectionDataSource, ASCollectionDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = (Int)(scrollView.contentOffset.x / self.frame.width + 0.5) % bannerModel.count
        self.collectionNodeDelegate?.collection?(node: self, index: page)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.disableTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// 用户交互完毕打开timer
        self.enableTimer()
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return max_section
    }
    
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

// MARK: - ActivityCategoryType

enum ActivityCategoryType {
    case club
    case photographer
    case lecture
    case tutorial
    case unknown
    
    init(with index: Int) {
        switch index {
        case 0:
            self = .club
        case 1:
            self = .photographer
        case 2:
            self = .lecture
        case 3:
            self = .tutorial
        default:
            self = .unknown
        }
    }
}

// MARK: - ActivityCategoryNodeProtocol

protocol ActivityCategoryNodeProtocol: NSObjectProtocol {
    func category(node: ActivityCategoryNode, hasSelcted categoryType: ActivityCategoryType)
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
    
    weak var delegate: ActivityCategoryNodeProtocol?
    
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
        self.delegate?.category(node: self, hasSelcted: ActivityCategoryType(with: button.view.tag))
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

// MARK: - ActivityBannerViewProtocol

protocol ActivityBannerViewProtocol: NSObjectProtocol {
    func banner(view: ActivityBannerView, categoryNode: ActivityCategoryNode, hasSelcted categoryType: ActivityCategoryType)
}

// MARK: - ActivityBannerView

class ActivityBannerView: UIView {
    
    weak var delegate: ActivityBannerViewProtocol?
    private var pageControl: PageControlView?
    
    var heights: CGFloat = 360
    
    var collectionNodeHeight: CGFloat {
        return heights * 0.6
    }
    
    var categoryNodeHeight: CGFloat {
        return heights * 0.3
    }
    
    var titleNodeHeight: CGFloat {
        return heights * 0.1
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
        categoryNode.delegate = self
        collectionNode.view.isPagingEnabled = true
    }
    
    func configureTopBanner(with data: [Activity_Top_Banner_Model]) {
        /// 添加分页视图
        let pageControl = PageControlView(count: data.count, frame: collectionNode.bounds)
        self.addSubview(pageControl)
        self.pageControl = pageControl
        /// 配置`collectionNode`
        collectionNode.collectionNodeDelegate = self
        collectionNode.configureWith(bannerModel: data)
    }
}

extension ActivityBannerView: ActivityCategoryNodeProtocol, ActivityBannerCollectionNodeProtocol {
    
    func category(node: ActivityCategoryNode, hasSelcted categoryType: ActivityCategoryType) {
        self.delegate?.banner(view: self, categoryNode: node, hasSelcted: categoryType)
    }
    
    func collection(node: ASCollectionNode, index: Int) {
        self.pageControl?.changeIndicatorWith(index: index)
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
    let prizeDescNode: ASTextNode
    let redpacketImageNode: ASImageNode
    let redpacketActivityDesNode: ASTextNode
    let backgroundNode: ASDisplayNode
    let deadlineNode: ASTextNode
    /// 角标
    let cornermarkNode: ASImageNode
    
    init(with model: Activity_Events_Model) {
        self.event = model
        self.imageNode = ASNetworkImageNode()
        self.titleNode = ASTextNode()
        self.prizecountNode = ASTextNode()
        self.dotImageNode = ASImageNode()
        self.trophyImageNode = ASImageNode()
        self.prizeDescNode = ASTextNode()
        self.redpacketImageNode = ASImageNode()
        self.redpacketActivityDesNode =  ASTextNode()
        self.backgroundNode = ASDisplayNode()
        self.deadlineNode = ASTextNode()
        self.cornermarkNode = ASImageNode()
        super.init()
        self.selectionStyle = .none
        self.automaticallyManagesSubnodes = true
        /// layer backed
        self.imageNode.isLayerBacked = true
        self.titleNode.isLayerBacked = true
        self.prizecountNode.isLayerBacked = true
        self.dotImageNode.isLayerBacked = true
        self.trophyImageNode.isLayerBacked = true
        self.prizeDescNode.isLayerBacked = true
        self.redpacketImageNode.isLayerBacked = true
        self.redpacketActivityDesNode.isLayerBacked = true
        self.backgroundNode.isLayerBacked = true
        self.deadlineNode.isLayerBacked = true
        self.cornermarkNode.isLayerBacked = true
    }
    
    override func didLoad() {
        super.didLoad()
        /// set background color
        backgroundColor = Color.backGroundColor
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
        /// prize describtion
        prizeDescNode.maximumNumberOfLines = 1
        prizeDescNode.truncationMode = .byTruncatingTail
        prizeDescNode.attributedText = NSAttributedString(string: event.is_packet ? event.image_count_string : event.prize_desc, attributes: [NSAttributedString.Key.font: UIFont.normalFont_12(),
                                                                                                 NSAttributedString.Key.foregroundColor: UIColor.black])
        /// red packet
        redpacketActivityDesNode.attributedText = NSAttributedString(string: R.string.localizable.red_packet_activity(), attributes:     [NSAttributedString.Key.font: UIFont.normalFont_12(),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.backgroundColor: RGBA(R: 250, G: 32, B: 104)
            ])
        redpacketImageNode.image = R.image.red_envelopes()
        /// background node
        backgroundNode.backgroundColor = RGBA(R: 248, G: 247, B: 245)
        /// deadline area
        deadlineNode.attributedText = NSAttributedString(string: event.remainingDays_string, attributes: [NSAttributedString.Key.font: UIFont.normalFont_12(),
                                                                                      NSAttributedString.Key.foregroundColor: UIColor.white
                                                                                    ])
        cornermarkNode.image = R.image.corner_mark()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

        prizeDescNode.style.maxWidth = ASDimension(unit: .points, value: 200)
        dotImageNode.style.preferredSize = CGSize(width: 8, height: 8)
        trophyImageNode.style.preferredSize = CGSize(width: 20, height: 20)
        redpacketImageNode.style.preferredSize = CGSize(width: 15, height: 15)
        
        var horizontalLayoutSpec: ASStackLayoutSpec
        
        if event.is_packet {
        horizontalLayoutSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
            /// red packet
            ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .start, alignItems: .center, children: [
                redpacketImageNode,
                redpacketActivityDesNode
                ]),
            dotImageNode,
            prizeDescNode
            ])
        } else {
            /// Price desc ared
        horizontalLayoutSpec = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .center, children: [
            prizecountNode,
            dotImageNode,
            trophyImageNode,
            prizeDescNode
            ])
        }
        /// Vertical stack
        let verticalLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [
            titleNode,
            horizontalLayoutSpec])
        
        /// BackgroundLayoutSpec
        let backgroundLayoutSpec = ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16), child: verticalLayoutSpec), background: backgroundNode)
        
        /// Main stack
        let mainStackLayoutSpec = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [
            ASRatioLayoutSpec(ratio: 0.6, child: imageNode),
            backgroundLayoutSpec
            ])
        
        /// Main inset
        let insetLayoutSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: mainStackLayoutSpec)
        
        /// Whether show Deadline 
        if event.showDeadline {
            /// Cornermark background
            let cornermarkBackgroundLayoutSpec = ASBackgroundLayoutSpec(child: ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 20), child: deadlineNode), background: cornermarkNode)
            /// Main layout
            return ASOverlayLayoutSpec(child: insetLayoutSpec, overlay: ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: CGFloat.infinity, right: CGFloat.infinity), child: cornermarkBackgroundLayoutSpec))
        } else {
            return insetLayoutSpec
        }
    }
}

// MARK: - ActivityTableNodeProtocol
protocol ActivityTableNodeProtocol: NSObjectProtocol {
    func tableNode(node: ActivityTableNode, hasSelcted categoryType: ActivityCategoryType)
}

// MARK: - ActivityTableNode

class ActivityTableNode: ASTableNode {
    
    private var bannerView = ActivityBannerView()
    private var eventsModel: [Activity_Events_Model] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    weak var tableNodeDelegate: ActivityTableNodeProtocol?
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = Color.backGroundColor
        self.view.separatorStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
        self.bannerView.delegate = self
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

// MARK: - ActivityBannerViewProtocol

extension ActivityTableNode: ActivityBannerViewProtocol {
    
    func banner(view: ActivityBannerView, categoryNode: ActivityCategoryNode, hasSelcted categoryType: ActivityCategoryType) {
        self.tableNodeDelegate?.tableNode(node: self, hasSelcted: categoryType)
    }
}
