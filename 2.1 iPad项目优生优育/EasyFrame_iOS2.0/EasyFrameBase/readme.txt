//KingYon LTD EasyFrameForIOS V1.0
—Created by Jack 2016-03-03

------------------------------------
参考文档
KingYon LTD 移动规范 iOS V1.0.doc
KingYon LTD iOS开发 Xcode插件安装文档 1.1.pdf

------------------------------------

1、框架组成说明
    APP基础配置
    皮肤主题管理
    启动页管理
    介绍引导页管理
    主体布局管理
    MVVM设计模式

    Tools: 各种工具类、自定义控件（CustomView目录）等等

    Libs:
        Jpush库 - JPush_Lib
        侧滑库 - YRSideViewController


2、公共组件说明
    登录
    注册
    忘记密码
    个人中心
    设置


------------------------------------
依赖CocoaPods库：

#以下内容可以直接复制粘贴到Podfile内使用


target 'Risk' do
# Uncomment this line if you're using Swift or would like to use dynamic frameworks
# use_frameworks!

# Pods for Risk

end
#/***************EF使用的三方库  ************/

platform :ios
#三方登录分享
pod 'libWeChatSDK', '~> 1.5'
pod "WeiboSDK", :git => "https://github.com/sinaweibosdk/weibo_ios_sdk"
pod 'TencentOpenApiSDK'

pod 'MJRefresh', '~> 3.1.0’
pod 'AFNetworking', '~> 2.5.4’
pod 'ELCImagePickerController', '~> 0.2.0'
pod 'YYModel'
pod 'iRate', '~> 1.11.3'
pod 'Reachability',  '~> 3.0.0'
pod 'XHImageViewer', '~> 0.1.2'
pod 'SDWebImage', '~> 3.7.2'
pod 'SVProgressHUD', '~> 2.0.3'
#pod 'HYBUnicodeReadable', '~> 1.1'
pod 'SVWebViewController', '~> 1.0'
#/***************EF使用的三方库  *********end/


pod "HYBLoopScrollView", '~> 3.0.0' #轮播
pod 'ZipArchive', '~> 1.3.0'
pod 'MBProgressHUD', '~> 0.9'
pod 'JSONKit-NoWarning', '~> 1.2'
pod 'MJExtension', '~> 2.5.16'
pod 'FontIcon', '~> 1.0'
pod 'OpenSSL-Universal', '~> 1.0.1.18'
pod 'AlipaySDK-2.0'
pod 'JPush'
pod 'RETableViewManager'
pod 'UIScrollView+PullBig'
pod 'UMengAnalytics-NO-IDFA'

#platform :ios, '7.0'
pod 'FDFullscreenPopGesture', '1.1'
pod 'IQKeyboardManager', '~> 3.3.6'
pod 'FXBlurView', '~> 1.6.4'
pod 'SFHFKeychainUtils', '~> 0.0.1'
pod 'SDAutoLayout', '~> 1.52'
pod 'NJKWebViewProgress'

------------------------------------