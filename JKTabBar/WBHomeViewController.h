//
//  WBHomeViewController.h
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WBHomeViewControllerDelegate <NSObject>

//退出tabBar
- (void)quitTabBarController;

@end

@interface WBHomeViewController : UIViewController
@property (nonatomic,strong) id<WBHomeViewControllerDelegate>wbHomeViewControllerDelegate;
@end
