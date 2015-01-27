//
//  WSSearchViewController.m
//  JKTabBar
//
//  Created by dg11185ios on 14/12/3.
//  Copyright (c) 2014年 dg11185. All rights reserved.
//

#import "WSSearchViewController.h"

@interface WSSearchViewController ()<UIScrollViewDelegate>
{
    UIView *searchNavigationView;
    UIScrollView *mainScrollView;       //主界面显示的
    UIScrollView *navigationScrollView; //导航栏显示的
    
    UIView *whiteView;                  //导航栏滑动view
    //原创
    UIButton *createButton;
    //转发
    UIButton *transmitButton;
}

@end

@implementation WSSearchViewController
#pragma mark - System
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self showNavigationView];
    
    [self showMainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View
//显示导航栏
- (void)showNavigationView
{
    searchNavigationView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    searchNavigationView.backgroundColor = [UIColor colorWithRed:34.0/255 green:204.0/255 blue:204.0/255 alpha:1.0];
    [self.view addSubview:searchNavigationView];
    [self.view bringSubviewToFront:searchNavigationView];
    
    navigationScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-80, 25, 160, 30)];
    navigationScrollView.backgroundColor = [UIColor colorWithRed:34.0/255 green:204.0/255 blue:204.0/255 alpha:1.0];
    
    //变圆弧形
    CALayer *navigationLayer = [navigationScrollView layer];
    [navigationLayer setMasksToBounds:YES];
    [navigationLayer setCornerRadius:15];
    [navigationLayer setBorderWidth:2];
    [navigationLayer setBorderColor:[[UIColor whiteColor ]CGColor] ];
    [searchNavigationView addSubview:navigationScrollView];
    

    
    //滑动白色栏
    whiteView = [[UIView alloc]initWithFrame:CGRectMake(3, -17, 77, 24)];
    whiteView.backgroundColor = [UIColor whiteColor];
    //变圆弧形
    CALayer *whiteViewLayer = [whiteView layer];
    [whiteViewLayer setMasksToBounds:YES];
    [whiteViewLayer setCornerRadius:12];
    //[whiteViewLayer setBorderWidth:2];
    //[whiteViewLayer setBorderColor:[[UIColor whiteColor ]CGColor] ];
    [navigationScrollView addSubview:whiteView];
    //[navigationScrollView addSubview:whiteView];
    //[createButton]
    
    //原创
    createButton = [[UIButton alloc]initWithFrame:CGRectMake(2, -18, 78, 26)];
    createButton.backgroundColor = [UIColor clearColor];
    [createButton setTitle:@"原创" forState:UIControlStateNormal];
    [createButton setTitleColor:[UIColor colorWithRed:24.0/255 green:194.0/255 blue:194.0/255 alpha:1.0] forState:UIControlStateNormal];
    createButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [createButton addTarget:self action:@selector(createButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationScrollView addSubview:createButton];
    
    //转发
    transmitButton = [[UIButton alloc]initWithFrame:CGRectMake(80, -18, 78, 26)];
    transmitButton.backgroundColor = [UIColor clearColor];
    [transmitButton setTitle:@"转发" forState:UIControlStateNormal];
    [transmitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    transmitButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [transmitButton addTarget:self action:@selector(transmitButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationScrollView addSubview:transmitButton];
    
}



//显示主界面
- (void)showMainView
{
    self.view.backgroundColor = [UIColor whiteColor];

    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, searchNavigationView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-searchNavigationView.frame.size.height)];
    mainScrollView.backgroundColor = [UIColor grayColor];
    [mainScrollView setPagingEnabled:YES];
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    
    UITableView *createTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, mainScrollView.frame.size.height)];
    createTableView.backgroundColor = [UIColor greenColor];
    [mainScrollView addSubview:createTableView];
    
    UITableView *transmitTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, mainScrollView.frame.size.height)];
    transmitTableView.backgroundColor = [UIColor redColor];
    [mainScrollView addSubview:transmitTableView];
    
    //设置内容滑动的滑动范围
    [mainScrollView setContentSize:CGSizeMake(mainScrollView.frame.size.width * 2, mainScrollView.frame.size.height)];
    
}

#pragma mark - Other
//点击原创按钮事件
- (void)createButtonAction
{
    if (mainScrollView.contentOffset.x==0) {
        NSLog(@"createButtonAction");
    }else
    {
        [mainScrollView scrollRectToVisible:CGRectMake(0, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height) animated:YES];
        [transmitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [createButton setTitleColor:[UIColor colorWithRed:24.0/255 green:194.0/255 blue:194.0/255 alpha:1.0] forState:UIControlStateNormal];
    }
}

//点击转发按钮事件
- (void)transmitButtonAction
{
    if (mainScrollView.contentOffset.x==self.view.frame.size.width) {
        NSLog(@"transmitButtonAction");
    }else
    {
        [mainScrollView scrollRectToVisible:CGRectMake(self.view.frame.size.width, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height) animated:YES];
        [createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [transmitButton setTitleColor:[UIColor colorWithRed:24.0/255 green:194.0/255 blue:194.0/255 alpha:1.0] forState:UIControlStateNormal];
    }
}


#pragma mark - UIScrollViewDelegate
// any offset changes 只要view有滚动(不管是拖、拉、放大、缩小  等导致) 都会执行此函数
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView is %f",mainScrollView.contentOffset.x);
    
    float x = whiteView.frame.size.width/self.view.frame.size.width*mainScrollView.contentOffset.x;
    
    if (x>0&&x<whiteView.frame.size.width) {
        [whiteView setFrame:CGRectMake(x+3, whiteView.frame.origin.y
                                       , whiteView.frame.size.width, whiteView.frame.size.height)];
    }

}

// called on start of dragging (may require some time and or distance to move)
// 将要开始拖拽，手指已经放在view上并准备拖动的那一刻
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{

}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
// 已经结束拖拽，手指刚离开view的那一刻
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

}

// view已经停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    if (mainScrollView.contentOffset.x==0) {
        [transmitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [createButton setTitleColor:[UIColor colorWithRed:24.0/255 green:194.0/255 blue:194.0/255 alpha:1.0] forState:UIControlStateNormal];
    }
    
    if (mainScrollView.contentOffset.x==mainScrollView.frame.size.width) {
        [transmitButton setTitleColor:[UIColor colorWithRed:24.0/255 green:194.0/255 blue:194.0/255 alpha:1.0] forState:UIControlStateNormal];
        [createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

@end
