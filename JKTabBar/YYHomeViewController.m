//
//  YYHomeViewController.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "YYHomeViewController.h"

@interface YYHomeViewController ()

@end

@implementation YYHomeViewController
@synthesize yyHomeViewControllerDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    
    UIButton *quitTabBarControllerButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 100, 100, 30)];
    quitTabBarControllerButton.backgroundColor = [UIColor orangeColor];
    [quitTabBarControllerButton addTarget:self action:@selector(quitTabBarControllerAction) forControlEvents:UIControlEventTouchUpInside];
    [quitTabBarControllerButton setTitle:@"退出" forState:UIControlStateNormal];
    [self.view addSubview:quitTabBarControllerButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//退出
- (void)quitTabBarControllerAction
{
    [yyHomeViewControllerDelegate quitTabBarController];
}

@end
