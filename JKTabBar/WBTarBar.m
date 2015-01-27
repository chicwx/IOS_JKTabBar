//
//  WBTarBar.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "WBTarBar.h"

@interface WBTarBar ()
@property (nonatomic, weak) UIButton *plusButton;
@end

@implementation WBTarBar
//初始化
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加加好按钮
        [self setupPlusButton];
    }
    return self;
}

//添加加号按钮
- (void)setupPlusButton
{
    UIButton *plusButton = [[UIButton alloc]init];
    //设置背景
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    //设置图标
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusClickAction) forControlEvents:UIControlEventTouchUpInside];
    //添加
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

//点击加号事件
- (void)plusClickAction
{
    //设置代理
    if ([self.wbDelegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)])
    {
        [self.wbDelegate tabBarDidClickedPlusButton:self];
    }
}

//布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置plusButton的frame
    [self setupPlusButtonFrame];
    
    //设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
}

//设置plusButton的frame
- (void)setupPlusButtonFrame
{

    [self.plusButton setFrame:CGRectMake(self.frame.size.width*0.5-self.plusButton.currentBackgroundImage.size.width/2, (self.frame.size.height-self.plusButton.currentBackgroundImage.size.height)/2, self.plusButton.currentBackgroundImage.size.width, self.plusButton.currentBackgroundImage.size.height)];
}

//设置所有tabbarButton的frame
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 遍历UITabBarButton中的所有子控件
        [self setupTabBarButtonTextColor:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

/**
 *  设置某个按钮的文字颜色
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex:(int)index
{
    // 选中按钮的索引
    NSUInteger selectedIndex = [self.items indexOfObject:self.selectedItem];
    
    for (UILabel *label in tabBarButton.subviews) {
        // 说明不是个Label
        if (![label isKindOfClass:[UILabel class]]) continue;
        
        // 设置字体
        label.font = [UIFont systemFontOfSize:10];
        if (selectedIndex == index) {
            // 说明这个Button选中, 设置label颜色为橙色
            label.textColor = [UIColor orangeColor];
        } else {
            // 说明这个Button没有选中, 设置label颜色为黑色
            label.textColor = [UIColor blackColor];
        }
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.frame.size.width / (self.items.count + 1);
    CGFloat buttonH = self.frame.size.height;
    

    if (index >= 2) {
        [tabBarButton setFrame:CGRectMake(buttonW * (index + 1), 0, buttonW, buttonH)];
    } else {
        [tabBarButton setFrame:CGRectMake(buttonW * index, 0, buttonW, buttonH)];
    }
}


@end
