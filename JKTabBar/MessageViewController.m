//
//  MessageViewController.m
//  MyTabBar
//
//  Created by dg11185_zal on 14/11/28.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
@synthesize messageViewControllerDelegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
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
    [messageViewControllerDelegate quitTabBarController];
}


@end
