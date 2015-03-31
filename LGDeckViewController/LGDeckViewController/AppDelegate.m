//
//  AppDelegate.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

//页面通用背景颜色
#define kBackgroundColor [UIColor whiteColor]

#import "AppDelegate.h"
#import "MainPageViewController.h"
#import "LeftSortsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = kBackgroundColor;   //设置通用背景颜色
    [self.window makeKeyAndVisible];
    
    
    //    //版本控制
    //    if (CLIENT_VERSION_MANAGE)
    //    {
    //        //        NSLog(@"发送客户端版本请求信息,进行版本校验及升级提示等相关处理,");
    //    }
    
    //添加主页框架
    [self addMainPageFrameWork];
    
    //    //添加介绍页
    //    [self addIntroView];
    
    //判断是否从其它应用跳转而来
    if (![launchOptions objectForKey:@"UIApplicationLaunchOptionsURLKey"])
    {
        //不是其它应用跳转而来，准备去登录
    }
    
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


#pragma mark ---------------- 添加主页框架-----------------
//添加主页框架
- (void) addMainPageFrameWork
{
    //测滑模块
    //    if (DECK_MODE)
    {
        MainPageViewController *mainPageVC = [MainPageViewController shareMainPageVC];
        self._mainNavigationController = [[UINavigationController alloc] initWithRootViewController: mainPageVC];
        LeftSortsViewController *aLeftSortVC = [[LeftSortsViewController alloc] init];
        self._mainDeckViewController = [[LGDeckViewController alloc] initWithLeftView:aLeftSortVC andMainView:self._mainNavigationController];
        
        self.window.rootViewController = self._mainDeckViewController;
    }
    
    
    
    //    //设置导航条样式
    //    [self setNavStyle];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
}

@end
