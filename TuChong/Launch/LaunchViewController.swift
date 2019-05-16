//  LaunchViewController.swift
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

// MARK: - LaunchAdView(启动广告视图)

class LaunchAdView: ASDisplayNode {
    
    weak var launchViewController: LaunchViewController?
    
    private var timer: Timer?
    private var count: Int = 0
    private var maximumTime: Int = 3
    
    lazy var imageNode: ASImageNode = {
        let image = ASImageNode()
        return image
    }()
    
    lazy var skipBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitle("跳过", for: .normal)
        btn.backgroundColor = RGBA(R: 31, G: 32, B: 41, A: 0.3)
        btn.addTarget(self, action: #selector(dismissLaunchAdview), for: .touchUpInside)
        return btn
    }()
    
    lazy var titleLable: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.white
        return title
    }()
    
    lazy var authorNameLable: UILabel = {
        let nameLable = UILabel()
        nameLable.textColor = UIColor.white
        nameLable.font = UIFont.systemFont(ofSize: 8)
        return nameLable
    }()
    
    lazy var separator: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = UIColor.white
        return separator
    }()
    
    override init() {
        super.init()
        self.view.addSubview(imageNode.view)
        self.view.addSubview(authorNameLable)
        self.view.addSubview(separator)
        self.view.addSubview(titleLable)
        self.view.addSubview(skipBtn)
        layoutsubViews()
    }
    
    fileprivate func update(model: LaunchAd_App) {
        guard let data = try? Data(contentsOf: model.localPathUrl!) else { return }
        self.imageNode.image = UIImage(data: data)
        self.authorNameLable.text = model.author_name
        self.titleLable.text = model.title
        /// 隐藏分割线 如果没有名字和标题的话
        if self.titleLable.text != "" && self.authorNameLable.text != "" {
            self.separator.isHidden = false
        } else {
            self.separator.isHidden = true
        }
        /// set timer
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        self.timer = timer
    }
    
    private func layoutsubViews() {
        imageNode.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        authorNameLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        separator.snp.makeConstraints { (make) in
            make.centerX.equalTo(authorNameLable)
            make.bottom.equalTo(authorNameLable.snp.top).offset(-5)
            make.height.equalTo(0.5)
            make.width.greaterThanOrEqualTo(titleLable.snp.width)
        }
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(authorNameLable)
            make.bottom.equalTo(separator.snp.top).offset(-5)
        }
        skipBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    @objc private func timerEvent() {
        if count >= maximumTime {
            self.dismissLaunchAdview()
        }
        /// 超过5s 自动消失
        count += 1
    }
    
    @objc private func shutDownTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc private func dismissLaunchAdview() {
        self.shutDownTimer()
        UIView.animate(withDuration: 0.2, animations: {
            self.launchViewController?.view.alpha = 0.0
        }) { (_) in
            self.launchViewController?.dismiss(animated: false, completion: {
                macro.setTabBarHidden(hidden: false)
            })
        }
    }
}

// MARK: - LaunchViewController
/// 广告视图

class LaunchViewController: UIViewController {
    
    var launchModel: LaunchAd_App

    /// 广告页
    lazy var launchAdvertisementView: LaunchAdView = {
        let view = LaunchAdView()
        view.launchViewController = self
        return view
    }()

    override var prefersStatusBarHidden: Bool {
        return true
    }

    /// 快速的初始化方法
    init(with model: LaunchAd_App) {
        self.launchModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(launchAdvertisementView.view)
        launchAdvertisementView.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        launchAdvertisementView.update(model: launchModel)
    }
}
