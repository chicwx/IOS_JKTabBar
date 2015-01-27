//
//  JKTabBarItem.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "JKTabBarItem.h"

@implementation JKTabBarItem


- (UITabBarItem *) createTabBarItem:(NSString *)strTitle
                        normalImage:(NSString *)strNormalImg
                      selectedImage:(NSString *)strSelectedImg
                            itemTag:(NSInteger)intTag
{
    //设置标题
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:strTitle image:nil tag:intTag];
    
    /*
    //改变UITabBar整体颜色
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
     
    //未选中时标题颜色
    [item setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1.0], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //选中时标题颜色
    [item setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:53/255.0 green:0.0 blue:0.0 alpha:1.0], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    */
    
    //[item setTitlePositionAdjustment:UIOffsetMake(item.titlePositionAdjustment.horizontal,item.titlePositionAdjustment.vertical-0.0)];
    
    
    //ios8 新方法
    if (IOS_8)
    {
//        [item setImage:[[UIImage imageNamed:strNormalImg]
//                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        [item setSelectedImage:[[UIImage imageNamed:strSelectedImg]
//                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        [item setImage:[[UIImage imageWithCGImage:[UIImage imageNamed:strNormalImg].CGImage scale:1.0/0.6 orientation:UIImageOrientationUp]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[[UIImage imageWithCGImage:[UIImage imageNamed:strSelectedImg].CGImage scale:1.0/0.6 orientation:UIImageOrientationUp]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    
    //ios5-ios7 旧方法
    else{
        [item setFinishedSelectedImage:[UIImage imageWithCGImage:[UIImage imageNamed:strSelectedImg].CGImage scale:1.0/0.6 orientation:UIImageOrientationUp] withFinishedUnselectedImage:[UIImage imageWithCGImage:[UIImage imageNamed:strNormalImg].CGImage scale:1.0/0.6 orientation:UIImageOrientationUp] ];
    }
    
    return item;
}

@end
