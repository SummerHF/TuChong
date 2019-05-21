//  ProfileContainer.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/21.
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

import Kingfisher
import AsyncDisplayKit
import SnapKit

// MARK: - ProfileContainerBottomView

class ProfileContainerBottomView: UIView {
    
    private var profile: ProfileModel = ProfileModel()
    private let attentionLable: UILabel = UILabel()
    private let fansLable: UILabel = UILabel()
    private let likesLable: UILabel = UILabel()
    private let sepatorView: UIView = UIView()
    private let margin: CGFloat = 20.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.backGroundColor
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(sepatorView)
        self.sepatorView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.6)
        }
        self.addSubview(attentionLable)
        self.addSubview(fansLable)
        self.addSubview(likesLable)
    }
    
    func configureWith(profile: ProfileModel) {
        attentionLable.attributedText = profile.site.intro_attributedtext(desc: "关注", count: profile.site.following)
        fansLable.attributedText = profile.site.intro_attributedtext(desc: "粉丝", count: profile.site.followers)
        likesLable.attributedText = profile.site.intro_attributedtext(desc: "获赞", count: profile.site.favorites)
        self.attentionLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.top.bottom.equalToSuperview()
        }
        self.fansLable.snp.makeConstraints { (make) in
            make.left.equalTo(attentionLable.snp.right).offset(margin)
            make.top.bottom.equalToSuperview()
        }
        self.likesLable.snp.makeConstraints { (make) in
            make.left.equalTo(fansLable.snp.right).offset(margin)
            make.top.bottom.equalToSuperview()
        }
        self.sepatorView.backgroundColor = Color.lineGray
    }
}

// MARK: - ProfileDetailType

enum ProfileDetailType {
    case work
    case like
    case activity
    case none
    
    init(index: Int) {
        switch index {
        case 0:
            self = .work
        case 1:
            self = .like
        case 2:
            self = .activity
        default:
            self = .none
        }
    }
    
    var rawValue: Int {
        switch self {
        case .work:
            return 0
        case .like:
            return 1
        case .activity:
            return 2
        case .none:
            return 3
        }
    }
}

protocol ProfileDetailTopViewProtocol: class {
    func topView(view: ProfileDetailTopView, hasSelectedTypeIndex: Int)
}

// MARK: - ProfileDetailTopView

class ProfileDetailTopView: UIView, ProfileDetailTopItemViewProtocol {
    
    weak var delegate: ProfileDetailTopViewProtocol?
    
    private var statistics = Profile_Statistics_Model()
    
    private let itemWidth: CGFloat = 80
    private let indicatorViewSize = CGSize(width: 10, height: 3)
    private let worksItemView = ProfileDetailTopItemView()
    private let likesItemView = ProfileDetailTopItemView()
    private let activityItemView = ProfileDetailTopItemView()
    private let separoterView = UIView()
    private let indicatorView = UIView()
    private var itemArray: [ProfileDetailTopItemView] = []
    private var previousType: ProfileDetailType?
    
    private var indicatorCenterYConstraint: Constraint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(worksItemView)
        self.addSubview(likesItemView)
        self.addSubview(activityItemView)
        self.addSubview(separoterView)
        self.addSubview(indicatorView)
        
        self.worksItemView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
        
        self.likesItemView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
        
        self.activityItemView.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(itemWidth)
        }
        self.separoterView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        itemArray = [self.worksItemView, self.likesItemView, self.activityItemView]
    }
    
    func configureWith(statistics: Profile_Statistics_Model, defaultType: ProfileDetailType) {
        self.statistics = statistics
        self.worksItemView.configureWith(title: R.string.localizable.profile_work(), count: statistics.works, type: .work, delegate: self)
        self.likesItemView.configureWith(title: R.string.localizable.profile_like(), count: statistics.favorites, type: .like, delegate: self)
        self.activityItemView.configureWith(title: R.string.localizable.profile_activity(), count: statistics.events, type: .activity, delegate: self)
        self.separoterView.backgroundColor = Color.lineGray
        self.setSelectedWith(type: defaultType, animated: false)
    }
    
    func setSelectedWith(type: ProfileDetailType, animated: Bool) {
        if let defaultType = self.previousType, defaultType != type {
            /// 当前选中
            let currentItemView = self.itemArray[type.rawValue]
            currentItemView.isSelected = true
            let previousItemView = self.itemArray[defaultType.rawValue]
            previousItemView.isSelected = false
            self.previousType = type
        } else {
            let itemView = self.itemArray[type.rawValue]
            itemView.isSelected = true
            self.previousType = type
        }
        if let type = self.previousType {
            self.indicatorAnimate(itemView: itemArray[type.rawValue], animated: animated)
            /// notify delegate
            self.delegate?.topView(view: self, hasSelectedTypeIndex: type.rawValue)
        }
    }
    
    private func indicatorAnimate(itemView: ProfileDetailTopItemView, animated: Bool) {
        self.indicatorView.backgroundColor = Color.lineColor
        if animated {
            self.indicatorCenterYConstraint?.deactivate()
            self.indicatorView.snp.makeConstraints { (make) in
                self.indicatorCenterYConstraint = make.centerX.equalTo(itemView).constraint
            }
            self.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.8, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            self.indicatorView.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.separoterView.snp.top)
                make.size.equalTo(self.indicatorViewSize)
                self.indicatorCenterYConstraint = make.centerX.equalTo(itemView).constraint
            }
        }
    }
    
    func hasSelected(view: ProfileDetailTopItemView, type: ProfileDetailType) {
        self.setSelectedWith(type: type, animated: true)
    }
}

// MARK: - ProfileDetailView

class ProfileDetailView: UIView {
    
    private let topView: ProfileDetailTopView = ProfileDetailTopView()
    private let scrollView: ProfileDetailScrollView = ProfileDetailScrollView()
    private let topViewHeight: CGFloat = 80
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Color.backGroundColor
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.addSubview(topView)
        self.addSubview(scrollView)
        self.topView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(topViewHeight)
        }
        self.scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
    }
    
    func configureWith(profile: ProfileModel) {
        self.topView.delegate = self
        self.scrollView.detailScrollViewDelegate = self
        self.topView.configureWith(statistics: profile.statistics, defaultType: .work)
        self.scrollView.configureWith(site_id: profile.site.site_id)
    }
    
    func scroll(enabled: Bool) {
        self.scrollView.scroll(enabled: enabled)
    }
}

extension ProfileDetailView: ProfileDetailTopViewProtocol, ProfileDetailScrollViewProtocol {
    
    func topView(view: ProfileDetailTopView, hasSelectedTypeIndex: Int) {
        self.scrollView.scrollTo(index: hasSelectedTypeIndex)
    }
    
    func scrollView(view: ProfileDetailScrollView, scrollTo index: Int) {
        self.topView.setSelectedWith(type: ProfileDetailType(index: index), animated: true)
    }
}

// MARK: - ProfileContainer

class ProfileContainer: UIView {
    
    private let bgImageView: UIImageView
    private let avatorImageNode: ASNetworkImageNode
    private let avatorImageViewSize = CGSize(width: 70, height: 70)
    private let focusBtnNodeSize = CGSize(width: 70, height: 28)
    private let focusBtnNode: ASButtonNode
    
    private let nameLable: UILabel = UILabel()
    private let vertificationImageView: UIImageView = UIImageView()
    private let vertificationImageViewWidth: CGFloat = 12.0
    private let vertificationReasonLable: UILabel = UILabel()
    private let introLable: UILabel = UILabel()
    private let introLableMaxWidth: CGFloat = macro.screenWidth - 4.8 * 20
    private let moreBtnNode: ASButtonNode = ASButtonNode()
    private let moreBtnNodeSize = CGSize(width: 44, height: 14)
    private let bottomViewHeight: CGFloat = 56
    private let margin: CGFloat = 20.0
    private let offset: CGFloat = 28
    
    /// default top margin
    var topMargin: CGFloat {
        return macro.topHeight + offset
    }
    
    /**
        need to calculate height
     */
    var topOffSet: CGFloat {
        switch profile.coverType {
        case .none:
            return topMargin
        case .singleVerticalImage:
            return macro.screenHeight * 0.8
        case .singleHorizentalImage:
            return macro.screenHeight * 0.4
        case .moreImage:
            return macro.screenHeight * 0.8
        }
    }
    
    var containerHeight: CGFloat {
        return macro.screenHeight + topMargin
    }
    
    var contentSizeHeight: CGFloat {
        return containerHeight + topOffSet
    }
    
    /// caculate content size
    var contentSize: CGSize {
        return CGSize(width: macro.screenWidth, height: contentSizeHeight)
    }
    
    private var profile: ProfileModel = ProfileModel()
    
    /// bottom view
    private let bottomView: ProfileContainerBottomView = ProfileContainerBottomView(frame: CGRect.zero)
    /// detail view
    private let detailView: ProfileDetailView = ProfileDetailView(frame: CGRect.zero)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        self.bgImageView = UIImageView()
        self.avatorImageNode = ASNetworkImageNode()
        self.focusBtnNode = ASButtonNode()
        super.init(frame: CGRect.zero)
        self.setPropertys()
        self.addEvents()
    }
    
    private func setPropertys() {
        self.addSubview(bgImageView)
        self.addSubview(avatorImageNode.view)
        self.addSubview(nameLable)
        self.addSubview(focusBtnNode.view)
        self.bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.bgImageView.image = UIImage(color: UIColor.white)?.byResize(to: UIScreen.main.bounds.size)?.byRoundCornerRadius(15.0)
        
        /// user info
        self.avatorImageNode.view.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin)
            make.centerY.equalTo(self.snp.top).offset(margin)
            make.size.equalTo(avatorImageViewSize)
        }
        self.nameLable.snp.makeConstraints { (make) in
            make.left.equalTo(avatorImageNode.view)
            make.top.equalToSuperview().offset(margin * 3.10)
        }
        self.focusBtnNode.view.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-margin)
            make.centerY.equalTo(nameLable)
            make.size.equalTo(focusBtnNodeSize)
        }
    }
    
    /// Whether enabled scroll 
    func scroll(enabled: Bool) {
        self.detailView.scroll(enabled: enabled)
    }
    
    func configureWith(profile: ProfileModel) {
        
        self.profile = profile
        /// frame
        self.frame = CGRect(x: 0, y: topOffSet, width: macro.screenWidth, height: containerHeight)
        /// avator
        self.avatorImageNode.url = profile.site.iconURL
        self.avatorImageNode.imageModificationBlock = {
            image in
            image.byRoundCornerRadius(image.size.width / 2.0, borderWidth: 2.0, borderColor: Color.backGroundColor)
        }
        self.nameLable.set(title: profile.site.name, font: UIFont.boldFont_20(), color: Color.black)
        self.focusBtnNode.setAttributdWith(string: R.string.localizable.focus(), font: UIFont.normalFont_12(), color: Color.backGroundColor, state: .normal)
        self.focusBtnNode.add(cornerRadius: focusBtnNodeSize.height / 2.0, backgroundColor: Color.lineColor, cornerRoundingType: .defaultSlowCALayer)
        
        /// intro
        self.addSubview(introLable)
        if profile.site.recommend_photographer_verified {
            self.addSubview(vertificationImageView)
            self.addSubview(vertificationReasonLable)
            self.vertificationImageView.snp.makeConstraints { (make) in
                make.left.equalTo(nameLable)
                make.top.equalTo(nameLable.snp.bottom).offset(margin)
                make.size.equalTo(CGSize(width: vertificationImageViewWidth, height: vertificationImageViewWidth))
            }
            self.vertificationReasonLable.snp.makeConstraints { (make) in
                make.left.equalTo(vertificationImageView.snp.right).offset(margin * 0.2)
                make.centerY.equalTo(vertificationImageView)
            }
            self.introLable.snp.makeConstraints { (make) in
                make.top.equalTo(vertificationImageView.snp.bottom).offset(margin * 0.3)
                make.left.equalTo(vertificationImageView)
                make.width.equalTo(introLableMaxWidth)
            }
            self.vertificationImageView.image = profile.site.verified_image
            self.vertificationReasonLable.set(title: profile.site.verified_reason, font: UIFont.normalFont_12(), color: Color.black)
        } else {
            self.introLable.snp.makeConstraints { (make) in
                make.left.equalTo(nameLable)
                make.top.equalTo(nameLable.snp.bottom).offset(margin)
                make.width.equalTo(introLableMaxWidth)
            }
        }
        self.introLable.numberOfLines = 1
        self.introLable.set(title: profile.site.intro_desc, font: UIFont.normalFont_12(), color: Color.lightGray)
        
        /// need to show more button
        if profile.site.intro_desc.size(withAttributes: [NSAttributedString.Key.font: UIFont.normalFont_12()]).width > introLableMaxWidth {
            self.addSubview(moreBtnNode.view)
            moreBtnNode.view.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-margin)
                make.bottom.equalTo(introLable)
                make.size.equalTo(moreBtnNodeSize)
            }
            moreBtnNode.setAttributdWith(string: R.string.localizable.profile_more(), font: UIFont.normalFont_12(), color: Color.lineColor, state: .normal)
        }
        
        /// add bottomView
        self.addSubview(bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(introLable.snp.bottom).offset(margin * 0.5)
            make.left.right.equalToSuperview()
            make.height.equalTo(bottomViewHeight)
        }
        self.bottomView.configureWith(profile: profile)
        /// add detailView
        self.addSubview(detailView)
        self.detailView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        self.detailView.configureWith(profile: profile)
        self.detailView.scroll(enabled: false)
    }
    
    private func addEvents() {
        self.moreBtnNode.addTarget(self, action: #selector(moreBtnNodeEvent), forControlEvents: .touchUpInside)
    }
    
    @objc private func moreBtnNodeEvent() {
        if self.introLable.numberOfLines == 0 {
            self.introLable.numberOfLines = 1
            self.moreBtnNode.setAttributdWith(string: R.string.localizable.profile_more(), font: UIFont.normalFont_12(), color: Color.lineColor, state: .normal)
            self.layoutIfNeeded()
        } else {
            self.introLable.numberOfLines = 0
            self.moreBtnNode.setAttributdWith(string: R.string.localizable.profile_less(), font: UIFont.normalFont_12(), color: Color.lineColor, state: .normal)
            self.layoutIfNeeded()
        }
    }
}
