//
//  XMMeCoupon.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/12.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeCoupon.h"

@interface XMMeCoupon (){
    UIView *_emptyView;
    UIButton *_exchangeBtn;
}

@end

@implementation XMMeCoupon

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatnavigationbar];
    
    //如果无数据
    [self createEmptyView];
    
    //增加输入兑换码
    [self createExchangeCoupon];
    
    
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
    titleLabel.text = @"优惠券";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [navView addSubview:titleLabel];
    
    
    //添加已过期优惠券
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-86-15, 20, 86, 44)];
    
    [rightBtn setTitle:@"已过期优惠券" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [navView addSubview:rightBtn];
    
    
    
    
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
    bgView.image = [UIImage imageNamed:@"bgCouponGrayEmpty"];
    bgView.size = CGSizeMake(190, 190);
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    bgView.y = 140*KHeight_Scale;
    
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 16)];
    messageLabel.y = bgView.bottom +20;
    messageLabel.text = @"暂无优惠券";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    messageLabel.textColor = [UIColor blackColor];
    [_emptyView addSubview:messageLabel];
    [_emptyView addSubview:bgView];
    
    //邀请好友各得10元优惠券
    UILabel *descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, messageLabel.bottom+21, SCREEN_WIDTH,13)];
    descriptionLabel.font = [UIFont systemFontOfSize:13];
    descriptionLabel.textColor = [UIColor blackColor];
    descriptionLabel.text =@"邀请好友各得10元优惠券";
    descriptionLabel.textAlignment = NSTextAlignmentCenter;
    [_emptyView addSubview:descriptionLabel];
    
    //分享有奖
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, descriptionLabel.bottom+40, 106, 37)];
    shareBtn.centerX = _emptyView.centerX;
    shareBtn.backgroundColor = RGBACOLOR(205, 89, 86, 1);
    shareBtn.layer.cornerRadius = shareBtn.height/2;
    [shareBtn setTitle:@"分享有奖" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [_emptyView addSubview:shareBtn];
}


#pragma  mark - addView
- (void)createExchangeCoupon
{
    UITextField *exchangeCoupon = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-60, 50)];
    //placeholder
    exchangeCoupon.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入兑换码"
                                                                           attributes:@{NSForegroundColorAttributeName: XMGaryColor,
                                                                                   NSFontAttributeName : [UIFont systemFontOfSize:15 weight:30],}];
    
    // leftView
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,15, 0)];
    exchangeCoupon.leftView = paddingView;
    exchangeCoupon.leftViewMode = UITextFieldViewModeAlways;
    [_emptyView addSubview:exchangeCoupon];
    
    //添加监控
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangeValue:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:exchangeCoupon];
    
    
    //添加兑换按钮
    _exchangeBtn = [[UIButton alloc]initWithFrame:CGRectMake(exchangeCoupon.right, exchangeCoupon.y, 60, 50)];
    [_exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];
    [_exchangeBtn setTitleColor:XMHeigtGaryColor forState:UIControlStateDisabled];
    [_exchangeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _exchangeBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [_exchangeBtn addTarget:self action:@selector(exchageClick) forControlEvents:UIControlEventTouchUpInside];
    _exchangeBtn.enabled = NO;
    [_emptyView addSubview:_exchangeBtn];
     
    //在textfile后加一条底线
    UIView * bottomline = [[UIView alloc]initWithFrame:CGRectMake(0, exchangeCoupon.bottom-0.5, SCREEN_WIDTH, 0.5)];
    bottomline.backgroundColor = RGBACOLOR(151, 151, 151, 0.5);
    [_emptyView addSubview:bottomline];
    
}

- (void)exchageClick
{
    NSLog(@"兑换");
}

//这里可以通过发送object消息获取注册时指定的UITextField对象
- (void)textFieldDidChangeValue:(NSNotification *)notification
{
    UITextField *sender = (UITextField *)[notification object];
    NSString *text = sender.text;
    if (text.length >0){
            _exchangeBtn.enabled = YES;
    }else {
            _exchangeBtn.enabled = NO;
    }
}



@end
