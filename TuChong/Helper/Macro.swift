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
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// topHeight
    var topHeight: CGFloat {
        return navigationBarHeight + statusBarHeight
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

let macro = Macro()
