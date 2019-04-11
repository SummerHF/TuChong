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
                    let vc = self.create(subviewControll: key)
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
                    let vc = self.create(subviewControll: key)
                    dictionaryForController[key + 1] = vc
                    return vc
                }
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let target = pendingViewControllers.first else { return }
        for (key, vc) in dictionaryForController where vc == target {
            self.selectedIndex = key
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            self.navView?.hasSelected(index: self.selectedIndex)
        }
    }
    
    public func create(subviewControll withIndex: Int) -> BaseViewControlle {
        let controller = HomeSubViewController(model: navArray[withIndex], index: withIndex)
        return controller
    }
}
