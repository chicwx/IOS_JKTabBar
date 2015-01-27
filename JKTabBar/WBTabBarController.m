//
//  WBTabBarController.m
//  JKTabBar
//
//  Created by dg11183ios on 14/12/3.
//  Copyright (c) 2014年 dg11183. All rights reserved.
//

#import "WBTabBarController.h"

#import "WBHomeViewController.h"
#import "WBMessageViewController.h"
#import "WBDiscoverViewController.h"
#import "WBProfileViewController.h"
#import "Animations.h"
#import "WBTarBar.h"

#import "JCRBlurView.h"

@interface WBTabBarController ()<UITabBarControllerDelegate,WBTabBarDelegate,WBHomeViewControllerDelegate>
{
    JCRBlurView* addPlusView;
    //文字
    UIButton *editTextButton;
    //相册
    UIButton *photoButton;
    //拍摄
    UIButton *composeButton;
    //签到
    UIButton *weiboButton;
    //点评
    UIButton *reviewButton;
    //更多
    UIButton *moreButton;
    UIImageView *closeImageView;
    
}
@end

@implementation WBTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置navigationBar颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
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
    
    
    //添加四个子控制器
    WBHomeViewController *home=[[WBHomeViewController alloc]init];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    home.wbHomeViewControllerDelegate = self;
    
    WBMessageViewController *message=[[WBMessageViewController alloc]init];
    [self addOneChildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    WBDiscoverViewController *discover=[[WBDiscoverViewController alloc]init];
    [self addOneChildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    WBProfileViewController *profile=[[WBProfileViewController alloc]init];
    [self addOneChildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
    
    // 调整tabbar
    WBTarBar *customTabBar = [[WBTarBar alloc] init];
    customTabBar.wbDelegate = self;
    //customTabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    //customTabBar.selectionIndicatorImage = [UIImage imageNamed:@"navigationbar_button_background"];
    
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
    
    // 设置代理（监听控制器的切换， 控制器一旦切换了子控制器，就会调用代理的tabBarController:didSelectViewController:）
    self.delegate = self;
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 强制重新布局子控件（内部会调用layouSubviews）
    [self.tabBar setNeedsLayout];
}

/**
 *  添加一个子控制器
 *
 *  @param childVC           子控制对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */
-(void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    //随机设置子控制器的背景颜色
    //    childVc.view.backgroundColor=YYRandomColor;
    
    //设置标题
    childVc.title=title;  //相当于设置了后两者的标题
    //    childVc.navigationItem.title=title;//设置导航栏的标题
    //    childVc.tabBarItem.title=title;//设置tabbar上面的标题
    
    
    //设置tabBarItem普通状态下文字的颜色
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor grayColor];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置tabBarItem普通状态下文字的颜色
    NSMutableDictionary *selectedtextAttrs=[NSMutableDictionary dictionary];
    selectedtextAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedtextAttrs forState:UIControlStateSelected];
    
    
    //设置图标
    childVc.tabBarItem.image=[UIImage imageNamed:imageName];
    //设置选中时的图标
    UIImage *selectedImage=[UIImage imageNamed:selectedImageName];
    
    
    if (IOS_7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    
}


#pragma mark - WBTabBarDelegate
//点击加号按钮代理事件
-(void)tabBarDidClickedPlusButton:(WBTarBar *)tabBar
{
    NSLog(@"WBTabBarDelegate");
    
    //添加毛玻璃效果
    addPlusView = [[JCRBlurView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width   , self.view.frame.size.height)];
    //[self.view addSubview:addPlusView];
    
    //添加关闭按钮
    UIView *closeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    closeView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *closeViewTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeAddPlusViewAction)];
    [closeView addGestureRecognizer:closeViewTapGesture];
    [addPlusView addSubview:closeView];
    
    closeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-15, 7, 30, 30)];
    [closeImageView setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"]];
    [closeView addSubview:closeImageView];
    
    
    //文字
    editTextButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 800, 72, 100)];    editTextButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *editTextImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
    [editTextImageView setImage:[UIImage imageNamed:@"tabbar_compose_idea"]];
    [editTextButton addSubview:editTextImageView];
    UILabel *editTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 83, 72, 20)];
    editTextLabel.text = @"文字";
    [editTextLabel setTextAlignment:NSTextAlignmentCenter];
    editTextLabel.textColor = [UIColor blackColor];
    editTextLabel.backgroundColor = [UIColor clearColor];
    editTextLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [editTextButton addSubview:editTextLabel];
    [addPlusView addSubview:editTextButton];
    
    //相册
    photoButton = [[UIButton alloc]initWithFrame:CGRectMake(122, 800, 72, 100)];    photoButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
    [photoImageView setImage:[UIImage imageNamed:@"tabbar_compose_photo"]];
    [photoButton addSubview:photoImageView];
    UILabel *photoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 83, 70, 20)];
    photoLabel.text = @"相册";
    [photoLabel setTextAlignment:NSTextAlignmentCenter];
    photoLabel.textColor = [UIColor blackColor];
    photoLabel.backgroundColor = [UIColor clearColor];
    photoLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [photoButton addSubview:photoLabel];
    [addPlusView addSubview:photoButton];
    
    //拍摄
    composeButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 800, 72, 100)];    composeButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *composeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
    [composeImageView setImage:[UIImage imageNamed:@"tabbar_compose_camera"]];
    [composeButton addSubview:composeImageView];
    UILabel *composeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 83, 72, 20)];
    composeLabel.text = @"拍摄";
    [composeLabel setTextAlignment:NSTextAlignmentCenter];
    composeLabel.textColor = [UIColor blackColor];
    composeLabel.backgroundColor = [UIColor clearColor];
    composeLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [composeButton addSubview:composeLabel];
    [addPlusView addSubview:composeButton];
    
    //签到
    weiboButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 800, 72, 100)];    weiboButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *weiboImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
    [weiboImageView setImage:[UIImage imageNamed:@"tabbar_compose_weibo"]];
    [weiboButton addSubview:weiboImageView];
    UILabel *weiboLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 83, 72, 20)];
    weiboLabel.text = @"签到";
    [weiboLabel setTextAlignment:NSTextAlignmentCenter];
    weiboLabel.textColor = [UIColor blackColor];
    weiboLabel.backgroundColor = [UIColor clearColor];
    weiboLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [weiboButton addSubview:weiboLabel];
    [addPlusView addSubview:weiboButton];
    
    //点评
    reviewButton = [[UIButton alloc]initWithFrame:CGRectMake(122, 800, 72, 100)];    reviewButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *reviewImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
    [reviewImageView setImage:[UIImage imageNamed:@"tabbar_compose_review"]];
    [reviewButton addSubview:reviewImageView];
    UILabel *reviewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 83, 72, 20)];
    reviewLabel.text = @"点评";
    [reviewLabel setTextAlignment:NSTextAlignmentCenter];
    reviewLabel.textColor = [UIColor blackColor];
    reviewLabel.backgroundColor = [UIColor clearColor];
    reviewLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [reviewButton addSubview:reviewLabel];
    [addPlusView addSubview:reviewButton];
    
    //更多
    moreButton = [[UIButton alloc]initWithFrame:CGRectMake(225, 800, 72, 100)];    moreButton.backgroundColor = [UIColor clearColor];
    
    UIImageView *moreImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 72, 72)];
    [moreImageView setImage:[UIImage imageNamed:@"tabbar_compose_more"]];
    [moreButton addSubview:moreImageView];
    UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 83, 72, 20)];
    moreLabel.text = @"更多";
    [moreLabel setTextAlignment:NSTextAlignmentCenter];
    moreLabel.textColor = [UIColor blackColor];
    moreLabel.backgroundColor = [UIColor clearColor];
    moreLabel.font = [UIFont fontWithName:@"Arial" size:13];
    [moreButton addSubview:moreLabel];
    [addPlusView addSubview:moreButton];
    
    
    
    //[Animations fadeIn:addPlusView andAnimationDuration:0.2 andWait:YES];
    [self.view addSubview:addPlusView];
    
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(45 * (M_PI / 180.0f));
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        closeImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        //endAngle += 10;
    }];
    
    
    //文字动画
    [UIView animateWithDuration:0.4 animations:^{
        [editTextButton setFrame:CGRectMake(20, 180, 72, 100)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [editTextButton setFrame:CGRectMake(20, 200, 72, 100)];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    //相册动画
    [UIView animateWithDuration:0.45 animations:^{
        [photoButton setFrame:CGRectMake(122, 180, 72, 100)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [photoButton setFrame:CGRectMake(122, 200, 72, 100)];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    //拍摄动画
    [UIView animateWithDuration:0.5 animations:^{
        [composeButton setFrame:CGRectMake(225, 180, 72, 100)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [composeButton setFrame:CGRectMake(225, 200, 72, 100)];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    //签到动画
    [UIView animateWithDuration:0.5 animations:^{
        [weiboButton setFrame:CGRectMake(20, 300, 72, 100)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [weiboButton setFrame:CGRectMake(20, 330, 72, 100)];
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    //点评
    [UIView animateWithDuration:0.55 animations:^{
        [reviewButton setFrame:CGRectMake(122, 300, 72, 100)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [reviewButton setFrame:CGRectMake(122, 330, 72, 100)];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    //更多
    [UIView animateWithDuration:0.6 animations:^{
        [moreButton setFrame:CGRectMake(225, 300, 72, 100)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            [moreButton setFrame:CGRectMake(225, 330, 72, 100)];
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    
}

//关闭
- (void)closeAddPlusViewAction
{
    
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(-45 * (M_PI / 180.0f));
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
        closeImageView.transform = endAngle;
    } completion:^(BOOL finished) {
        //endAngle += 10;
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        [editTextButton setFrame:CGRectMake(20, 700, 72, 100)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.28 animations:^{
        [photoButton setFrame:CGRectMake(122, 700, 72, 100)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [composeButton setFrame:CGRectMake(225, 700, 72, 100)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.23 animations:^{
        [weiboButton setFrame:CGRectMake(20, 700, 72, 100)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.21 animations:^{
        [reviewButton setFrame:CGRectMake(122, 700, 72, 100)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.18 animations:^{
        [moreButton setFrame:CGRectMake(225, 700, 72, 100)];
    } completion:^(BOOL finished) {
        
    }];
    
    
    [Animations fadeOut:addPlusView andAnimationDuration:0.5 andWait:YES];
    for(UIView *view in addPlusView.subviews)
    {
        if (view) {
            [view removeFromSuperview];
        }
    }
    [addPlusView removeFromSuperview];
}

#pragma mark - WBHomeViewControllerDelegate
//退出tabBar
- (void)quitTabBarController
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
