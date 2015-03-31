//
//  LGDeckViewController.h
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.----QQ 410296011
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
////  自定义侧滑（防QQ）


#define vOpenLeftDeckMainPageDistance   50   //打开左侧窗时，中视图(右视图)露出的宽度
#define vOpenLeftDeckMainPageZoom   0.8  //打开左侧窗时，中视图(右视图）缩放比例
#define vOpenLeftDeckMainPageCenter  CGPointMake(kScreenWidth + kScreenWidth * vOpenLeftDeckMainPageZoom / 2.0 - vOpenLeftDeckMainPageDistance, kScreenHeight / 2)  //打开左侧窗时，中视图中心点

#define vCouldChangeDeckStateDistance  (kScreenWidth - vOpenLeftDeckMainPageDistance) / 2.0 - 40 //滑动距离大于此数时，状态改变（关--》开，或者开--》关）
#define vSpeedFloat   0.9    //滑动速度

#define vDeckCanNotPanViewTag    987654   //  不响应此侧滑的View的tag

#import <UIKit/UIKit.h>
#import "UIView_extra.h"

@interface LGDeckViewController : UIViewController

{
@private
    UIViewController *_mainVC;
    CGFloat _scalef;  //实时横向位移
}

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (nonatomic, assign) CGFloat _speedf;

//左侧窗
@property (nonatomic, strong) UIViewController *_leftVC;

//点击手势控制器，是否允许点击视图恢复视图位置。默认为yes
@property (nonatomic, strong) UITapGestureRecognizer *_sideslipTapGes;

//滑动手势控制器
@property (nonatomic, strong) UIPanGestureRecognizer *_pan;

//侧滑窗是否关闭(关闭时显示为主页)
@property (nonatomic, assign) BOOL _closed;


/**
 @brief 初始化侧滑控制器
 @param leftVC 右视图控制器
 mainVC 中间视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC;

/**
 @brief 关闭左视图
 */
- (void)closeLeftView;


/**
 @brief 打开左视图
 */
- (void)openLeftView;

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */
- (void)setPanEnabled: (BOOL) enabled;

@end
