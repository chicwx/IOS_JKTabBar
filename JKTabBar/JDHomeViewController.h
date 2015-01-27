//
//  JDHomeViewController.h
//  JKTabBar
//
//  Created by dg11185ios on 14/12/5.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JDHomeViewControllerDelegate <NSObject>
//退出tabBar
- (void)quitTabBarController;
@end

@interface JDHomeViewController : UIViewController
@property (nonatomic,strong) id<JDHomeViewControllerDelegate>jdHomeViewControllerDelegate;
@end
