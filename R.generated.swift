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
  
  /// This `R.image` struct is generated, and contains static references to 40 images.
  struct image {
    /// Image `activity_selcted`.
    static let activity_selcted = Rswift.ImageResource(bundle: R.hostingBundle, name: "activity_selcted")
    /// Image `activity_white`.
    static let activity_white = Rswift.ImageResource(bundle: R.hostingBundle, name: "activity_white")
    /// Image `activity`.
    static let activity = Rswift.ImageResource(bundle: R.hostingBundle, name: "activity")
    /// Image `bc_back`.
    static let bc_back = Rswift.ImageResource(bundle: R.hostingBundle, name: "bc_back")
    /// Image `collect`.
    static let collect = Rswift.ImageResource(bundle: R.hostingBundle, name: "collect")
    /// Image `comment`.
    static let comment = Rswift.ImageResource(bundle: R.hostingBundle, name: "comment")
    /// Image `corner_mark`.
    static let corner_mark = Rswift.ImageResource(bundle: R.hostingBundle, name: "corner_mark")
    /// Image `dot`.
    static let dot = Rswift.ImageResource(bundle: R.hostingBundle, name: "dot")
    /// Image `film_play_selected`.
    static let film_play_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "film_play_selected")
    /// Image `film_play`.
    static let film_play = Rswift.ImageResource(bundle: R.hostingBundle, name: "film_play")
    /// Image `first`.
    static let first = Rswift.ImageResource(bundle: R.hostingBundle, name: "first")
    /// Image `home_selected`.
    static let home_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "home_selected")
    /// Image `home_white`.
    static let home_white = Rswift.ImageResource(bundle: R.hostingBundle, name: "home_white")
    /// Image `home`.
    static let home = Rswift.ImageResource(bundle: R.hostingBundle, name: "home")
    /// Image `iconNearbyHot_15x15_`.
    static let iconNearbyHot_15x15_ = Rswift.ImageResource(bundle: R.hostingBundle, name: "iconNearbyHot_15x15_")
    /// Image `icon_relation_followed`.
    static let icon_relation_followed = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_relation_followed")
    /// Image `lauch_image_icon`.
    static let lauch_image_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "lauch_image_icon")
    /// Image `lecture`.
    static let lecture = Rswift.ImageResource(bundle: R.hostingBundle, name: "lecture")
    /// Image `like`.
    static let like = Rswift.ImageResource(bundle: R.hostingBundle, name: "like")
    /// Image `online_follow`.
    static let online_follow = Rswift.ImageResource(bundle: R.hostingBundle, name: "online_follow")
    /// Image `photography _tutorial`.
    static let photography_tutorial = Rswift.ImageResource(bundle: R.hostingBundle, name: "photography _tutorial")
    /// Image `photography_club`.
    static let photography_club = Rswift.ImageResource(bundle: R.hostingBundle, name: "photography_club")
    /// Image `plus_white`.
    static let plus_white = Rswift.ImageResource(bundle: R.hostingBundle, name: "plus_white")
    /// Image `plus`.
    static let plus = Rswift.ImageResource(bundle: R.hostingBundle, name: "plus")
    /// Image `recommend_ cameraman`.
    static let recommend_Cameraman = Rswift.ImageResource(bundle: R.hostingBundle, name: "recommend_ cameraman")
    /// Image `red_envelopes`.
    static let red_envelopes = Rswift.ImageResource(bundle: R.hostingBundle, name: "red_envelopes")
    /// Image `right_arrow`.
    static let right_arrow = Rswift.ImageResource(bundle: R.hostingBundle, name: "right_arrow")
    /// Image `searchBar_background`.
    static let searchBar_background = Rswift.ImageResource(bundle: R.hostingBundle, name: "searchBar_background")
    /// Image `search_topic`.
    static let search_topic = Rswift.ImageResource(bundle: R.hostingBundle, name: "search_topic")
    /// Image `second`.
    static let second = Rswift.ImageResource(bundle: R.hostingBundle, name: "second")
    /// Image `share_right`.
    static let share_right = Rswift.ImageResource(bundle: R.hostingBundle, name: "share_right")
    /// Image `share`.
    static let share = Rswift.ImageResource(bundle: R.hostingBundle, name: "share")
    /// Image `third`.
    static let third = Rswift.ImageResource(bundle: R.hostingBundle, name: "third")
    /// Image `triangle_bottom`.
    static let triangle_bottom = Rswift.ImageResource(bundle: R.hostingBundle, name: "triangle_bottom")
    /// Image `trophy`.
    static let trophy = Rswift.ImageResource(bundle: R.hostingBundle, name: "trophy")
    /// Image `use_profile_selected`.
    static let use_profile_selected = Rswift.ImageResource(bundle: R.hostingBundle, name: "use_profile_selected")
    /// Image `user_profile_white`.
    static let user_profile_white = Rswift.ImageResource(bundle: R.hostingBundle, name: "user_profile_white")
    /// Image `user_profile`.
    static let user_profile = Rswift.ImageResource(bundle: R.hostingBundle, name: "user_profile")
    /// Image `verifications_green`.
    static let verifications_green = Rswift.ImageResource(bundle: R.hostingBundle, name: "verifications_green")
    /// Image `verifications`.
    static let verifications = Rswift.ImageResource(bundle: R.hostingBundle, name: "verifications")
    
    /// `UIImage(named: "activity", bundle: ..., traitCollection: ...)`
    static func activity(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.activity, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "activity_selcted", bundle: ..., traitCollection: ...)`
    static func activity_selcted(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.activity_selcted, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "activity_white", bundle: ..., traitCollection: ...)`
    static func activity_white(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.activity_white, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "bc_back", bundle: ..., traitCollection: ...)`
    static func bc_back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.bc_back, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "collect", bundle: ..., traitCollection: ...)`
    static func collect(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.collect, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "comment", bundle: ..., traitCollection: ...)`
    static func comment(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.comment, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "corner_mark", bundle: ..., traitCollection: ...)`
    static func corner_mark(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.corner_mark, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "dot", bundle: ..., traitCollection: ...)`
    static func dot(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.dot, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "film_play", bundle: ..., traitCollection: ...)`
    static func film_play(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.film_play, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "film_play_selected", bundle: ..., traitCollection: ...)`
    static func film_play_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.film_play_selected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "first", bundle: ..., traitCollection: ...)`
    static func first(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.first, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "home", bundle: ..., traitCollection: ...)`
    static func home(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "home_selected", bundle: ..., traitCollection: ...)`
    static func home_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home_selected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "home_white", bundle: ..., traitCollection: ...)`
    static func home_white(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.home_white, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "iconNearbyHot_15x15_", bundle: ..., traitCollection: ...)`
    static func iconNearbyHot_15x15_(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.iconNearbyHot_15x15_, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_relation_followed", bundle: ..., traitCollection: ...)`
    static func icon_relation_followed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_relation_followed, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "lauch_image_icon", bundle: ..., traitCollection: ...)`
    static func lauch_image_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.lauch_image_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "lecture", bundle: ..., traitCollection: ...)`
    static func lecture(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.lecture, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "like", bundle: ..., traitCollection: ...)`
    static func like(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.like, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "online_follow", bundle: ..., traitCollection: ...)`
    static func online_follow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.online_follow, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "photography _tutorial", bundle: ..., traitCollection: ...)`
    static func photography_tutorial(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photography_tutorial, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "photography_club", bundle: ..., traitCollection: ...)`
    static func photography_club(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.photography_club, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "plus", bundle: ..., traitCollection: ...)`
    static func plus(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.plus, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "plus_white", bundle: ..., traitCollection: ...)`
    static func plus_white(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.plus_white, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "recommend_ cameraman", bundle: ..., traitCollection: ...)`
    static func recommend_Cameraman(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.recommend_Cameraman, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "red_envelopes", bundle: ..., traitCollection: ...)`
    static func red_envelopes(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.red_envelopes, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "right_arrow", bundle: ..., traitCollection: ...)`
    static func right_arrow(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.right_arrow, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "searchBar_background", bundle: ..., traitCollection: ...)`
    static func searchBar_background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.searchBar_background, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "search_topic", bundle: ..., traitCollection: ...)`
    static func search_topic(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.search_topic, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "second", bundle: ..., traitCollection: ...)`
    static func second(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.second, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "share", bundle: ..., traitCollection: ...)`
    static func share(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.share, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "share_right", bundle: ..., traitCollection: ...)`
    static func share_right(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.share_right, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "third", bundle: ..., traitCollection: ...)`
    static func third(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.third, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "triangle_bottom", bundle: ..., traitCollection: ...)`
    static func triangle_bottom(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.triangle_bottom, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "trophy", bundle: ..., traitCollection: ...)`
    static func trophy(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.trophy, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "use_profile_selected", bundle: ..., traitCollection: ...)`
    static func use_profile_selected(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.use_profile_selected, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "user_profile", bundle: ..., traitCollection: ...)`
    static func user_profile(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.user_profile, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "user_profile_white", bundle: ..., traitCollection: ...)`
    static func user_profile_white(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.user_profile_white, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "verifications", bundle: ..., traitCollection: ...)`
    static func verifications(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.verifications, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "verifications_green", bundle: ..., traitCollection: ...)`
    static func verifications_green(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.verifications_green, compatibleWith: traitCollection)
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
    /// This `R.string.localizable` struct is generated, and contains static references to 18 localization keys.
    struct localizable {
      /// zh-Hans translation: + 关注
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let focus = Rswift.StringResource(key: "focus", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 作品, 教程, 摄影师，搜搜看
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let search_bar_placeholder = Rswift.StringResource(key: "search_bar_placeholder", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 取消
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let cancel_button_title = Rswift.StringResource(key: "cancel_button_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 张照片
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let pictures = Rswift.StringResource(key: "pictures", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 我的
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let user = Rswift.StringResource(key: "user", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
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
      static let avtivity = Rswift.StringResource(key: "avtivity", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let tab_bar_activity_title = Rswift.StringResource(key: "tab_bar_activity_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 热搜摄影师
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let hot_search_photographer_title = Rswift.StringResource(key: "hot_search_photographer_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 热门活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let hot_activity_title = Rswift.StringResource(key: "hot_activity_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 照片电影
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let film = Rswift.StringResource(key: "film", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
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
      static let home = Rswift.StringResource(key: "home", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      /// zh-Hans translation: 首页
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static let tab_bar_home_title = Rswift.StringResource(key: "tab_bar_home_title", tableName: "Localizable", bundle: R.hostingBundle, locales: ["zh-Hans", "en", "zh-Hant"], comment: nil)
      
      /// zh-Hans translation: + 关注
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func focus(_: Void = ()) -> String {
        return NSLocalizedString("focus", bundle: R.hostingBundle, comment: "")
      }
      
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
      
      /// zh-Hans translation: 张照片
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func pictures(_: Void = ()) -> String {
        return NSLocalizedString("pictures", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 我的
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func user(_: Void = ()) -> String {
        return NSLocalizedString("user", bundle: R.hostingBundle, comment: "")
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
      static func avtivity(_: Void = ()) -> String {
        return NSLocalizedString("avtivity", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func tab_bar_activity_title(_: Void = ()) -> String {
        return NSLocalizedString("tab_bar_activity_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 热搜摄影师
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func hot_search_photographer_title(_: Void = ()) -> String {
        return NSLocalizedString("hot_search_photographer_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 热门活动
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func hot_activity_title(_: Void = ()) -> String {
        return NSLocalizedString("hot_activity_title", bundle: R.hostingBundle, comment: "")
      }
      
      /// zh-Hans translation: 照片电影
      /// 
      /// Locales: zh-Hans, en, zh-Hant
      static func film(_: Void = ()) -> String {
        return NSLocalizedString("film", bundle: R.hostingBundle, comment: "")
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
      static func home(_: Void = ()) -> String {
        return NSLocalizedString("home", bundle: R.hostingBundle, comment: "")
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
