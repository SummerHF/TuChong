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
    
    private let backgroundImageNode = ASImageNode()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubNodes()
    }
    
    override func addSubNodes() {
        self.node.addSubnode(backgroundImageNode)
        self.backgroundImageNode.image = R.image.sale_photo_background()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.backgroundImageNode.frame = self.view.bounds
    }
    
    override func initialHidden() -> Bool {
        return true
    }
}
