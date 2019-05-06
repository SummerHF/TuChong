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

class ProfileViewController: BaseViewControlle {
    
    private let site_id: String
    private var profile: ProfileModel = ProfileModel()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// cover node
    lazy var coverCollectionNode: ProfileCoverCollectionNode = {
        let coverCollectionNode = ProfileCoverCollectionNode(site_id: site_id)
        return coverCollectionNode
    }()
    
    /// Create `Profile` with site_id
    init(with site_id: String) {
        self.site_id = site_id
        super.init()
        self.automaticallyAdjustsScrollViewInsets = false
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
        self.coverCollectionNode.shutdownTimerImmediate()
    }
    
    override func addSubNodes() {
        self.node.addSubnode(coverCollectionNode)
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
        self.coverCollectionNode.configureWith(cover: self.profile.cover)
    }
    
    override func initialHidden() -> Bool {
        return true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.coverCollectionNode.frame = self.node.bounds
    }
}