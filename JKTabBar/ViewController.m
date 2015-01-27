//
//  ViewController.m
//  JKTabBar
//
//  Created by dg11185ios on 14/11/20.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "ViewController.h"

//yaoyaotabbar
#import "YYTabBarController.h"

//zaltabbar
#import "ZALTabBarController.h"

//weibotabbar
#import "WBTabBarController.h"

//weishitabbar
#import "WSTabBarController.h"

//jingdongtabbar
#import "JDTabBarController.h"

//swiftTabbar
#import "JKTabBar-Swift.h"

//lmctabbar
#import "LMCTabBarController.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - System
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //显示主界面
    [self showMainView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view
//显示主界面
- (void)showMainView
{
    //背景
    self.view.backgroundColor = [UIColor orangeColor];
    
    //zal框架
    UIButton *zalButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 100, self.view.frame.size.width/3, 30)];
    zalButton.backgroundColor = [UIColor greenColor];
    [zalButton setTitle:@"ZALTabBar" forState:UIControlStateNormal];
    [zalButton addTarget:self action:@selector(showZALTabBarFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zalButton];
    
    //yy框架
    UIButton *yyButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 150, self.view.frame.size.width/3, 30)];
    yyButton.backgroundColor = [UIColor greenColor];
    [yyButton setTitle:@"YYTabBar" forState:UIControlStateNormal];
    [yyButton addTarget:self action:@selector(showYaoyaoTabBarFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yyButton];
    
    //wb框架
    UIButton *ybButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 200, self.view.frame.size.width/3, 30)];
    ybButton.backgroundColor = [UIColor greenColor];
    [ybButton setTitle:@"WBTabBar" forState:UIControlStateNormal];
    [ybButton addTarget:self action:@selector(showWeiBoTabBarFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ybButton];
    
    //ws框架
    UIButton *wsButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 250, self.view.frame.size.width/3, 30)];
    wsButton.backgroundColor = [UIColor greenColor];
    [wsButton setTitle:@"WSTabBar" forState:UIControlStateNormal];
    [wsButton addTarget:self action:@selector(showWeiShiTabBarFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wsButton];
    
    //jd框架
    UIButton *jdButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 300, self.view.frame.size.width/3, 30)];
    jdButton.backgroundColor = [UIColor greenColor];
    [jdButton setTitle:@"JDTabBar" forState:UIControlStateNormal];
    [jdButton addTarget:self action:@selector(showJDTabBarFrame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jdButton];
    
    //swift框架
    UIButton *swiftButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 350, self.view.frame.size.width/3, 30)];
    swiftButton.backgroundColor = [UIColor greenColor];
    [swiftButton setTitle:@"SwiftTabBar" forState:UIControlStateNormal];
    [swiftButton addTarget:self action:@selector(showSwiftTabBarFrame) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:swiftButton];
    
    //swift框架
    UIButton *lmcButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 400, self.view.frame.size.width/3, 30)];
    lmcButton.backgroundColor = [UIColor greenColor];
    [lmcButton setTitle:@"LMCTabBar" forState:UIControlStateNormal];
    [lmcButton addTarget:self action:@selector(showLMCTabBarFrame) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:lmcButton];

}

//显示摇摇框架
- (void)showYaoyaoTabBarFrame
{
    YYTabBarController *yyTabBarController = [[YYTabBarController alloc]init];
    [self presentViewController:yyTabBarController animated:YES completion:nil];
}

//显示微博框架
- (void)showWeiBoTabBarFrame
{
    WBTabBarController *wBTabBarController = [[WBTabBarController alloc]init];
    [self presentViewController:wBTabBarController animated:YES
                     completion:nil];
}

//显示微视框架
- (void)showWeiShiTabBarFrame
{
    WSTabBarController *wSTabBarController = [[WSTabBarController alloc]init];
    [self presentViewController:wSTabBarController animated:YES completion:nil];
}

//显示京东框架
- (void)showJDTabBarFrame
{
    JDTabBarController *jDTabBarController = [[JDTabBarController alloc]init];
    [self presentViewController:jDTabBarController animated:YES completion:nil];

}

//现实swift框架
- (void)showSwiftTabBarFrame
{
    RAMAnimatedTabBarController *swiftTabBarController = [[RAMAnimatedTabBarController alloc]init];
    [self presentViewController:swiftTabBarController animated:YES
                     completion:nil];
}

//现实LMC框架
- (void)showLMCTabBarFrame
{
    LMCTabBarController *lmcTabBarController = [[LMCTabBarController alloc]init];
    [self presentViewController:lmcTabBarController animated:YES completion:nil];

}

//显示ZALTabBar框架
- (void)showZALTabBarFrame
{

    ZALTabBarController *tbc = [[ZALTabBarController alloc] init];
    [self presentViewController:tbc animated:YES completion:nil];
}



@end
