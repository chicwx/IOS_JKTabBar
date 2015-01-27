//
//  WSTabBarController.h
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSTabBarController : UITabBarController
@property (nonatomic,assign) UIImage *backgroundImage;//UITabBar背景图
@property (nonatomic,strong) UIImage *tabImage;    //切换图片
@property (nonatomic,strong) NSArray *imageArray;  //
@property (nonatomic,strong) NSArray *imageHighlightArray;

@property (nonatomic) CGFloat imageWidth;
@property (nonatomic) CGFloat imageHeight;

@end
