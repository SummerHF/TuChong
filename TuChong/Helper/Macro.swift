//
//  Macro.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/20.
//  Copyright © 2019 Summer. All rights reserved.
//

import UIKit
import DeviceKit

// MARK: - Macro

struct Macro {
    
    /// Loading view's key
    static var loadingKey: String = "loadingKey"
    
    /// keyWindow of application
    var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    /// keyWindow's rootViewController
    var rootViewController: UIViewController? {
        return keyWindow?.rootViewController
    }
    
    /// current selected navigation controller
    var currentSelectedNavgationController: BaseNavigationController? {
        return (rootViewController as? BaseTabBarController)?.selectedViewController as? BaseNavigationController
    }
    
    /// tabBar
    var tabBar: UITabBar? {
        return (keyWindow?.rootViewController as? BaseTabBarController)?.tabBar
    }
    
    /// tabBarHeight
    var tabBarHeight: CGFloat {
        guard let bar = tabBar else { return 0}
        return bar.frame.size.height
    }
    
    /// navigationBarHeight
    var navigationBarHeight: CGFloat {
        return 44
    }
    
    /// statusBarHeight
    var statusBarHeight: CGFloat {
        /// iphoneX, XR, XSMAX, XS 44, other height is 20
        let device = Device()
        /// support simulator
        if device.isSimulator {
            switch device {
            case .simulator(.iPhoneX), .simulator(.iPhoneXs), .simulator(.iPhoneXr), .simulator(.iPhoneXsMax):
                return 44
            default:
                return 20
            }
        } else {
            switch device {
            case .iPhoneX, .iPhoneXs, .iPhoneXr, .iPhoneXsMax:
                return 44
            default:
                return 20
            }
        }
    }
    
    var bottomMargin: CGFloat {
        return -5
    }
    
    /// searchBar size
    var searchBarSize: CGSize {
        return CGSize(width: macro.screenWidth - 20, height: 32)
    }
    
    /// topHeight
    var topHeight: CGFloat {
        return navigationBarHeight + statusBarHeight
    }
    
    /// shadow height
    var shadowHeight: CGFloat {
        return 180
    }
    
    /// homenavHeight
    var homenavHeight: CGFloat {
        return 40
    }
    
    /// videonavHeight
    var videonavHeight: CGFloat {
        return 40
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var homeContainerY: CGFloat {
        return topHeight + homenavHeight
    }
    
    var homeContainerHeight: CGFloat {
        return screenHeight - homeContainerY
    }
    
    /// 侧划返回的触发距离
    var sideslipDistance: CGFloat {
        return 40
    }
    
    /// 隐藏tabbar
    func setTabBarHidden(hidden: Bool) {
        tabBar?.isHidden = hidden
    }
    
    /// constant about
    let zero = 0
    
    /// 首页更多图片拼接基本URL
    let homeNavMoreItemsBasePictureUrlString = "https://photo.tuchong.com/"
    
    /// current system `language`
    let language: String = NSLocale.preferredLanguages.first ?? "en-CN"
    
    /// video nav `Y`
    var videoNavTop: CGFloat {
        return 0.0
    }
    
    /// 用户未设置图像时, 其占位图, 原图为gif
    var staticAvatorPlaceHolderLf6URL: String {
        return "http://lf6-tccdn-tos.pstatp.com/obj/tuchong-avatar/l_u_0"
    }
    
    var staticAvatorPlaceHolderSf6URL: String {
        return "http://sf6-tccdn-tos.pstatp.com/obj/tuchong-avatar/l_u_0"
    }
    
    /// 用户未设置图像时, 其占位图, 原图为gif, 替换为jpeg
    var staticReplaceAvatorPlaceHolderURL: String {
        return "https://ws4.sinaimg.cn/large/006tNc79ly1g2i48swxpjj301c01c0es.jpg"
    }

    /// 用户未设置图像时, 其占位图, 原图为gif, 替换为jpeg
    var staticReplaceAvatorPlaceHolderForGroupURL: String {
        return "https://ws3.sinaimg.cn/large/006tNc79ly1g2rdd80bqsj30230230mi.jpg"
    }
}

let macro = Macro()

// MARK: - Request parameters

/// using those key for request
struct RequestparameterKey {
    static let page = "page"
    static let tag = "tag"
    static let first_refresh = "first_refresh"
    static let type = "type"
    static let count = "count"
    static let sort_by = "sort_by"
    static let hotest = 0
    static let newest = 1
    static let refresh = "refresh"
    static let loadmore = "loadmore"
    static let default_count = 20
    static let category = "category"
    static let all = "all"
    static let recommend = "recommend"
    static let follow = "follow"
}
