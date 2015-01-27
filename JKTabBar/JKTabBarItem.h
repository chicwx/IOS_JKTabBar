//
//  JKTabBarItem.h
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKTabBarItem : UITabBarItem
- (UITabBarItem *) createTabBarItem:(NSString *)strTitle
                        normalImage:(NSString *)strNormalImg
                      selectedImage:(NSString *)strSelectedImg
                            itemTag:(NSInteger)intTag;
@end
