//  ProfileViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/4/11.
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

enum ProfileBarStyle {
    case light
    case dark
}

class ProfileViewController: BaseViewControlle {
    
    private let site_id: String
    private var profile: ProfileModel = ProfileModel()
    private var barStyle: ProfileBarStyle?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let barStyle = self.barStyle {
            return barStyle == .light ? .lightContent : .default
        } else if self.isRequestFinished {
            return .lightContent
        } else {
            return .default
        }
    }
    
    /// profile cover node
    lazy var profileCoverNode: ProfileCoverNode = {
        let profileCoverNode = ProfileCoverNode(site_id: site_id)
        return profileCoverNode
    }()
    
    /// profile scrollView
    lazy var profileScrollView: ProfileScrollView = {
        let profileScrollView = ProfileScrollView()
        profileScrollView.profileScrollViewDelegate = self
        return profileScrollView
    }()
    
    /// profile nav node
    lazy var navBar: ProfileNavBar = {
        let navBar = ProfileNavBar()
        navBar.delegate = self
        return navBar
    }()
    
    /// Create `Profile` with site_id
    init(with site_id: String) {
        self.site_id = site_id
        super.init()
        /// disable automatically adjust scrollView insets
        self.automaticallyAdjustsScrollViewInsets = false
        if #available(iOS 11.0, *) {
            self.profileScrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.addSubNodes()
       self.loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.profileCoverNode.shutdownTimerImmediate()
    }
    
    override func addSubNodes() {
        self.node.addSubnode(profileCoverNode)
        self.view.addSubview(profileScrollView)
        self.view.addSubview(navBar)
    }
    
    override func loadData() {
        Network.request(target: TuChong.profile_site(site_id: site_id), success: { (responseData) in
            guard let model = ProfileModel.deserialize(from: responseData) else { return }
            self.profile = model
            self.configuration()
        }, error: { (_) in
            
        }) { (_) in
            
        }
    }
    
    override func configuration() {
        self.isRequestFinished = true
        self.setNeedsStatusBarAppearanceUpdate()
//        self.profile.cover.images = [
//            "https://photo.tuchong.com/5651394/f/110495284.jpg",
//            "https://photo.tuchong.com/5651394/f/519964289.jpg",
//            "https://photo.tuchong.com/5651394/f/92735104.jpg",
//            "https://photo.tuchong.com/5651394/f/631899724.jpg",
//            "https://photo.tuchong.com/5651394/f/382273140.jpg",
//            "https://photo.tuchong.com/5651394/f/262801012.jpg",
//            "https://photo.tuchong.com/5651394/f/326043254.jpg",
//            "https://photo.tuchong.com/5651394/f/227542664.jpg",
//            "https://photo.tuchong.com/5651394/f/443156084.jpg"
//        ]
        self.profile.cover.images = []
        self.profileCoverNode.configureWith(profile: self.profile)
        self.profileScrollView.configureWith(profile: self.profile)
        self.navBar.configure(with: self.profile)
    }
    
    override func initialHidden() -> Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.profileCoverNode.frame = self.node.bounds
        self.navBar.frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: macro.topHeight)
        self.profileScrollView.frame = CGRect(x: 0, y: 0, width: macro.screenWidth, height: macro.screenHeight)
    }
}

// MARK: - ProfileScrollViewProtocol

extension ProfileViewController: ProfileScrollViewProtocol {
    
    func scrollViewNeedToChange(_ barStyle: ProfileBarStyle) {
        self.barStyle = barStyle
        self.setNeedsStatusBarAppearanceUpdate()
        self.navBar.configureWith(statusBarStyle: barStyle)
    }
}

extension ProfileViewController: ProfileNavBarProtocol {
    
    func navBarBackEvent(bar: ProfileNavBar) {
        self.navigationController?.popViewController(animated: true)
    }
}
