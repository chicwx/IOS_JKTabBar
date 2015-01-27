//
//  LMCTabBarController.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/5.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "LMCTabBarController.h"
#import "Item1ViewController.h"
#import "Item2ViewController.h"
#import "Item3ViewController.h"
#import "Item4ViewController.h"
#import "Item5ViewController.h"

@interface LMCTabBarController ()
{
    NSMutableArray *buttonArray;//按钮数组(实现动画效果)
    
    UIImageView *tabView;//切换图(实现动画效果)
    
}

@end

@implementation LMCTabBarController
@synthesize backgroundImage;
@synthesize tabImage;
@synthesize imageArray;
@synthesize imageHighlightArray;
@synthesize imageWidth;
@synthesize imageHeight;

#pragma mark - System
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //默认值
        self.imageWidth = 30;
        self.imageHeight = 30;
        NSLog(@"initWithNibName");
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    //去除tabBar的所有控件
    [self removeTabBar];
    //自定义tabBar的控件
    [self initTabBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //item1
    Item1ViewController *item1ViewController = [[Item1ViewController alloc]init];
    UINavigationController *item1NavigationController = [[UINavigationController alloc]initWithRootViewController:item1ViewController];
    
    //item2
    Item2ViewController *item2ViewController = [[Item2ViewController alloc]init];
    UINavigationController *item2NavigationController = [[UINavigationController alloc]initWithRootViewController:item2ViewController];
    
    //item3
    Item3ViewController *item3ViewController = [[Item3ViewController alloc]init];
    UINavigationController *item3NavigationController = [[UINavigationController alloc]initWithRootViewController:item3ViewController];
    
    //item4
    Item4ViewController *item4ViewController = [[Item4ViewController alloc]init];
    UINavigationController *item4NavigationController = [[UINavigationController alloc]initWithRootViewController:item4ViewController];
    
    //item5
    Item5ViewController *item5ViewController = [[Item5ViewController alloc]init];
    UINavigationController *item5NavigationController = [[UINavigationController alloc]initWithRootViewController:item5ViewController];
    
    //tabbar
    self.viewControllers = @[item1NavigationController,item2NavigationController,item3NavigationController,item4NavigationController,item5NavigationController];
    
    self.imageArray = @[[UIImage imageNamed:@"icon_pin"],[UIImage imageNamed:@"icon_user"],[UIImage imageNamed:@"Settings"],[UIImage imageNamed:@"Tools_00028"],[UIImage imageNamed:@"drop"]];
    self.imageHighlightArray = @[[UIImage imageNamed:@"icon_pin"],[UIImage imageNamed:@"icon_user"],[UIImage imageNamed:@"Settings"],[UIImage imageNamed:@"Tools_00028"],[UIImage imageNamed:@"drop"]];
    
    self.selectedIndex = 0;
    self.imageHeight = 35;
    self.imageWidth = 35;
    
}

#pragma mark - View
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
        bgView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
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
        btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2, 5, self.imageWidth, self.imageHeight);
        UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
        [tabBtn setTag:i];
        [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [tabBtn addSubview:btnImgView];
        [bgView addSubview:tabBtn];
        [buttonArray addObject:tabBtn];
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
    [self buttonAnimate:sender];
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


@end
