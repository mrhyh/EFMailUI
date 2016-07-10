//
//  MallHeader.h
//  EF_MallDemo
//
//  Created by MH on 16/6/13.
//  Copyright © 2016年 MH. All rights reserved.
//

#ifndef MallHeader_h
#define MallHeader_h
/*
 ********UI**********
 */
//图片
#define Img(a) [UIImage imageNamed:a]
//尺寸
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define IS_IPHONE4 SCREEN_HEIGHT==480
#define IS_IPHONE5 SCREEN_HEIGHT==568
#define IS_IPHONE6 SCREEN_HEIGHT==667
#define IS_IPHONE6PS SCREEN_HEIGHT==736

#define SCREEN_SCALE_RATE SCREEN_WIDTH/320
#define SCREEN_W_RATE SCREEN_WIDTH/320
#define SCREEN_H_RATE ((IS_IPHONE4)?(1.0):(SCREEN_HEIGHT/568))
#define SCREEN_HALFSCALE_RATE (1.0 + ((int)((int)(SCREEN_SCALE_RATE*100)%100)/200.0))

//颜色
#define DefaultMainColor [UIColor colorWithRed:89.f/255.f green:156.f/255.f blue:233.f/255.f alpha:1.0]
#define DefaultBodyColor [UIColor colorWithRed:3.f/255.f green:3.f/255.f blue:3.f/255.f alpha:1.0]
#define DefaultAbstractColor [UIColor colorWithRed:143.f/255.f green:142.f/255.f blue:148.f/255.f alpha:1.0]
#define DefaultDisableColor [UIColor colorWithRed:199.f/255.f green:199.f/255.f blue:205.f/255.f alpha:1.0]
#define DefaultGreenColor [UIColor colorWithRed:88.f/255.f green:232.f/255.f blue:165.f/255.f alpha:1.0]
#define DefaultRedColor [UIColor colorWithRed:209.f/255.f green:46.f/255.f blue:53.f/255.f alpha:1.0]
#define UIColor_Hex(string) [UIColor colorWithHexString:string]
#define RGBColor(R,G,B) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1]
#define RGBAColor(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#define BCWhiteColor(W,A) [UIColor colorWithWhite:W/255.0f alpha:A]

//字体
#define Font(f) [UIFont systemFontOfSize:(f*SCREEN_HALFSCALE_RATE)]
#define BoldFont(f) [UIFont boldSystemFontOfSize:(f*SCREEN_HALFSCALE_RATE)]
#define DefRate  (1 + ((int)((int)(SCREEN_SCALE_RATE*100)%100)/200.0))
#define DefFont(f) [UIFont systemFontOfSize:f*DefRate]

/*
 ********其他**********
 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//日志输出
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)

//系统版本号
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
#endif


//网络配置
//#define ServerAddressURL @"http://192.168.0.130:8081/stock_king"
//#define ServerAddressURL @"http://192.168.0.127:8082/stock_king"
//#define ServerAddressURL @"http://192.168.0.122:9999/stock_king"
#define ServerAddressURL @"http://139.196.232.188/stock_king"

//程序初次进入
#define APPFirstLoadIn @"APPFirstLoadIn"
#define APPFirstLoadInMain @"APPFirstLoadInMain"

//系统版本号
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion floatValue]

//各种SDK ID
//新浪微博
#define WBSDK_Sina_AppKey @"3410191821"
#define WBSDK_Sina_AppSecret @"4f718d28c38e1ff454a053bdaa76d267"
#define WBSDK_Sina_RedirectURI @"http://www.ekuaifan.com"

//umeng统计
#define UMENG_APPKEY @"573a7b0c67e58ea604003b68"

//微信
#define WEIXIN_APPID @"wxf20564d58b4d757c"
#define WEIXIN_AppSecret @"e4c8b62584761ab965ccfbdf8b411da6"
#define WEIXIN_Info @"WEIXIN_Info"
//QQ登录
#define TENCENT_APPID @"1104473839"
#define TENCENT_APPKEY @"n7Llfw0tfvsi2MrO"

//支付宝
#define ALiPay_Info @"ALiPay_Info"

//融云
#define RONGYUE_APPKEY @"tdrvipksr8cn5"

//APP Store 账号
#define APPStoreID 1088520991;
#define APPURL @"https://itunes.apple.com/us/app/mileby/id1088520991?l=zh&ls=1&mt=8"

//极光推送相关
#define NCAPPDeviceTokenKey @"0f740f58dd1a0c287ce2a127"

#endif /* MallHeader_h */
