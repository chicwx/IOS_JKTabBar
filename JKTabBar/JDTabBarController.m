//
//  JDTabBarController.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/5.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "JDTabBarController.h"
#import "JDHomeViewController.h"
#import "JDClassViewController.h"
#import "JDFindViewController.h"
#import "JDCartViewController.h"
#import "JDMeViewController.h"

@interface JDTabBarController ()<JDHomeViewControllerDelegate>
{
    NSMutableArray *buttonArray;//按钮数组(实现动画效果)
    
    UIImageView *tabView;//切换图(实现动画效果)
    
}

@end

@implementation JDTabBarController

@synthesize backgroundImage;
@synthesize tabImage;
@synthesize imageArray;
@synthesize imageHighlightArray;
@synthesize imageWidth;
@synthesize imageHeight;

#pragma mark - System
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //默认值
        //self.imageWidth = 30;
        //self.imageHeight = 30;
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
    
    //设置navigationBar颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:234.0/255 green:101.0/255 blue:114.0/255 alpha:1.0]];
    //[[UINavigationBar appearance] setTranslucent:NO];
    
    /** navigationBar 字体
     UITextAttributeFont – 字体key
     UITextAttributeTextColor – 文字颜色key
     UITextAttributeTextShadowColor – 文字阴影色key
     UITextAttributeTextShadowOffset – 文字阴影偏移量key
     */
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor blackColor],
      NSForegroundColorAttributeName,//字体颜色
      [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:18.0],
      NSFontAttributeName,//字体大小
      nil]];
    
    //home
    JDHomeViewController *homeViewController  = [[JDHomeViewController alloc]init];
    UINavigationController *homeNavigationController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    homeViewController.jdHomeViewControllerDelegate = self;
    //class
    JDClassViewController *classViewController = [[JDClassViewController alloc]init];
    UINavigationController *classNavigationController = [[UINavigationController alloc]initWithRootViewController:classViewController];
    
    //find
    JDFindViewController *findViewController = [[JDFindViewController alloc]init];
    UINavigationController *findNavigationController = [[UINavigationController alloc]initWithRootViewController:findViewController];
    
    //cart
    JDCartViewController *cartViewController = [[JDCartViewController alloc]init];
    UINavigationController *cartNavigationController = [[UINavigationController alloc]initWithRootViewController:cartViewController];
    
    //me
    JDMeViewController *meViewController = [[JDMeViewController alloc]init];
    UINavigationController *meNavigationController = [[UINavigationController alloc]initWithRootViewController:meViewController];
    
    //tabbar
    self.viewControllers = [NSArray arrayWithObjects:homeNavigationController,classNavigationController,findNavigationController,cartNavigationController,meNavigationController, nil];
    
    self.imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabBar_home_normal"],[UIImage imageNamed:@"tabBar_category_normal"],[UIImage imageNamed:@"tabBar_find_normal"],[UIImage imageNamed:@"tabBar_cart_normal"],[UIImage imageNamed:@"tabBar_myJD_normal"], nil];
    self.imageHighlightArray = @[[UIImage imageNamed:@"tabBar_home_press"],[UIImage imageNamed:@"tabBar_category_press"],[UIImage imageNamed:@"tabBar_find_press"],[UIImage imageNamed:@"tabBar_cart_press"],[UIImage imageNamed:@"tabBar_myJD_press"]];
    
    self.imageHeight = self.tabBar.frame.size.height;
    self.imageWidth = self.tabBar.frame.size.width/5;
    self.backgroundImage = [UIImage imageNamed:@"tabBar_bg"];
    self.tabImage = [UIImage imageNamed:@"tabBar_selected"];
    self.selectedIndex = 0;
}

#pragma mark - View
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
        btnImgView.frame = CGRectMake((btnWidth-self.imageWidth)/2, 0, self.imageWidth, self.imageHeight);
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
    //[self buttonAnimate:sender];
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

//旋转动画
- (void) rotationAnimate:(UIButton *)button{
    NSInteger *imageTag = button.tag;
    

}

- (void)headPhotoAnimation:(UIImageView *)imageView
{
    [self rotate360WithDuration:2.0 repeatCount:1 imageView:imageView];
    imageView.animationDuration = 2.0;
    imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"head1.jpg"],
                                      [UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head2.jpg"],
                                      [UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head2.jpg"],
                                      [UIImage imageNamed:@"head1.jpg"], nil];
    imageView.animationRepeatCount = 1;
    [imageView startAnimating];
}

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount imageView:(UIImageView *)imageView
{
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0,1,0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2*M_PI, 0,1,0)],
                           nil];
    theAnimation.cumulative = YES;
    theAnimation.duration = aDuration;
    theAnimation.repeatCount = aRepeatCount;
    theAnimation.removedOnCompletion = YES;
    
    [imageView.layer addAnimation:theAnimation forKey:@"transform"];
}

#pragma mark - JDHomeViewControllerDelegate
//退出tabBar
- (void)quitTabBarController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
