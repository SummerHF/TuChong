<p align="center">
  <img height="300" src="https://ws4.sinaimg.cn/large/006tNc79ly1g32x2lab55j30p00p0acb.jpg" />
</p>

# 仿"图虫"应用

  该项目采用[Texture](https://github.com/TextureGroup/Texture)异步渲染框架构建, 网络层使用[Moya](https://github.com/Moya/Moya)构建的仿**图虫**高性能应用，主要是为了练手`Texture`框架而创建. 高性能是所有开发人员都应该力求达到的目标, 而借助`Texture`框架我们很容易就能实现这一目的. 尽管`Texture`中的`Layout`与`UIKit`很不一样, 但是我觉得很值得去学习.
  
## 实现功能预览(部分)

因gif较大，所以加载时间比较长....

<p align="center">
  <img src="Resource/gifhome_448x960_56s.gif" />
</p>

## 项目进展

* 已完成(部分)
    * 项目整体架构搭建完毕
    * 首页动态显示标签功能完成, 未使用传统的`UIScrollView`包裹控制器方式, 而是使用`UIPageViewController`, 性能导向.
    * 活动页构建完毕
    * 个人主页构建完毕(图虫的个人主页逻辑非常复杂，目前仅完成大部分功能，仍待完善)
    * 等
    * 支持全球化
    * 启动页支持随机播放广告页
    
* 待完成(主要)
    * 评论模块
    * 视频播放模块
    * 图片浏览模块
    * 搜索模块
    * 等

## 参考

* [Texture Layout Specs布局](http://texturegroup.org/docs/resources.html)
* [字体, 颜色，本地化](https://medium.com/swift-india/the-clean-way-of-managing-assets-fonts-colors-string-literals-in-ios-xcode-project-1e06dcacf208)
* [WkWebView相关](https://www.jianshu.com/p/bace03adb798)
