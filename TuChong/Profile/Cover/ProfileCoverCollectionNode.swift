//  ProfileCoverCollectionNode.swift
//  TuChong
//
//  Created by SummerHF on 2019/5/6.
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

class ProfileCoverCollectionNode: ASCollectionNode {
    
    let site_id: String
    var covers: [String] = []
    let flowLayout: UICollectionViewFlowLayout
    
    /// infinite scroll
    private let section: Int = 50
    private var cover_index: Int = 0
    private var section_index: Int = 0

    lazy var rangeTuningParameters: ASRangeTuningParameters = {
        var rangeTuningParameters = ASRangeTuningParameters()
        rangeTuningParameters.leadingBufferScreenfuls = 1.0
        rangeTuningParameters.trailingBufferScreenfuls = 0.5
        return rangeTuningParameters
    }()
    
    init(site_id: String) {
        self.site_id = site_id
        self.flowLayout = UICollectionViewFlowLayout()
        self.flowLayout.scrollDirection = .horizontal
        self.flowLayout.minimumLineSpacing = 0.0
        super.init(frame: .zero, collectionViewLayout: flowLayout, layoutFacilitator: nil)
        self.backgroundColor = Color.backGroundColor
        self.dataSource = self
        self.delegate = self
        self.showsHorizontalScrollIndicator = false
        self.view.isScrollEnabled = false
        self.setTuningParameters(rangeTuningParameters, for: .display)
    }
    
    func configureWith(covers: [String]) {
        self.covers = covers
        self.reloadData()
    }
    
    /// `Timer` trigger animation
    func triggerAnimation() {
        cover_index += 1
        if cover_index < self.covers.count {
            self.scrollToItem(at: IndexPath(item: cover_index, section: section_index), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            cover_index = 0
            section_index += 1
            if section_index >= self.section {
                section_index = 0
                self.scrollToItem(at: IndexPath(item: cover_index, section: section_index), at: UICollectionView.ScrollPosition.left, animated: false)
            } else {
                self.scrollToItem(at: IndexPath(item: cover_index, section: section_index), at: UICollectionView.ScrollPosition.left, animated: true)
            }
        }
    }
}

extension ProfileCoverCollectionNode: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return self.section
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return self.covers.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return ProfileCoverCollectionNodeCell(with: self.covers[indexPath.row], index: indexPath.row)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = UIScreen.main.bounds.size
        return ASSizeRange(min: size, max: size)
    }
}
