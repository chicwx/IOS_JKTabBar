//
//  MyTabBarController.m
//  MyTabBar
//
//  Created by dg11185_zal on 14/11/28.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "ZALTabBarController.h"
#import "MessageViewController.h"
#import "NewsViewController.h"

@interface ZALTabBarController ()<MessageViewControllerDelegate>
{
    NSMutableArray *buttonArray;//按钮数组(实现动画效果)
    
    UIImageView *tabView;//切换图(实现动画效果)

}

@end

@implementation ZALTabBarController

@synthesize backgroundImage;
@synthesize tabImage;
@synthesize imageArray;
@synthesize imageHighlightArray;
@synthesize imageWidth;
@synthesize imageHeight;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //默认值
        self.imageWidth = 30;
        self.imageHeight = 30;
        NSLog(@"initWithNibName");
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    //去除tabBar的所有控件
    [self removeTabBar];
    //自定义tabBar的控件
    [self initTabBar];
}

- (void)viewDidLoad
{
    [self showZALTabBarFrame];

}

//显示ZALTabBar框架
- (void)showZALTabBarFrame
{
    //消息界面
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    //新闻界面
    messageVC.messageViewControllerDelegate = self;
    NewsViewController *newsVC = [[NewsViewController alloc] init];
    
    NewsViewController *newsVC1 = [[NewsViewController alloc] init];
    NewsViewController *newsVC2 = [[NewsViewController alloc] init];
    
    
    //切换栏
    //ZALTabBarController *tbc = [[ZALTabBarController alloc] init];
    self.viewControllers = [NSArray arrayWithObjects:messageVC,newsVC,newsVC1,newsVC2, nil];
    self.imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabBar_0.jpg"],[UIImage imageNamed:@"tabBar_1.jpg"],[UIImage imageNamed:@"tabBar_0.jpg"],[UIImage imageNamed:@"tabBar_1.jpg"], nil];
    //tbc.imageHighlightArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabBar_0_on.jpg"],[UIImage imageNamed:@"tabBar_1_on.jpg"], nil];
    self.imageWidth = 35;
    self.imageHeight = 35;
    self.selectedIndex = 0;
    //[self presentViewController:tbc animated:YES completion:nil];
}

//去除tabBar的所有控件
-(void) removeTabBar{
    for (UIView *view in self.tabBar.subviews) {
        [view removeFromSuperview];
    }
}

//自定义tabBar的控件
-(void) initTabBar{
    //测试输出
    NSLog(@"viewCount=%ld",(long)self.viewControllers.count);
    NSLog(@"imageCount=%ld",(long)self.imageArray.count);
    NSLog(@"imageS=%ld",(long)self.imageHighlightArray.count);
    
    //切换控件的宽高
    float tabBarWidth = self.tabBar.frame.size.width;
    float tabBarHeight = self.tabBar.frame.size.height;
    //视图控制器的数量
    NSInteger viewCount = self.viewControllers.count;
    buttonArray = [NSMutableArray arrayWithCapacity:viewCount];
    //每个切换按钮的宽度
    float btnWidth = tabBarWidth/viewCount;
    //背景图
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tabBarWidth, tabBarHeight)];
    bgView.userInteractionEnabled = YES;
    if (self.backgroundImage) {
        bgView.image = self.backgroundImage;
    }else{
        bgView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    }
    [self.tabBar addSubview:bgView];
    //切换图
    tabView = [[UIImageView alloc] initWithFrame:CGRectMake(self.selectedIndex*btnWidth, 0, btnWidth, tabBarHeight)];
    if (self.tabImage) {
        tabView.image = self.tabImage;
    }else{
        tabView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    }
    [bgView addSubview:tabView];
    
    //切换按钮
    for (int i=0; i<viewCount; i++) {
        UIImageView *btnImgView = [[UIImageView alloc] init];
        [btnImgView setImage:[imageArray objectAtIndex:i]];
        if (self.imageHighlightArray.count>=i+1) {
            btnImgView.highlightedImage = [imageHighlightArray objectAtIndex:i];
        }
        if (self.selectedIndex==i) {
            btnImgView.highlighted = YES;
        }
        btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2, 5, self.imageWidth, self.imageHeight);
        UIButton *tabBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [tabBtn setFrame:CGRectMake(i*btnWidth, 0, btnWidth, tabBarHeight)];
        [tabBtn setTag:i];
        [tabBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [tabBtn addSubview:btnImgView];
        [bgView addSubview:tabBtn];
        [buttonArray addObject:tabBtn];
    }

}

//点击按钮事件
-(void) buttonClickAction:(UIButton*)sender
{
    NSInteger buttonIndex = sender.tag;
    //如果重复点击，则不切换
    if (self.selectedIndex == buttonIndex) {
        return;
    }
    //切换高亮状态
    for (UIButton *button in buttonArray) {
        if (button.tag != buttonIndex) {
            ((UIImageView*)button.subviews[0]).highlighted = NO;
        }
    }
    ((UIImageView*)sender.subviews[0]).highlighted = YES;
    //按钮动画
    [self buttonAnimate:sender];
    //切换图动画
    [self tabAnimate:sender];
    
    self.selectedIndex = buttonIndex;
}

//按钮动画
-(void) buttonAnimate:(UIButton *)button{
    //获取到按钮里的图片视图
    UIView *view = button.subviews[0];
    [UIView animateWithDuration:0.1 animations:^{
        //先缩小
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
    }completion:^(BOOL finished){//do other thing
        [UIView animateWithDuration:0.2 animations:
         ^(void){
             //再放大
             view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
             
         } completion:^(BOOL finished){//do other thing
             [UIView animateWithDuration:0.1 animations:
              ^(void){
                  //恢复到原样
                  view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                  
              } completion:^(BOOL finished){//do other thing
              }];
         }];
    }];
}

//切换图动画
-(void) tabAnimate:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = tabView.frame;
        frame.origin.x = button.frame.origin.x;
        tabView.frame = frame;
    }];
}

#pragma mark - MessageViewControllerDelegate
//退出tabBar
- (void)quitTabBarController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
