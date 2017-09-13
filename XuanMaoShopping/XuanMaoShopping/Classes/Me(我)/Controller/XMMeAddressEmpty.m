//
//  XMMeAddressEmpty.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeAddressEmpty.h"
#import "XMMeAddressEmptyDetail.h"

@interface XMMeAddressEmpty (){
    UIView *_emptyView;
}

@end

@implementation XMMeAddressEmpty

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatnavigationbar];
    
    //如果无数据
    [self createEmptyView];
    
    //新增收货地址
    [self addAddressBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
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
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 31.5, 12.5, 21)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    // 添加title视图
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 175, 44)];
    titleLabel.centerX = navView.centerX;
    titleLabel.centerY = 20+22;
    titleLabel.text = @"管理收货地址";
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
    _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _emptyView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_emptyView];
    
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"bgAddressEmpty"];
    bgView.size = CGSizeMake(190, 190);
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    bgView.y = 140*KHeight_Scale;
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    messageLabel.y = bgView.bottom +20;
    messageLabel.text = @"暂无收货地址";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textColor = XMGaryColor;
    [_emptyView addSubview:messageLabel];
    [_emptyView addSubview:bgView];
}


- (void)addAddressBtn
{
    UIButton *addNewAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64-50, SCREEN_WIDTH, 50)];
    addNewAddressBtn.backgroundColor = RGBACOLOR(208, 88, 84, 1);
    [addNewAddressBtn setTitle:@"新增收货地址" forState:UIControlStateNormal];
    [addNewAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [addNewAddressBtn setImage:[UIImage imageNamed:@"iconSubAdd"] forState:UIControlStateNormal];
    [addNewAddressBtn setImage:[UIImage imageNamed:@"iconSubAdd"] forState:UIControlStateHighlighted];
    
    [addNewAddressBtn addTarget:self action:@selector(addNewAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_emptyView addSubview:addNewAddressBtn];
}

- (void)addNewAddressBtnClick
{
    XMMeAddressEmptyDetail *VC = [[XMMeAddressEmptyDetail alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
