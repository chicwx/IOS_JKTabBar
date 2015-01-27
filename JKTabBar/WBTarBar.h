//
//  WBTarBar.h
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBTarBar;

@protocol WBTabBarDelegate <NSObject>

-(void)tabBarDidClickedPlusButton:(WBTarBar *)tabBar;

@end

@interface WBTarBar : UITabBar

@property (nonatomic,weak) id<WBTabBarDelegate> wbDelegate;

@end
