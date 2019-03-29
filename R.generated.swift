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
  
  /// This `R.image` struct is generated, and contains static references to 7 images.
  struct image {
    /// Image `bc_back`.
    static let bc_back = Rswift.ImageResource(bundle: R.hostingBundle, name: "bc_back")
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
    
    /// `UIImage(named: "bc_back", bundle: ..., traitCollection: ...)`
    static func bc_back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.bc_back, compatibleWith: traitCollection)
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
    /// This `R.string.localizable` struct is generated, and contains static references to 4 localization keys.
    struct localizable {
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
      /// zh-Hans translation: 首页
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let tab_bar_home_title = Rswift.StringResource(key: "tab_bar_home_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      
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