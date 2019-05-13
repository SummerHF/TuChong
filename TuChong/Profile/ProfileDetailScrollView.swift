//  ProfileDetailScrollView.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/10.
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

// MARK: - ProfileDetailScrollViewProtocol

protocol ProfileDetailScrollViewProtocol: class {
    func scrollView(view: ProfileDetailScrollView, scrollTo index: Int)
}

// MARK: - ProfileDetailScrollView

class ProfileDetailScrollView: UIScrollView {
    
    weak var detailScrollViewDelegate: ProfileDetailScrollViewProtocol?
    
    private var site_id: String = ""
    private let itemCount: CGFloat = 3.0
    private let worksCollectionNode: ProfileCollectionNode = ProfileCollectionNode(type: .work)
    private let likesCollectionNode: ProfileCollectionNode = ProfileCollectionNode(type: .like)
    private let eventsTableNode: ProfileEventsTableNode = ProfileEventsTableNode(type: .activity)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isPagingEnabled = true
        self.bounces = false
        self.showsHorizontalScrollIndicator = false
        self.setPropertys()
    }
    
    private func setPropertys() {
        self.delegate = self
        self.addSubnode(worksCollectionNode)
        self.addSubnode(likesCollectionNode)
        self.addSubnode(eventsTableNode)
    }
    
    private func updateFrames() {
        self.worksCollectionNode.frame = CGRect(x: getXWith(type: worksCollectionNode.type), y: 0, width: self.width, height: self.height)
        self.likesCollectionNode.frame = CGRect(x: getXWith(type: likesCollectionNode.type), y: 0, width: self.width, height: self.height)
        self.eventsTableNode.frame = CGRect(x: getXWith(type: eventsTableNode.type), y: 0, width: self.width, height: self.height)
        self.contentSize = CGSize(width: self.width * itemCount, height: self.height)
        
        self.worksCollectionNode.backgroundColor = Color.lineGray
        self.likesCollectionNode.backgroundColor = Color.orangerColor
        self.eventsTableNode.backgroundColor = Color.lightGray
    }
    
    private func getXWith(type: ProfileDetailType) -> CGFloat {
        return CGFloat(type.rawValue) * self.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrames()
    }
    
    func scrollTo(index: Int) {
        let offset = CGPoint(x: self.width * CGFloat(index), y: 0)
        self.setContentOffset(offset, animated: false)
    }
    
    /// set site_id
    func configureWith(site_id: String) {
        self.site_id = site_id
        self.worksCollectionNode.configureWith(site_id: site_id)
        self.likesCollectionNode.configureWith(site_id: site_id)
        self.eventsTableNode.configureWith(site_id: site_id)
    }
}

// MARK: - UIScrollViewDelegate

extension ProfileDetailScrollView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffSetX = self.contentOffset.x
        let index = contentOffSetX / self.width
        if index >= 0 && index <= itemCount - 1.0 {
            self.detailScrollViewDelegate?.scrollView(view: self, scrollTo: Int(index))
        }
    }
}
