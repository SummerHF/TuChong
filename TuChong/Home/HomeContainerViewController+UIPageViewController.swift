//  HomeContainerViewController+.swift
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

extension HomeContainerViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        for (key, vc) in dictionaryForController {
            if vc == viewController, key > 0 {
                if let value = dictionaryForController[key - 1] {
                    return value
                } else {
                    let vc = self.create(subviewControll: key-1)
                    dictionaryForController[key - 1] = vc
                    return vc
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        for (key, vc) in dictionaryForController {
            if vc == viewController, key < navArray.count - 1 {
                if let value = dictionaryForController[key + 1] {
                    return value
                } else {
                    let vc = self.create(subviewControll: key+1)
                    dictionaryForController[key + 1] = vc
                    return vc
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let target = pendingViewControllers.first else { return }
        print(pendingViewControllers)
        for (key, vc) in dictionaryForController where vc == target {
            self.selectedIndex = key
        }
    }
    
    /// using completed to judge index
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed && finished {
            self.navView?.hasSelected(index: self.selectedIndex)
        }
    }
    
    /// create sub viewcontroller according to `Item` type
    public func create(subviewControll withIndex: Int) -> BaseViewControlle {
        let model = navArray[withIndex]
        /// build parameters
        var path: String = ""
        var parameters: [String: Any] = [:]
        let page = 1
        var viewController: BaseViewControlle
        switch model.itemType {
        case .follow:
            print("follow")
            // need to login in
            viewController = FollowViewController(model: navArray[withIndex], index: withIndex)
        case .recommend:
            path = "/2/feed-app"
            parameters = [RequestparameterKey.page: page, RequestparameterKey.type: RequestType.refresh.rawValue]
            viewController = RecommendViewController(model: model, index: withIndex, path: path, parameters: parameters)
        case .tag:
            path = "/discover/\(model.entry.id)/category"
            parameters = [RequestparameterKey.page: page]
            viewController = CategoryViewController(model: model, index: withIndex, path: path, parameters: parameters)
        case .wallpaper:
            //  /4/wall-paper/app?first_refresh=1&page=1&tag=-3
            path = "/4/wall-paper/app"
            parameters = [RequestparameterKey.first_refresh: true,
                          RequestparameterKey.page: page,
                          RequestparameterKey.tag: model.entry.id]
            viewController = HomeSubViewController(model: navArray[withIndex], index: withIndex)
        case .video_recommend:
            /// /2/video/app/fav?page=1&type=refresh
            /// to do
            /// 首先获取banner
            path = "/2/app-video-nav"
            parameters = [RequestparameterKey.page: page, RequestparameterKey.type: RequestType.refresh.rawValue]
            viewController = RecommendVideoPlayerController(model: model, index: withIndex, path: path)
        case .rn:
            print("rn To do")
        //  https://tuchong.com/rest/sites/1615439,1615432,1615443,1615461,1615437/posts?page=1&count=10
            viewController = HomeSubViewController(model: navArray[withIndex], index: withIndex)
        case .none:
            print("none")
            viewController = HomeSubViewController(model: navArray[withIndex], index: withIndex)
        }
        return viewController
    }
}
