//
//  AppDelegate.m
//  EF_MallDemo
//
//  Created by MH on 16/6/13.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "AppDelegate.h"
#import "EFMallVC.h"
#import "EFBaseNavigationController.h"
#import "WeiboSDK.h"
#import "WXApi.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    EFMallVC *vc = [[EFMallVC alloc] init];
    EFBaseNavigationController * nav = [[EFBaseNavigationController alloc]initWithRootViewController:vc];
    [self.window setRootViewController:nav];
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WBSDK_Sina_AppKey];
    [WXApi registerApp:WEIXIN_APPID withDescription:@"EF商城"];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//============================================================
//支付流程实现
//============================================================
- (void)sendPay
{
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:WEIXIN_Info];
    NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [dic objectForKey:@"appid"];
    req.partnerId           = [dic objectForKey:@"partnerid"];
    req.prepayId            = [dic objectForKey:@"prepayid"];
    req.nonceStr            = [dic objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dic objectForKey:@"packages"];
    req.sign                = [dic objectForKey:@"sign"];
    [WXApi sendReq:req];
    
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString *urlStr = [url absoluteString];
    if([urlStr containsString:WEIXIN_APPID]){
        return [WXApi handleOpenURL:url delegate:self];
    }
//    else if([urlStr containsString:@"safepay"]){
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"resultDic = %@", resultDic);
//            [[NSNotificationCenter defaultCenter]postNotificationName:@"PaySuccessNotification" object:nil];
//        }];
//    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSString *urlStr = [url absoluteString];
    if (CurrentSystemVersion < 8) {
        if([self myContainsString:WEIXIN_APPID base:urlStr]){
            return [WXApi handleOpenURL:url delegate:self];
        }
//        else if([self myContainsString:@"safepay" base:urlStr]){
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"resultDic = %@", resultDic);
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"PaySuccessNotification" object:nil];
//            }];
//        }
        
    }else{
        if([urlStr containsString:WEIXIN_APPID]){
            return [WXApi handleOpenURL:url delegate:self];
        }
//        else if([urlStr containsString:@"safepay"]){
//            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//                NSLog(@"resultDic = %@", resultDic);
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"PaySuccessNotification" object:nil];
//            }];
//        }
    }
    
    return YES;
}


- (BOOL)myContainsString:(NSString*)other base:(NSString *)base{
    NSRange range = [base rangeOfString:other];
    return range.length != 0;
}


-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter]postNotificationName:@"PaySuccessNotification" object:nil];
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"retcodeNotification" object:nil];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}


#pragma mark- Jpush Start
//- (void)registerRemoteNotification:(NSDictionary *)launchOptions
//{
//    
//    BOOL isPushClose = [[[NSUserDefaults standardUserDefaults] valueForKey:@"IsPushClose"] boolValue]; //用户不接受推送
//    if (!isPushClose)
//    {
//        // Required
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//            //categories
//            [JPUSHService
//             registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                 UIUserNotificationTypeSound |
//                                                 UIUserNotificationTypeAlert)
//             categories:nil];
//        } else {
//            //categories nil
//            [JPUSHService
//             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                 UIRemoteNotificationTypeSound |
//                                                 UIRemoteNotificationTypeAlert)
//#else
//             //categories nil
//             categories:nil];
//            [JPUSHService
//             registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                 UIRemoteNotificationTypeSound |
//                                                 UIRemoteNotificationTypeAlert)
//#endif
//             // Required
//             categories:nil];
//        }
//        [JPUSHService setupWithOption:launchOptions appKey:NCAPPDeviceTokenKey channel:@"appstore" apsForProduction:NO];
//    }
//    else{
//        [[UIApplication sharedApplication ] unregisterForRemoteNotifications];
//    }
//}


//iOS8 推送
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}


#pragma mark - application notification
//- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    [JPUSHService registerDeviceToken:deviceToken];
//}
//
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
//    NSLog(@"userInfo = %@", userInfo);
//    
//    [QFPushManager handlerPushNotification:userInfo];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    [JPUSHService resetBadge];
//    [JPUSHService handleRemoteNotification:userInfo];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    NSLog(@"userInfo = %@", userInfo);
//    
//    [QFPushManager handlerPushNotification:userInfo];
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    [JPUSHService resetBadge];
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}


@end
