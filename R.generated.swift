//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.file` struct is generated, and contains static references to 4 files.
  struct file {
    /// Resource file `API`.
    static let apI = Rswift.FileResource(bundle: R.hostingBundle, name: "API", pathExtension: "")
    /// Resource file `GenerateResource.sh`.
    static let generateResourceSh = Rswift.FileResource(bundle: R.hostingBundle, name: "GenerateResource", pathExtension: "sh")
    /// Resource file `Reference`.
    static let reference = Rswift.FileResource(bundle: R.hostingBundle, name: "Reference", pathExtension: "")
    /// Resource file `SwiftLintRule`.
    static let swiftLintRule = Rswift.FileResource(bundle: R.hostingBundle, name: "SwiftLintRule", pathExtension: "")
    
    /// `bundle.url(forResource: "API", withExtension: "")`
    static func apI(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.apI
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "GenerateResource", withExtension: "sh")`
    static func generateResourceSh(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.generateResourceSh
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Reference", withExtension: "")`
    static func reference(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.reference
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "SwiftLintRule", withExtension: "")`
    static func swiftLintRule(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.swiftLintRule
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 13 images.
  struct image {
    /// Image `bc_back`.
    static let bc_back = Rswift.ImageResource(bundle: R.hostingBundle, name: "bc_back")
    /// Image `corner_mark`.
    static let corner_mark = Rswift.ImageResource(bundle: R.hostingBundle, name: "corner_mark")
    /// Image `dot`.
    static let dot = Rswift.ImageResource(bundle: R.hostingBundle, name: "dot")
    /// Image `iconNearbyHot_15x15_`.
    static let iconNearbyHot_15x15_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconNearbyHot_15x15_")
    /// Image `lauch_image_icon`.
    static let lauch_image_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "lauch_image_icon")
    /// Image `lecture`.
    static let lecture = Rswift.ImageResource(bundle: R.hostingBundle, name: "lecture")
    /// Image `photography _tutorial`.
    static let photography_tutorial = Rswift.ImageResource(bundle: R.hostingBundle, name: "photography _tutorial")
    /// Image `photography_club`.
    static let photography_club = Rswift.ImageResource(bundle: R.hostingBundle, name: "photography_club")
    /// Image `recommend_ cameraman`.
    static let recommend_Cameraman = Rswift.ImageResource(bundle: R.hostingBundle, name: "recommend_ cameraman")
    /// Image `red_envelopes`.
    static let red_envelopes = Rswift.ImageResource(bundle: R.hostingBundle, name: "red_envelopes")
    /// Image `searchBar_background`.
    static let searchBar_background = Rswift.ImageResource(bundle: R.hostingBundle, name: "searchBar_background")
    /// Image `search_topic`.
    static let search_topic = Rswift.ImageResource(bundle: R.hostingBundle, name: "search_topic")
    /// Image `trophy`.
    static let trophy = Rswift.ImageResource(bundle: R.hostingBundle, name: "trophy")
    
    /// `UIImage(named: "bc_back", bundle: ..., traitCollection: ...)`
    static func bc_back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.bc_back, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "corner_mark", bundle: ..., traitCollection: ...)`
    static func corner_mark(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.corner_mark, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dot", bundle: ..., traitCollection: ...)`
    static func dot(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dot, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "iconNearbyHot_15x15_", bundle: ..., traitCollection: ...)`
    static func iconNearbyHot_15x15_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconNearbyHot_15x15_, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "lauch_image_icon", bundle: ..., traitCollection: ...)`
    static func lauch_image_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.lauch_image_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "lecture", bundle: ..., traitCollection: ...)`
    static func lecture(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.lecture, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "photography _tutorial", bundle: ..., traitCollection: ...)`
    static func photography_tutorial(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photography_tutorial, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "photography_club", bundle: ..., traitCollection: ...)`
    static func photography_club(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photography_club, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "recommend_ cameraman", bundle: ..., traitCollection: ...)`
    static func recommend_Cameraman(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.recommend_Cameraman, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "red_envelopes", bundle: ..., traitCollection: ...)`
    static func red_envelopes(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.red_envelopes, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "searchBar_background", bundle: ..., traitCollection: ...)`
    static func searchBar_background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.searchBar_background, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "search_topic", bundle: ..., traitCollection: ...)`
    static func search_topic(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.search_topic, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "trophy", bundle: ..., traitCollection: ...)`
    static func trophy(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.trophy, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 11 localization keys.
    struct localizable {
      /// zh-Hans translation: 作品, 教程, 摄影师，搜搜看
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let search_bar_placeholder = Rswift.StringResource(key: "search_bar_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 取消
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let cancel_button_title = Rswift.StringResource(key: "cancel_button_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 推荐摄影师
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let recommended_photographer = Rswift.StringResource(key: "recommended_photographer", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 摄影小组
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let photography_club = Rswift.StringResource(key: "photography_club", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 摄影教程
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let photography_tutorial = Rswift.StringResource(key: "photography_tutorial", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 标签
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let tag = Rswift.StringResource(key: "tag", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let tab_bar_activity_title = Rswift.StringResource(key: "tab_bar_activity_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 热门活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let hot_activity_title = Rswift.StringResource(key: "hot_activity_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 红包活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let red_packet_activity = Rswift.StringResource(key: "red_packet_activity", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 胶囊演讲
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let lecture = Rswift.StringResource(key: "lecture", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 首页
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let tab_bar_home_title = Rswift.StringResource(key: "tab_bar_home_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      
      /// zh-Hans translation: 作品, 教程, 摄影师，搜搜看
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func search_bar_placeholder(_: Void = ()) -> String {
        return NSLocalizedString("search_bar_placeholder", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 取消
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func cancel_button_title(_: Void = ()) -> String {
        return NSLocalizedString("cancel_button_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 推荐摄影师
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func recommended_photographer(_: Void = ()) -> String {
        return NSLocalizedString("recommended_photographer", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 摄影小组
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func photography_club(_: Void = ()) -> String {
        return NSLocalizedString("photography_club", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 摄影教程
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func photography_tutorial(_: Void = ()) -> String {
        return NSLocalizedString("photography_tutorial", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 标签
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func tag(_: Void = ()) -> String {
        return NSLocalizedString("tag", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func tab_bar_activity_title(_: Void = ()) -> String {
        return NSLocalizedString("tab_bar_activity_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 热门活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func hot_activity_title(_: Void = ()) -> String {
        return NSLocalizedString("hot_activity_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 红包活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func red_packet_activity(_: Void = ()) -> String {
        return NSLocalizedString("red_packet_activity", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 胶囊演讲
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func lecture(_: Void = ()) -> String {
        return NSLocalizedString("lecture", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 首页
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func tab_bar_home_title(_: Void = ()) -> String {
        return NSLocalizedString("tab_bar_home_title", bundle: R.hostingBundle, comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "lauch_image_icon", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'lauch_image_icon' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
