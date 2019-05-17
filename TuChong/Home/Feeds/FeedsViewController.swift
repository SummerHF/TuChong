//
//  FeedsViewController.swift
//  TuChong
//
//  Created by 朱海飞 on 2019/5/16.
//  Copyright © 2019 Summer. All rights reserved.
//

import AsyncDisplayKit

// MARK: - FeedsViewController

/// 用户供稿
class FeedsViewController: BaseViewControlle {
    
    private let backgroundImageView = UIImageView()
    private let margin: CGFloat = 5
    private let saleBtnHeight: CGFloat = 44
    
    lazy var titleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.set(title: R.string.localizable.feeds_title(), font: UIFont.boldFont_25(), color: Color.flatWhite)
        return titleLable
    }()
    
    lazy var subTitleLable: UILabel = {
        let titleLable = UILabel()
        titleLable.set(title: R.string.localizable.feeds_sub_title(), font: UIFont.normalFont_15(), color: Color.flatWhite)
        return titleLable
    }()
    
    lazy var giveUpBtn: UIButton = {
        let giveUpBtn = UIButton(type: .custom)
        giveUpBtn.setAttributdWith(string: R.string.localizable.feeds_give_up(), font: UIFont.normalFont_16(), color: Color.flatWhite, state: .normal)
        giveUpBtn.addTarget(self, action: #selector(giveUpBtnEvent), for: .touchUpInside)
        return giveUpBtn
    }()
    
    lazy var saleBtn: UIButton = {
        let saleBtn = UIButton(type: .custom)
        saleBtn.setAttributdWith(string: R.string.localizable.feeds_sell(), font: UIFont.normalFont_16(), color: Color.flatWhite, state: .normal)
        saleBtn.setBackgroundImage(R.image.large_btn_background(), for: .normal)
        return saleBtn
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubNodes()
        self.addSubviews()
    }
    
    override func addSubNodes() {
        self.view.addSubview(backgroundImageView)
        self.backgroundImageView.image = R.image.sale_photo_background()
        self.backgroundImageView.frame = UIScreen.main.bounds
    }
    
    override func addSubviews() {
        self.view.addSubview(titleLable)
        self.view.addSubview(subTitleLable)
        
        self.view.addSubview(saleBtn)
        self.view.addSubview(giveUpBtn)
        
        self.titleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(macro.topHeight * 1.2)
        }
        
        self.subTitleLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLable.snp.bottom).offset(margin)
        }
        
        self.giveUpBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(margin * 2)
            make.right.equalToSuperview().offset(-margin * 2)
            make.height.equalTo(saleBtnHeight)
            make.bottom.equalToSuperview().offset(-margin * 4.0)
        }
        
        self.saleBtn.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(giveUpBtn)
            make.bottom.equalTo(giveUpBtn.snp.top).offset(-margin)
        }
    }
    
    override func initialHidden() -> Bool {
        return true
    }
    
    @objc private func giveUpBtnEvent() {
        self.navigationController?.popViewController(animated: true)
    }
}
