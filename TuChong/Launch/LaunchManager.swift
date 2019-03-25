//  LaunchManager.swift
//  TuChong
//
//  Created by SummerHF on 2019/3/18.
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

import UIKit
import HandyJSON
import SwiftyJSON
import AsyncDisplayKit
import SnapKit

// MARK: - 启动广告模型

struct LaunchAd_App: HandyJSON {
    var id: String = ""
    var title: String = ""
    var author_name: String = ""
    var image_url: String = ""
    var tuchong_url: String = ""
    /// image_name
    var image_name: String? {
        if let url = URL(string: image_url), url.lastPathComponent.count != 0 {
            return url.lastPathComponent
        }
        return nil
    }
    /// 本地存储路径--String
    var localPathStr: String? {
        guard let image = image_name else { return nil }
        return LaunchManager.filePath + "/\(image)"
    }
    
    /// 本地存储路径--URL
    var localPathUrl: URL? {
        guard let pathStr = localPathStr else { return nil }
        return URL(fileURLWithPath: pathStr)
    }
    
    /// 广告是否已经存在
    var isExist: Bool {
        guard let path = localPathStr  else { return false }
        return FileManager.default.fileExists(atPath: path, isDirectory: nil)
    }
}

struct LaunchAd: HandyJSON {
    var app: [LaunchAd_App] = []
}

// MARK: - 启动广告协议
/// 关联类型
protocol LaunchMangerProtocol {
    associatedtype T
    func read() -> T
    func update() -> T
    func show() -> T
    /// 创建本地存储目录
    func createDocument() -> Bool
    /// 存储路径
    static var filePath: String { get }
}

// MARK: - 管理类

class LaunchManager: LaunchMangerProtocol {
    
    typealias T = LaunchManager

    /// 目录路径
    static var filePath: String {
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        return filePath + "/LaunchAdvertisement"
    }
    
    /// 偏好存储名称
    static var keyPathName = "LaunchAdvertisementData"
    
    /// use this singleton to manager l
    static let manager = LaunchManager()
    let group = DispatchGroup()
    let queue = DispatchQueue(label: "launch_advertisement_queue", qos: DispatchQoS.background)
    let session = URLSession(configuration: URLSessionConfiguration.default)
    var admodels: LaunchAd?
    
    /// 广告启动页
    lazy var launchAdvertisementView: LaunchAdView = {
        let view = LaunchAdView()
        return view
    }()
    
    /// 创建目录
    @discardableResult
    func createDocument() -> Bool {
        /// init UnsafeMutablePointer
        /// ObjCBool(false)
        var pointer: ObjCBool = false
        let created = FileManager.default.fileExists(atPath: LaunchManager.filePath, isDirectory: &pointer)
        if !(created && pointer.boolValue) {
            do {
                try FileManager.default.createDirectory(at: URL(fileURLWithPath: LaunchManager.filePath), withIntermediateDirectories: true, attributes: nil)
            } catch {
                logger.log("create Launch document failure")
            }
        }
        return true
    }
    
    /// 每次启动读取本地已缓存的资源
    @discardableResult
    func read() -> LaunchManager {
        if let localData = UserDefaults.standard.value(forKey: LaunchManager.keyPathName) as? [String: Any] {
            logger.log("read success, wait to handle")
            self.admodels = LaunchAd.deserialize(from: localData)
        }
        return self
    }
    
    /// 每次启动更新启动图相关数据
    @discardableResult
    func update() -> LaunchManager {
        Network.request(target: .launch_ad, success: { (response) in
            guard let data = LaunchAd.deserialize(from: response) else { return }
            self.queue.async {
                for ad in data.app {
                    if !ad.isExist {
                        self.group.enter()
                        let task = self.session.dataTask(with: URL(string: ad.image_url)!, completionHandler: { (response, _, error) in
                            /// download success, save to local
                            if let result = response, let path = ad.localPathStr, error == nil {
                                do {
                                    try result.write(to: URL(fileURLWithPath: path), options: Data.WritingOptions.atomic)
                                    logger.log("write data to path success")
                                } catch {
                                    logger.log("write data to path failed")
                                }
                            } else {
                                logger.log("download failed")
                            }
                        })
                        task.resume()
                        self.group.leave()
                    } else {
                        logger.log("has download")
                    }
                }
            }
            /// save data to local
            self.group.notify(queue: self.queue, execute: {
                UserDefaults.standard.setValue(response, forKey: LaunchManager.keyPathName)
            })
        }, error: { _ in
        }) { _ in
        }
        return self
    }
    
    /// 显示已经缓存的数据
    @discardableResult
    func show() -> LaunchManager {
        /// 创建目录
        self.createDocument()
        /// 读取本地
        self.read()
        /// 展示
        if let model = self.admodels {
            var temp: [LaunchAd_App] = []
            /// 此处防止有些图片未下载成功
            for data in model.app where data.isExist {
                    temp.append(data)
            }
            /// 随机展示一张
            let random = Int.randomIntValue(upper: temp.count)
            let willShow = model.app[random]
            self.showAdvertisementWith(model: willShow)
        }
        /// 更新
        self.update()
        return self
    }
    
    func showAdvertisementWith(model: LaunchAd_App) {
        guard let window = macro.keyWindow else { return }
        window.addSubnode(launchAdvertisementView)
        launchAdvertisementView.update(model: model)
    }
}

// MARK: - LaunchAdView(启动广告视图)

class LaunchAdView: ASDisplayNode {
    
    lazy var imageNode: ASImageNode = {
        let image = ASImageNode()
        return image
    }()
    
    lazy var skipBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitle("跳过", for: .normal)
        btn.backgroundColor = UIColor.gray
        return btn
    }()
    
    lazy var titleLable: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.white
        return title
    }()
    
    lazy var authorNameLable: UILabel = {
        let nameLable = UILabel()
        nameLable.textColor = UIColor.white
        nameLable.font = UIFont.systemFont(ofSize: 8)
        return nameLable
    }()
    
    lazy var separator: UILabel = {
        let separator = UILabel()
        separator.backgroundColor = UIColor.white
        return separator
    }()
    
    override init() {
        super.init()
        self.frame = UIScreen.main.bounds
        self.view.addSubview(imageNode.view)
        self.view.addSubview(authorNameLable)
        self.view.addSubview(separator)
        self.view.addSubview(titleLable)
        self.view.addSubview(skipBtn)
        layoutsubViews()
    }
    
    fileprivate func update(model: LaunchAd_App) {
        guard let data = try? Data(contentsOf: model.localPathUrl!) else { return }
        self.imageNode.image = UIImage(data: data)
        self.authorNameLable.text = model.author_name
        self.titleLable.text = model.title
    }
    
    private func layoutsubViews() {
        imageNode.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        authorNameLable.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        separator.snp.makeConstraints { (make) in
            make.centerX.equalTo(authorNameLable)
            make.bottom.equalTo(authorNameLable.snp.top).offset(-5)
            make.size.equalTo(CGSize(width: 60, height: 0.5))
        }
        titleLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(authorNameLable)
            make.bottom.equalTo(separator.snp.top).offset(-5)
        }
        skipBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 20))
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
    }
}
