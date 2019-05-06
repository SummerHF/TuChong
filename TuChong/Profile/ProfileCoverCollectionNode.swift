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
    var cover: Profile_Cover_Model = Profile_Cover_Model()
    var cover_index: Int = 0
    let flowLayout: UICollectionViewFlowLayout
    
    var timer: Timer?
    
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
    }
    
    func configureWith(cover: Profile_Cover_Model) {
        self.cover = cover
        self.cover.images = [
        "https://photo.tuchong.com/5651394/f/110495284.jpg",
        "https://photo.tuchong.com/5651394/f/519964289.jpg",
        "https://photo.tuchong.com/5651394/f/92735104.jpg",
        "https://photo.tuchong.com/5651394/f/631899724.jpg",
        "https://photo.tuchong.com/5651394/f/382273140.jpg",
        "https://photo.tuchong.com/5651394/f/262801012.jpg",
        "https://photo.tuchong.com/5651394/f/326043254.jpg",
        "https://photo.tuchong.com/5651394/f/227542664.jpg",
        "https://photo.tuchong.com/5651394/f/443156084.jpg"
        ]
        self.reloadData()
    }
    
    /// Change cover
    @objc private func timerEvent() {
        /// if imageCount less than `1`, shut down `Timer`
        guard self.cover.images.count > 1 else { return }
        cover_index += 1
        if cover_index < self.cover.images.count {
            self.scrollToItem(at: IndexPath(row: cover_index, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            cover_index = 0
            self.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
        }
    }
    
    override func didEnterVisibleState() {
        super.didEnterVisibleState()
        /// Create Timer
        let timer = Timer(timeInterval: 2.0, target: self, selector: #selector(timerEvent), userInfo: nil, repeats: true)
        /// add timer to runloop
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }
    
    /// Close Timer
    func shutdownTimerImmediate() {
        self.timer?.invalidate()
        self.timer = nil
    }
}

extension ProfileCoverCollectionNode: ASCollectionDataSource, ASCollectionDelegate, ASCollectionDelegateFlowLayout {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return self.cover.images.count

    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return ProfileCoverCollectionNodeCell(with: self.cover.images[indexPath.row], index: indexPath.row)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = UIScreen.main.bounds.size
        return ASSizeRange(min: size, max: size)
    }
}
