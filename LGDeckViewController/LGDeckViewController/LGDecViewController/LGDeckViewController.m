//
//  LGDeckViewController.m
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.--QQ 410296011
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//  自定义侧滑（防QQ）

#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height

#import "LGDeckViewController.h"

@interface LGDeckViewController ()<UIGestureRecognizerDelegate>

@end


@implementation LGDeckViewController
@synthesize _sideslipTapGes;
@synthesize _speedf;
@synthesize _pan;
@synthesize _leftVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 @brief 初始化侧滑控制器
 @param leftVC 右视图控制器
 mainVC 中间视图控制器
 @result instancetype 初始化生成的对象
 */
- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC
{
    if(self = [super init]){
        _speedf = vSpeedFloat;
        
        _leftVC = leftVC;
        _mainVC = mainVC;
        
        //滑动手势
        self._pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        [_mainVC.view addGestureRecognizer:self._pan];
        
        [self._pan setCancelsTouchesInView:YES];
        self._pan.delegate = self;
        
        _leftVC.view.hidden = YES;
        
        [self.view addSubview:_leftVC.view];
        
        [self.view addSubview:_mainVC.view];
        
        self._closed = YES;
        
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _leftVC.view.hidden = NO;
}

#pragma mark - 滑动手势

//滑动手势
- (void) handlePan: (UIPanGestureRecognizer *)rec{
    
    
    CGPoint point = [rec translationInView:self.view];
    _scalef = (point.x * _speedf + _scalef);
    
    BOOL _needMoveWithTap = YES;  //是否还需要跟随手指移动
    if (((_mainVC.view.x <= 0) && (_scalef <= 0)) || ((_mainVC.view.x >= (kScreenWidth - vOpenLeftDeckMainPageDistance)) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        _needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右边滑动
    if (_needMoveWithTap && (rec.view.frame.origin.x >= 0) && (rec.view.frame.origin.x <= (kScreenWidth - vOpenLeftDeckMainPageDistance)))
    {
        //向右滑动
        rec.view.center = CGPointMake(rec.view.center.x + point.x * _speedf,rec.view.center.y);
        rec.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1 - (1 - vOpenLeftDeckMainPageZoom) * (rec.view.frame.origin.x / (kScreenWidth - vOpenLeftDeckMainPageDistance)), 1 - (1 - vOpenLeftDeckMainPageZoom) * (rec.view.frame.origin.x / (kScreenWidth - vOpenLeftDeckMainPageDistance)));
        [rec setTranslation:CGPointMake(0, 0) inView:self.view];
        
    }
    else
    {
        //超出范围，
        //        NSLog(@"超出滑动范围,需修正");
        if (_mainVC.view.x < 0)
        {
            [self closeLeftView];
            _scalef = 0;
        }
        else if (_mainVC.view.x > (kScreenWidth - vOpenLeftDeckMainPageDistance))
        {
            [self openLeftView];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self._closed)
            {
                [self openLeftView];
            }
            else
            {
                [self closeLeftView];
            }
        }
        else
        {
            if (self._closed)
            {
                [self closeLeftView];
            }
            else
            {
                [self openLeftView];
            }
        }
        _scalef = 0;
    }
}

- (void) fixDeck
{
    if ((_mainVC.view.x == 0) || (_mainVC.view.x == (kScreenWidth - vOpenLeftDeckMainPageDistance)))
    {
        return;
    }
    if (_mainVC.view.x < (kScreenWidth - vOpenLeftDeckMainPageDistance) / 2.0)
    {
        [self closeLeftView];
        _scalef = 0;
    }
    else if (_mainVC.view.x > (kScreenWidth - vOpenLeftDeckMainPageDistance) / 2.0)
    {
        [self openLeftView];
        _scalef = 0;
    }
}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if ((!self._closed) && (tap.state == UIGestureRecognizerStateEnded))
    {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        self._closed = YES;
        [UIView commitAnimations];
        _scalef = 0;
        [self removeSingleTap];
    }
    
}

#pragma mark - 修改视图位置
/**
 @brief 关闭左视图
 */
- (void)closeLeftView
{
    [UIView beginAnimations:nil context:nil];
    _mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    _mainVC.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    self._closed = YES;
    [UIView commitAnimations];
    [self removeSingleTap];
}

/**
 @brief 打开左视图
 */
- (void)openLeftView;
{
    [UIView beginAnimations:nil context:nil];
    _mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,vOpenLeftDeckMainPageZoom,vOpenLeftDeckMainPageZoom);
    _mainVC.view.center = vOpenLeftDeckMainPageCenter;
    self._closed = NO;
    [UIView commitAnimations];
    [self disableTapButton];
}

#pragma mark - 行为收敛控制
- (void)disableTapButton
{
    for (UIButton *tempButton in [_mainVC.view subviews])
    {
        [tempButton setUserInteractionEnabled:NO];
    }
    //单击
    if (!_sideslipTapGes)
    {
        //单击手势
        _sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [_sideslipTapGes setNumberOfTapsRequired:1];
        
        [_mainVC.view addGestureRecognizer:_sideslipTapGes];
        _sideslipTapGes.cancelsTouchesInView = YES;  //点击事件盖住其它响应事件,但盖不住Button;
    }
    [_mainVC.view addGestureRecognizer:_sideslipTapGes];
    NSLog(@"锁定行为收敛");
}


//关闭行为收敛
- (void) removeSingleTap
{
    for (UIButton *tempButton in [_mainVC.view  subviews])
    {
        [tempButton setUserInteractionEnabled:YES];
    }
    [_mainVC.view removeGestureRecognizer:_sideslipTapGes];
    _sideslipTapGes = nil;
    NSLog(@"关闭行为收敛");
}

/**
 *  设置滑动开关是否开启
 *
 *  @param enabled YES:支持滑动手势，NO:不支持滑动手势
 */
- (void)setPanEnabled: (BOOL) enabled
{
    [self._pan setEnabled:enabled];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if(touch.view.tag == vDeckCanNotPanViewTag)
    {
        NSLog(@"不响应侧滑");
        return NO;
    }
    else
    {
        NSLog(@"响应侧滑");
        return YES;
    }
}

@end
