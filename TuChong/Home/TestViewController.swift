//
//  TestViewController.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/21.
//  Copyright © 2019 Summer. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TestViewController: BaseViewControlle {
    
    lazy var usernameNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "hannahmbanana", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        node.truncationMode = NSLineBreakMode.byTruncatingTail
        node.maximumNumberOfLines = 1
        return node
    }()
    
    lazy var postLocationNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "Sunset Beach, San Fransisco, CA", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        node.truncationMode = NSLineBreakMode.byTruncatingTail
        node.maximumNumberOfLines = 1
        return node
    }()
    
    lazy var posttimeNode: ASTextNode = {
        let node = ASTextNode()
        node.attributedText = NSAttributedString(string: "30m", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        node.truncationMode = NSLineBreakMode.byTruncatingTail
        node.maximumNumberOfLines = 1
        return node
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.node.layoutSpecBlock = { node, size in
            let nameLocationStack = ASStackLayoutSpec.vertical()
            nameLocationStack.style.flexGrow = 1.0
            nameLocationStack.style.flexGrow = 1.0
            nameLocationStack.children = [self.usernameNode, self.postLocationNode]
            
            let headerStack = ASStackLayoutSpec.init(direction: ASStackLayoutDirection.horizontal, spacing: 40, justifyContent: ASStackLayoutJustifyContent.start, alignItems: ASStackLayoutAlignItems.center, children: [nameLocationStack, self.posttimeNode])
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), child: headerStack)
        }
    }
}
