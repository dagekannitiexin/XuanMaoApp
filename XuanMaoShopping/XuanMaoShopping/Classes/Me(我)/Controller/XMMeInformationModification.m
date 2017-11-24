//
//  XMMeInformationModification.m
//  XuanMaoShopping
//
//  Created by apple on 2017/11/24.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeInformationModification.h"

@interface XMMeInformationModification ()

@property (weak, nonatomic) IBOutlet UIButton *iconBtn; //用户头像
@property (weak, nonatomic) IBOutlet UIButton *boyBtn; //男孩按钮
@property (weak, nonatomic) IBOutlet UIButton *girlBtn; //女孩按钮

@end

@implementation XMMeInformationModification

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self creatnavigationbar];
    //初始化控件
    [self setBtnNew];
    
    
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
    titleLabel.text = @"修改个人信息";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [navView addSubview:titleLabel];
    
    
    //添加底线
    UIView * bottomline = [[UIView alloc]initWithFrame:CGRectMake(0, navView.height-0.5, SCREEN_WIDTH, 0.25)];
    bottomline.backgroundColor = XMBottomLine;
    [navView addSubview:bottomline];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBtnNew
{
    self.iconBtn.layer.cornerRadius = self.iconBtn.width/2;
    self.iconBtn.clipsToBounds = YES;
    
    self.boyBtn.layer.cornerRadius = 3.0;
    self.boyBtn.layer.borderWidth = 0.5;
    self.boyBtn.layer.borderColor = RGBACOLOR(77, 77, 77, 0.5).CGColor;
    [self.boyBtn setBackgroundImage:[UIImage imageNamed:@"bgButtonRedDisable"] forState:UIControlStateSelected];
    self.boyBtn.tag = 101;
    [self.boyBtn addTarget:self action:@selector(chooseBoyOrGirl:) forControlEvents:UIControlEventTouchUpInside];
    
    self.girlBtn.layer.cornerRadius = 3.0;
    self.girlBtn.layer.borderWidth = 0.5;
    self.girlBtn.layer.borderColor = RGBACOLOR(77, 77, 77, 0.5).CGColor;
    self.girlBtn.tag = 102;
    [self.girlBtn setBackgroundImage:[UIImage imageNamed:@"bgButtonRedDisable"] forState:UIControlStateSelected];
    [self.girlBtn addTarget:self action:@selector(chooseBoyOrGirl:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)chooseBoyOrGirl:(UIButton *)sender
{
    //先恢复正常
    self.boyBtn.selected = NO;
    self.girlBtn.selected = NO;
    
    sender.selected = YES;
    if (sender.tag == 101){
        
    }else if (sender.tag ==102){
        
    }
}
@end
