# LGDeckViewController
仿QQ的侧滑（右侧缩放），较流畅，有Demo。左侧页的缩放动画需自行添加。


1.初始化：
<!--1.1 右侧主页面及导航-->
MainPageViewController *mainPageVC = [MainPageViewController shareMainPageVC];
self._mainNavigationController = [[UINavigationController alloc] initWithRootViewController: mainPageVC];

<!--1.2 左侧主页面        -->
LeftSortsViewController *aLeftSortVC = [[LeftSortsViewController alloc] init];

<!--1.3初始化-->
self._mainDeckViewController = [[LGDeckViewController alloc] initWithLeftView:aLeftSortVC andMainView:self._mainNavigationController];
<!--可选择性设置成rootview-->
self.window.rootViewController = self._mainDeckViewController;

2.控制按钮：
<!--2.1 初始化按钮-->
self.navigationItem.leftBarButtonItem = [self createLeftBarButtonItem:@"" target:self selector:@selector(openOrCloseLeftList) ImageName:@"menu.png"];

<!--2.2 控制测滑窗打开或关闭-->
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

个人博客: http://jamiepoet.github.io

欢迎大家关注回复或加我QQ讨论交流, QQ:2726786161，一起学习，探讨。
