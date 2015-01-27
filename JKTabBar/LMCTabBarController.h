//
//  LMCTabBarController.h
//  JKTabBar
//
//  Created by dg11185ios on 14/12/5.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMCTabBarController : UITabBarController
@property (nonatomic,assign) UIImage *backgroundImage;//UITabBar背景图
@property (nonatomic,retain) UIImage *tabImage;//UITabBar切换图
@property (nonatomic,retain) NSArray *imageArray;//UITabBarController视图数组对应的图标数组
@property (nonatomic,retain) NSArray *imageHighlightArray;//UITabBarController视图数组对应的图标数组
@property (nonatomic) CGFloat imageWidth;//UITabBar图标高度，默认30
@property (nonatomic) CGFloat imageHeight;//UITabBar图标宽度，默认30

@end
