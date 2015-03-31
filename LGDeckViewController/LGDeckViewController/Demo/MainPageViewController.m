//
//  MainPageViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//  主页

#define vBackBarButtonItemName  @"backArrow.png"    //导航条返回默认图片名

#import "MainPageViewController.h"
#import "AppDelegate.h"


@interface MainPageViewController ()

@end

static MainPageViewController * staticMainPageVC = nil;
@implementation MainPageViewController


/*
 单例：主页面对象
 */
+ (MainPageViewController *)shareMainPageVC;
{
    @synchronized(self)
    {
        if(staticMainPageVC == nil)
        {
            staticMainPageVC=[[self alloc] init];
        }
    }
    return staticMainPageVC;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"向右侧滑";
    self.view.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    
//    if (DECK_MODE)
    {
        self.navigationItem.leftBarButtonItem = [self createLeftBarButtonItem:@"" target:self selector:@selector(openOrCloseLeftList) ImageName:@"menu.png"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---------------- User-choice -----------------
//测滑窗打开或关闭
- (void) openOrCloseLeftList
{
    //先想法得到主代理 ，也可以封装起来
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate._mainDeckViewController._closed)
    {
        [tempAppDelegate._mainDeckViewController openLeftView];
    }
    else
    {
        [tempAppDelegate._mainDeckViewController closeLeftView];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ---------------- 其实辅助方法-------------------------
/**
 *  创建导航条左按钮
 *
 *  @param title     按钮标题,当为@""空时，选择默认图片vBackBarButtonItemName
 *  @param obj       按钮作用对象（响应方法的对象）
 *  @param selector  按钮响应的方法
 *  @param imageName 按钮图片名称
 *
 *  @return 左按钮对象
 */
- (UIBarButtonItem *)createLeftBarButtonItem:(NSString *)title target:(id)obj selector:(SEL)selector ImageName:(NSString*)imageName
{
    UIImage *image;
    if (!imageName || [imageName isEqualToString:@""] || imageName.length == 0)
    {
        image = [UIImage imageNamed:vBackBarButtonItemName];
    }
    else
    {
        image = [UIImage imageNamed:imageName];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    
    if ([title isEqualToString:@"返回"]) {
        title = @"    ";
    }
    if ([title length] > 0) {
        [button setTitle:title forState:UIControlStateNormal];
    }else{
        
    }
    //ios8.0 此方法过时，用下面的方法替代---
    //    CGSize titleSize = [title sizeWithAttributes:[UIFont systemFontOfSize:18]];
    
    UIFont *fnt = [UIFont systemFontOfSize:18];
    // 根据字体得到NSString的尺寸
    CGSize titleSize = [title sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil]];
    //----------
    
    if (titleSize.width < 44) {
        titleSize.width = 44;
    }
    button.frame = CGRectMake(0, 0, titleSize.width, 44);
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:130.0/255 green:56.0/255 blue:23.0/255 alpha:1] forState:UIControlStateHighlighted];
    [button addTarget:obj action:selector forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    //    CGPoint tempCenter = button.center;
    //    //图片尺寸不对时，用默认参数进行缩放
    //    [button setFrame:CGRectMake(0, 0, image.size.width / kAllImageZoomSize, image.size.height / kAllImageZoomSize)];
    //    [button setCenter:tempCenter];
    
//    //iOS7之前的版本需要手动设置和屏幕边缘的间距
//    if (kIOSVersions < 7.0) {
//        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    }else{
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
//    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}


@end
