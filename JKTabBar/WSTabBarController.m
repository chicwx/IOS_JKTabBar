//
//  WSTabBarController.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "WSTabBarController.h"

#import "WSHomeViewController.h"
#import "WSSearchViewController.h"
#import "WSVideoViewController.h"
#import "WSNewsViewController.h"
#import "WSMeViewController.h"
#import "WSNews2ViewController.h"
#import "XHTwitterPaggingViewer.h"

@interface WSTabBarController ()<WSHomeViewControllerDelegate>
{

    NSMutableArray *buttonArray;//按钮数组(实现动画效果)
    
    UIImageView *tabView;//切换图(实现动画效果)
}

@end

@implementation WSTabBarController
@synthesize backgroundImage;
@synthesize tabImage;
@synthesize imageArray;
@synthesize imageHighlightArray;
@synthesize imageWidth;
@synthesize imageHeight;

#pragma  mark - System
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        //默认值
        self.imageWidth = 30;
        self.imageHeight = 30;
        NSLog(@"initWithNibName");
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //去除tabBar的所有控件
    [self removeTabBar];
    
    //自定义tabBar的控件
    [self initTabBar];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View
//显示主界面
- (void)showMainView
{
    //设置navigationBar颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:34.0/255 green:204.0/255 blue:204.0/255 alpha:1.0]];
    //[[UINavigationBar appearance] setTranslucent:NO];
    
    /** navigationBar 字体
     UITextAttributeFont – 字体key
     UITextAttributeTextColor – 文字颜色key
     UITextAttributeTextShadowColor – 文字阴影色key
     UITextAttributeTextShadowOffset – 文字阴影偏移量key
     */
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor],
      NSForegroundColorAttributeName,//字体颜色
      [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0],
      NSFontAttributeName,//字体大小
      nil]];
    
    //home
    WSHomeViewController *homeViewController  = [[WSHomeViewController alloc]init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    homeViewController.wsHomeControllerDelegate = self;
    
    //search
    WSSearchViewController *searchViewController = [[WSSearchViewController alloc]init];
    UINavigationController *searchNavigationController = [[UINavigationController alloc]initWithRootViewController:searchViewController];
    
    //video
    WSVideoViewController *videoViewController = [[WSVideoViewController alloc]init];
    UINavigationController *videoNavigationController = [[UINavigationController alloc]initWithRootViewController:videoViewController];
    
    //news


    
    XHTwitterPaggingViewer *newsPaggingViewer = [[XHTwitterPaggingViewer alloc]init];
    NSMutableArray *viewControllers = [[NSMutableArray alloc]initWithCapacity:2];
    WSNewsViewController *newsViewController = [[WSNewsViewController alloc]init];
    newsViewController.title = @"1";
    WSNews2ViewController *news2ViewController = [[WSNews2ViewController alloc]init];
    news2ViewController.title = @"2";
    [viewControllers addObject:newsViewController];
    [viewControllers addObject:news2ViewController];
    newsPaggingViewer.viewControllers = viewControllers;
    newsPaggingViewer.didChangedPageCompleted = ^(NSInteger cuurentPage, NSString *title) {
        NSLog(@"cuurentPage : %ld on title : %@", (long)cuurentPage, title);
    };
    UINavigationController *newsNavigationController = [[UINavigationController alloc]initWithRootViewController:newsPaggingViewer];
    
    //me
    WSMeViewController *meViewController = [[WSMeViewController alloc]init];
    UINavigationController *meNavigationController = [[UINavigationController alloc]initWithRootViewController:meViewController];
    
    //WSTabBarController *tabBarContoller = [[WSTabBarController alloc]init];
    self.viewControllers = [NSArray arrayWithObjects:homeNavigationController,searchNavigationController,videoNavigationController,newsNavigationController,meNavigationController, nil];
    
    self.imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"g_tabbar_ic_home_nor"],[UIImage imageNamed:@"g_tabbar_ic_search_nor"],[UIImage imageNamed:@"g_tabbar_ic_video_nor"],[UIImage imageNamed:@"g_tabbar_ic_news_nor"],[UIImage imageNamed:@"g_tabbar_ic_me_nor"], nil];
    self.imageHighlightArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"g_tabbar_ic_home_down"],[UIImage imageNamed:@"g_tabbar_ic_search_down"],[UIImage imageNamed:@"g_tabbar_ic_video_down"],[UIImage imageNamed:@"g_tabbar_ic_news_down"],[UIImage imageNamed:@"g_tabbar_ic_me_down"], nil];
    
    self.imageWidth= 35;
    self.imageHeight = 35;
    self.selectedIndex = 0;
    
    
    
}



//去除tabBar的所有控件
-(void) removeTabBar{
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
}


//自定义tabBar的控件
-(void) initTabBar{
    //测试输出
    NSLog(@"viewCount=%ld",(long)self.viewControllers.count);
    NSLog(@"imageCount=%ld",(long)self.imageArray.count);
    NSLog(@"imageS=%ld",(long)self.imageHighlightArray.count);
    
    //切换控件的宽高
    float tabBarWidth = self.tabBar.frame.size.width;
    float tabBarHeight = self.tabBar.frame.size.height;
    
    //视图控制器的数量
    NSInteger viewCount = self.viewControllers.count;
    buttonArray = [NSMutableArray arrayWithCapacity:viewCount];
    //每个切换按钮的宽度
    float btnWidth = tabBarWidth/viewCount;

    //背景图
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tabBarWidth, tabBarHeight)];
    bgView.userInteractionEnabled = YES;
    if (self.backgroundImage) {
        bgView.image = self.backgroundImage;
    }else{
        bgView.backgroundColor = [UIColor colorWithRed:53.0/255 green:57.0/255 blue:66.0/255 alpha:1];
    }
    [self.tabBar addSubview:bgView];
    
    //切换图
    tabView = [[UIImageView alloc] initWithFrame:CGRectMake(self.selectedIndex*btnWidth, 0, btnWidth, tabBarHeight)];
    if (self.tabImage) {
        tabView.image = self.tabImage;
    }else{
        tabView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    }
    //[bgView addSubview:tabView];
    
    //切换按钮
    for (int i=0; i<viewCount; i++) {
        UIImageView *btnImgView = [[UIImageView alloc] init];
        [btnImgView setImage:[imageArray objectAtIndex:i]];
        if (self.imageHighlightArray.count>=i+1) {
            btnImgView.highlightedImage = [imageHighlightArray objectAtIndex:i];
        }
        if (self.selectedIndex==i) {
            btnImgView.highlighted = YES;
        }
        
        
//        btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2, 5, self.imageWidth, self.imageHeight);
//        UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
//        [tabBtn setTag:i];
//        [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [tabBtn addSubview:btnImgView];
//        [bgView addSubview:tabBtn];
        
        if (i==0) {
            btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2, 7, self.imageWidth, self.imageHeight);
            UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
            [tabBtn setTag:i];
            [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [tabBtn addSubview:btnImgView];
            [bgView addSubview:tabBtn];
            [buttonArray addObject:tabBtn];
        }
        
        if (i==1) {
            btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2-10, 7, self.imageWidth, self.imageHeight);
            UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
            [tabBtn setTag:i];
            [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [tabBtn addSubview:btnImgView];
            [bgView addSubview:tabBtn];
            [buttonArray addObject:tabBtn];
        }
        
        if (i==2) {
            btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2-27.5, -12, self.imageWidth+55, self.imageHeight+32);
            UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
            [tabBtn setTag:i];
            [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [tabBtn addSubview:btnImgView];
            [bgView addSubview:tabBtn];
            [buttonArray addObject:tabBtn];
        }
        
        if (i==3) {
            btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2+10, 7, self.imageWidth, self.imageHeight);
            UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
            [tabBtn setTag:i];
            [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [tabBtn addSubview:btnImgView];
            [bgView addSubview:tabBtn];
            [buttonArray addObject:tabBtn];
        }
        
        if (i==4) {
            btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2, 7, self.imageWidth, self.imageHeight);
            UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
            [tabBtn setTag:i];
            [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [tabBtn addSubview:btnImgView];
            [bgView addSubview:tabBtn];
            [buttonArray addObject:tabBtn];
        }
        
        
        
    }
}

//点击按钮事件
-(void) buttonClickAction:(UIButton*)sender
{
    NSInteger buttonIndex = sender.tag;
    //如果重复点击，则不切换
    if (self.selectedIndex == buttonIndex) {
        return;
    }
    //切换高亮状态
    for (UIButton *button in buttonArray) {
        if (button.tag != buttonIndex) {
            ((UIImageView*)button.subviews[0]).highlighted = NO;
        }
    }
    ((UIImageView*)sender.subviews[0]).highlighted = YES;
    //按钮动画
    //[self buttonAnimate:sender];
    //切换图动画
    //[self tabAnimate:sender];
    
    self.selectedIndex = buttonIndex;
}

//按钮动画
-(void) buttonAnimate:(UIButton *)button{
    //获取到按钮里的图片视图
    UIView *view = button.subviews[0];
    [UIView animateWithDuration:0.1 animations:^{
        //先缩小
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
    }completion:^(BOOL finished){//do other thing
        [UIView animateWithDuration:0.2 animations:
         ^(void){
             //再放大
             view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
             
         } completion:^(BOOL finished){//do other thing
             [UIView animateWithDuration:0.1 animations:
              ^(void){
                  //恢复到原样
                  view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                  
              } completion:^(BOOL finished){//do other thing
              }];
         }];
    }];
}

//切换图动画
-(void) tabAnimate:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = tabView.frame;
        frame.origin.x = button.frame.origin.x;
        tabView.frame = frame;
    }];
}

#pragma mark - WSHomeViewControllerDelegate
//退出tabBar
- (void)quitTabBarController
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
