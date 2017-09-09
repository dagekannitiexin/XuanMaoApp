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
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息中心";
    
    //如果无数据
    [self createEmptyView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createEmptyView
{
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"bgEmptyMessage"];
    bgView.size = CGSizeMake(190, 190);
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    bgView.y = bgView.y -64;
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    messageLabel.y = bgView.bottom +30;
    messageLabel.text = @"暂时还没有消息";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:messageLabel];
    [self.view addSubview:bgView];
}

@end
