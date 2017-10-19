//
//  XMMeMessageCenter.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/8.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeMessageCenter.h"

@interface XMMeMessageCenter ()

@end

@implementation XMMeMessageCenter

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor whiteColor];
    [self creatnavigationbar];
    
    //如果无数据
    [self createEmptyView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatnavigationbar
{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    // 添加title视图
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 175, 44)];
    titleLabel.centerX = navView.centerX;
    titleLabel.centerY = 20+22;
    titleLabel.text = @"消息中心";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [navView addSubview:titleLabel];
    
    
    //添加底线
    UIView * bottomline = [[UIView alloc]initWithFrame:CGRectMake(0, navView.height-0.5, SCREEN_WIDTH, 0.5)];
    bottomline.backgroundColor = XMBottomLine;
    [navView addSubview:bottomline];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- initView
- (void)createEmptyView
{
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    emptyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:emptyView];
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"bgEmptyMessage"];
    bgView.size = CGSizeMake(190, 190);
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    bgView.y = 140*KHeight_Scale;
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    messageLabel.y = bgView.bottom +20;
    messageLabel.text = @"暂时还没有消息";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textColor = XMGaryColor;
    [emptyView addSubview:messageLabel];
    [emptyView addSubview:bgView];
}

@end
