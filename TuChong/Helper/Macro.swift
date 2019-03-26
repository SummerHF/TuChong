//
//  Macro.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/20.
//  Copyright © 2019 Summer. All rights reserved.
//

import UIKit
import DeviceKit

struct Macro {
    
    /// keyWindow of application
    var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    /// keyWindow's rootViewController
    var rootViewController: UIViewController? {
        return keyWindow?.rootViewController
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
        switch device {
        case .iPhoneX, .iPhoneXs, .iPhoneXr, .iPhoneXsMax:
            return 44
        default:
            return 20
        }
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// topHeight
    var topHeight: CGFloat {
        return navigationBarHeight + statusBarHeight
    }
    
    /// homenavHeight
    var homenavHeight: CGFloat {
        return 40
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    /// 侧划返回的触发距离
    var sideslipDistance: CGFloat {
        return 40
    }
}

let macro = Macro()
