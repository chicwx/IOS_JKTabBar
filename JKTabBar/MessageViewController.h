//
//  MessageViewController.h
//  MyTabBar
//
//  Created by dg11185_zal on 14/11/28.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

/***********消息界面**********/

#import <UIKit/UIKit.h>
@protocol MessageViewControllerDelegate <NSObject>
//退出tabBar
- (void)quitTabBarController;
@end
@interface MessageViewController : UIViewController
@property (nonatomic,strong)id<MessageViewControllerDelegate>messageViewControllerDelegate;
@end
