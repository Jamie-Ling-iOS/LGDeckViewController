//
//  AppDelegate.h
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LGDeckViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LGDeckViewController *_mainDeckViewController;          //侧滑控制器

@property (strong, nonatomic) UINavigationController *_mainNavigationController;        //主页面主流程控制器


@end

