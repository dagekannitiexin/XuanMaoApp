//
//  XMMeAddressEmptyDetail.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeAddressEmptyDetail.h"

@interface XMMeAddressEmptyDetail ()

@end

@implementation XMMeAddressEmptyDetail

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"填写收货地址";
    
    [self creatnavigationbar];
    
    [self createAdressView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)creatnavigationbar
{
    //添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 31.5, 12.5, 21)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftViewItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem =leftViewItem;
    
    
    UIButton *resavBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    [resavBtn setTitle:@"保存" forState:UIControlStateNormal];
    [resavBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    resavBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [resavBtn addTarget:self action:@selector(resaveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightViewItem = [[UIBarButtonItem alloc]initWithCustomView:resavBtn];
    self.navigationItem.rightBarButtonItem = rightViewItem;
}

- (void)createAdressView
{
    
}

#pragma mark - brnClick
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resaveBtnClick
{
    NSLog(@"点击保存啦");
}


@end
