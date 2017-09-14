//
//  XMMeAddressEmptyDetail.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/13.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeAddressEmptyDetail.h"
#import "XMMeAdressView.h"

@interface XMMeAddressEmptyDetail (){
    UIImageView *_cricleImg;
}
@property (nonatomic,assign)BOOL isNomalAddress; //是否设置默认地址
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
    XMMeAdressView *view = [[NSBundle mainBundle]loadNibNamed:@"XMMeAdressView" owner:nil options:nil].lastObject;
    view.origin = CGPointMake(0, 0);
    view.width = SCREEN_WIDTH;
    [self.view addSubview:view];
    
    XXTextView *textView = [[XXTextView alloc]initWithFrame:CGRectMake(67, 150, SCREEN_WIDTH -70-15, 78)];
    textView.xx_placeholder = @"详细地址";
    textView.xx_placeholderColor = XMPalceHolderColor;
    textView.xx_placeholderFont = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:textView];
    
    //加入设置为默认收货地址
    UIView *setNomalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 135, 17)];
    setNomalView.backgroundColor = [UIColor clearColor];
    setNomalView.center = CGPointMake(self.view.centerX, view.bottom+30);
    [self.view addSubview:setNomalView];
    
    _cricleImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 17, 17)];
    _cricleImg.image = [UIImage imageNamed:@"iconAddressCheckNormal"];
    [setNomalView addSubview:_cricleImg];
    
    UILabel *setNamal = [[UILabel alloc]initWithFrame:CGRectMake(_cricleImg.right+7, 0, 120, 17)];
    setNamal.text  = @"设为默认收货地址";
    setNamal.textColor = [UIColor blackColor];
    setNamal.font = [UIFont systemFontOfSize:14];
    [setNomalView addSubview:setNamal];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nomalAddress)];
    [setNomalView addGestureRecognizer:tap];
    
    self.isNomalAddress = NO;
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

- (void)nomalAddress
{
    if (self.isNomalAddress){
        _cricleImg.image = [UIImage imageNamed:@"iconAddressCheckNormal"];
        self.isNomalAddress = NO;
    }else {
        _cricleImg.image = [UIImage imageNamed:@"iconAddressCheckSelected"];
        self.isNomalAddress = YES;
    }
    
}
@end
