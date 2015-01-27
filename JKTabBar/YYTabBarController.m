//
//  YYTabBarController.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/11.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "YYTabBarController.h"
#import "JKTabBarItem.h"
#import "YYHomeViewController.h"
#import "YYShopViewController.h"
#import "YYMeViewController.h"
#import "YYMoreViewController.h"

@interface YYTabBarController ()<YYHomeViewControllerDelegate>

@end

#pragma mark - System
@implementation YYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View
//显示主页面
- (void)showMainView
{
    //设置navigationBar颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:241.0/255 green:2.0/255 blue:99.0/255 alpha:1]];
    //[[UINavigationBar appearance] setTranslucent:NO];
    
    /** navigationBar 字体
     UITextAttributeFont – 字体key
     UITextAttributeTextColor – 文字颜色key
     UITextAttributeTextShadowColor – 文字阴影色key
     UITextAttributeTextShadowOffset – 文字阴影偏移量key
     */
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor],
      NSForegroundColorAttributeName,//字体颜色
      [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0],
      NSFontAttributeName,//字体大小
      nil]];
    
    //改变UITabBar整体颜色
    //[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
    //改变字体的颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:                                                         [NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil]forState:UIControlStateSelected];
    
    //home
    YYHomeViewController *homeViewController = [[YYHomeViewController alloc] init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    //设置标题、图标
    UITabBarItem *homeTabBarItem = [[JKTabBarItem alloc] createTabBarItem:@"首页" normalImage:@"main_tab_deal_off" selectedImage:@"main_tab_deal_on" itemTag:1];
    homeNavigationController.tabBarItem = homeTabBarItem;
    homeViewController.yyHomeViewControllerDelegate = self;
    
    //shop
    YYShopViewController *shopViewController = [[YYShopViewController alloc] init];
    UINavigationController *shopNavigationController = [[UINavigationController alloc] initWithRootViewController:shopViewController];
    //设置标题、图标
    UITabBarItem *shopTabBarItem = [[JKTabBarItem alloc] createTabBarItem:@"商家" normalImage:@"main_tab_shop_off" selectedImage:@"main_tab_shop_on" itemTag:2];
    shopNavigationController.tabBarItem = shopTabBarItem;
    
    
    //me
    YYMeViewController *meViewController = [[YYMeViewController alloc] init];
    UINavigationController *meNavigationController = [[UINavigationController alloc] initWithRootViewController:meViewController];
    //设置标题、图标
    UITabBarItem *meTabBarItem = [[JKTabBarItem alloc] createTabBarItem:@"我的" normalImage:@"main_tab_user_off" selectedImage:@"main_tab_user_on" itemTag:3];
    meNavigationController.tabBarItem = meTabBarItem;
    
    
    //more
    YYMoreViewController *moreViewController = [[YYMoreViewController alloc] init];
    UINavigationController *moreNavigationController = [[UINavigationController alloc] initWithRootViewController:moreViewController];
    //设置标题、图标
    UITabBarItem *moreTabBarItem = [[JKTabBarItem alloc] createTabBarItem:@"更多" normalImage:@"main_tab_more_off" selectedImage:@"main_tab_more_on" itemTag:4];
    moreNavigationController.tabBarItem = moreTabBarItem;
    
    
    //tabbar
    //UITabBarController *tabBarController = [[UITabBarController alloc]init];
    NSArray *tabBarArray = [NSArray arrayWithObjects:homeNavigationController,shopNavigationController,meNavigationController,moreNavigationController, nil];
    self.viewControllers = tabBarArray;

}

#pragma mark - YYHomeViewControllerDelegate
//退出tabBar
- (void)quitTabBarController
{

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
