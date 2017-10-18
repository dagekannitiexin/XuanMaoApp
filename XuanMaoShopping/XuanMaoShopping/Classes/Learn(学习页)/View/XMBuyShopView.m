//
//  XMBuyShopView.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMBuyShopView.h"

@interface XMBuyShopView()

@property (nonatomic ,strong)UIView *orderViewOne;

@property (nonatomic ,strong)UIView *orderViewTwo;
@end

@implementation XMBuyShopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.size = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        self.x = 0;
        self.y = SCREEN_HEIGHT;
        //创建第一步
        [self editTheOrder];
    }
    return self;
}

#pragma mark -创建订单  One
/*
 创建订单
 */
- (void)editTheOrder{
    _orderViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 400)];
    _orderViewOne.backgroundColor = [UIColor whiteColor];
    [self addSubview:_orderViewOne];
    _orderViewOne.layer.cornerRadius = 7.0;
    //设置初始位置
    _orderViewOne.centerX = SCREEN_WIDTH/2;
    _orderViewOne.centerY = SCREEN_HEIGHT/2;
    
    
    //创建导航栏 和底部确认栏
    [self createEditNavView];
    [self createDetermineView];
    //创建详细
    [self createDetailView];
}

- (void)createEditNavView{
    //导航栏 取消and 编辑订单
    UIView * editNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _orderViewOne.width, 55)];
    [_orderViewOne addSubview:editNavView];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 30, 15)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal
     ];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [editNavView addSubview:cancelBtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    titleLabel.center = editNavView.center;
    titleLabel.text = @"编辑订单";
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [editNavView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 54, editNavView.width-24, 1)];
    lineView.backgroundColor = XMGaryColor;
    [editNavView addSubview:lineView];
}

- (void)createDetermineView{
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, _orderViewOne.height-75, _orderViewOne.width, 75)];
    [_orderViewOne addSubview:footView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, footView.width, 1)];
    lineView.backgroundColor = XMGaryColor;
    [footView addSubview:lineView];
    
    UIButton *determine = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    determine.centerX = footView.centerX;
    determine.centerY = 75/2;
    determine.backgroundColor = RGBACOLOR(209, 88, 84, 1);
    [determine setTitle:@"¥129确认" forState:UIControlStateNormal];
    [determine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    determine.layer.cornerRadius = 7.0;
    determine.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [determine addTarget:self action:@selector(determineBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:determine];
}
- (void)createDetailView{
    //设置homeView
    UIScrollView *scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 55, _orderViewOne.width, 250)];
    scrView.backgroundColor = [UIColor whiteColor];
    scrView.showsVerticalScrollIndicator = FALSE;
    scrView.showsHorizontalScrollIndicator = FALSE;
    scrView.alwaysBounceHorizontal = YES;
    scrView.layer.masksToBounds = YES;
    [_orderViewOne addSubview:scrView];
    
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(_orderViewOne.width-68-15, 20, 68, 68)];
    iconImg.image = [UIImage imageNamed:@"Img_default"];
    [scrView addSubview:iconImg];
 
    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, iconImg.left-20, 15)];
    desc.text = @"能搭配各种外套的满分内搭来哈哈哈哈哈哈哈哈";
    desc.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [scrView addSubview:desc];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(15, desc.bottom+13, desc.width, 15)];
    price.text = @"69元";
    price.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [scrView addSubview:price];
    
    UILabel *info = [[UILabel alloc]initWithFrame:CGRectMake(15, price.bottom+15, desc.width, 11)];
    info.text = @"免运费 | 库存充足";
    info.textColor =XMHeigtGaryColor;
    info.font = [UIFont systemFontOfSize:10];
    [scrView addSubview:info];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, info.bottom+20, _orderViewOne.width-30, 150)];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    imgView.image = [UIImage imageNamed:@"Img_default"];
    [scrView addSubview:imgView];
    
}

/*
 取消按钮
 */
- (void)cancelClick{
    if (self.cancelBtnBlock)
    {
        self.cancelBtnBlock();
    }
}

/*
 点击确认按钮
 */
- (void)determineBtnClick{
    //此处有动画
    [UIView animateWithDuration:0.15 animations:^{
        self.orderViewOne.size = CGSizeMake(SCREEN_WIDTH-30, 465);
    } completion:^(BOOL finished) {
        self.orderViewOne.size = CGSizeMake(SCREEN_WIDTH-30, 400);
        //隐藏第一个界面
        self.orderViewOne.hidden = YES;
        //产生订单给用户 待确认
        [self createDetermineViewTwo];
    }];
    
}

#pragma mark -创建订单  Two

- (void)createDetermineViewTwo{
    //创建第一步
    _orderViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-30, 465)];
    _orderViewTwo.backgroundColor = [UIColor whiteColor];
    [self addSubview:_orderViewTwo];
    _orderViewTwo.layer.cornerRadius = 7.0;
    //设置初始位置
    _orderViewTwo.centerX = SCREEN_WIDTH/2;
    _orderViewTwo.centerY = SCREEN_HEIGHT/2;
    
    //创建导航栏 和底部确认栏
    [self createEditNavViewTwo];
    [self createFootViewTwo];
    //创建详细
    [self createDetailViewTwo];
}

- (void)createEditNavViewTwo{
    //导航栏 取消and 编辑订单
    UIView * editNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _orderViewOne.width, 55)];
    [_orderViewTwo addSubview:editNavView];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 30, 15)];
    [cancelBtn setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal
     ];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [editNavView addSubview:cancelBtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    titleLabel.center = editNavView.center;
    titleLabel.text = @"确认订单";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Regular" size:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [editNavView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 54, editNavView.width-24, 1)];
    lineView.backgroundColor = XMGaryColor;
    [editNavView addSubview:lineView];
}

- (void)createFootViewTwo{
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, _orderViewTwo.height-75, _orderViewTwo.width, 75)];
    [_orderViewTwo addSubview:footView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, footView.width, 1)];
    lineView.backgroundColor = XMGaryColor;
    [footView addSubview:lineView];
    
    UIButton *determine = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _orderViewTwo.width-60, 44)];
    determine.centerX = footView.centerX;
    determine.centerY = 75/2;
    determine.backgroundColor = RGBACOLOR(209, 88, 84, 1);
    [determine setTitle:@"选择付款方式" forState:UIControlStateNormal];
    [determine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    determine.layer.cornerRadius = 7.0;
    determine.titleLabel.font = [UIFont systemFontOfSize:17];
    [determine addTarget:self action:@selector(chooseBuyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:determine];
}

- (void)createDetailViewTwo{
    //第一部分 地址icon 姓名 电话 详细地址 选择按钮
    UIView *adressView = [[UIView alloc]initWithFrame:CGRectMake(0, 55, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:adressView];
    
    UIImageView *adressImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    adressImg.image = [UIImage imageNamed:@"iconTradeLocation"];
    [adressView addSubview:adressImg];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(adressImg.right+15, 15, 55, 16)];
    name.text = @"林尤达";
    name.textColor = [UIColor blackColor];
    name.font = [UIFont systemFontOfSize:15];
    [adressView addSubview:name];
    
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(name.right+5, name.y, 150, 15)];
    phone.text = @"17858022558";
    phone.textColor = [UIColor blackColor];
    phone.font = [UIFont systemFontOfSize:15];
    [adressView addSubview:phone];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(name.x, name.bottom+10, adressView.width-name.right-15, 16)];
    address.font = [UIFont systemFontOfSize:14];
    address.text = @"浙江省宁波市鄞州区XX小区XX幢XX号XXXXXXXXXXXXXXX";
    address.textColor = XMHeigtGaryColor;
    [adressView addSubview:address];
    
    //箭头
    UIImageView *next = [[UIImageView alloc]initWithFrame:CGRectMake(adressView.width-15-24, 0, 24, 24)];
    next.centerY = adressView.height/2;
    next.image = [UIImage imageNamed:@"btnAdditionNormal"];
    [adressView addSubview:next];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, adressView.width-24, 1)];
    lineView.backgroundColor = XMGaryColor;
    [adressView addSubview:lineView];
    
    
    //第二部分 商品icon 描述商品 商品选择尺码 数量
    UIView *shoppingView = [[UIView alloc]initWithFrame:CGRectMake(0, adressView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:shoppingView];
    
    UIImageView *shoppingImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    shoppingImg.image = [UIImage imageNamed:@"iconTradeChannel"];
    [shoppingView addSubview:shoppingImg];
    
    UILabel *shoppingDesc = [[UILabel alloc]initWithFrame:CGRectMake(shoppingImg.right+15, 15, shoppingView.width -shoppingImg.right -30-30, 16)];
    shoppingDesc.text = @"拿到手掂一掂，你就知道它们有多实心，会有多舒服，嘻嘻☺️";
    shoppingDesc.textColor = [UIColor blackColor];
    shoppingDesc.font = [UIFont systemFontOfSize:15];
    [shoppingView addSubview:shoppingDesc];
    
    
    UILabel *shoppingSize = [[UILabel alloc]initWithFrame:CGRectMake(shoppingDesc.x, shoppingDesc.bottom+10, shoppingView.width-shoppingDesc.x-15, 16)];
    shoppingSize.font = [UIFont systemFontOfSize:14];
    shoppingSize.text = @"CM2209S阴霾蓝/均码 x1";
    shoppingSize.textColor = XMHeigtGaryColor;
    [shoppingView addSubview:shoppingSize];
    
    UIView *lineShoppingView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, shoppingView.width-24, 1)];
    lineShoppingView.backgroundColor = XMGaryColor;
    [shoppingView addSubview:lineShoppingView];
    //第三部分 优惠券icon 优惠券描述 优惠券选择
    UIView *couponsView = [[UIView alloc]initWithFrame:CGRectMake(0, shoppingView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:couponsView];
    
    UIImageView *couponsImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    couponsImg.image = [UIImage imageNamed:@"iconTradeCoupon"];
    [couponsView addSubview:couponsImg];
    
    UILabel *couponsLabel = [[UILabel alloc]initWithFrame:CGRectMake(couponsImg.right+15, 0, shoppingView.width-shoppingDesc.x-15, 16)];
    couponsLabel.centerY = couponsView.height/2;
    couponsLabel.font = [UIFont systemFontOfSize:15];
    couponsLabel.text = @"暂无可用优惠券";
    couponsLabel.textColor = [UIColor blackColor];
    [couponsView addSubview:couponsLabel];
    
    //箭头
    UIImageView *nextCoupons = [[UIImageView alloc]initWithFrame:CGRectMake(adressView.width-15-24, 0, 24, 24)];
    nextCoupons.centerY = adressView.height/2;
    nextCoupons.image = [UIImage imageNamed:@"btnAdditionNormal"];
    [couponsView addSubview:nextCoupons];
    
    UIView *lineCouponsView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, couponsView.width-24, 1)];
    lineCouponsView.backgroundColor = XMGaryColor;
    [couponsView addSubview:lineCouponsView];
    
    //第四部分 实际付款icon 文字 阿拉伯数字价格 运费描述
    UIView *payForView = [[UIView alloc]initWithFrame:CGRectMake(0, couponsView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:payForView];
    
    UIImageView *payForImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    payForImg.image = [UIImage imageNamed:@"iconTradePay"];
    [payForView addSubview:payForImg];
    
    UILabel *payForLabel = [[UILabel alloc]initWithFrame:CGRectMake(payForImg.right+15, 0, payForView.width-shoppingDesc.x-15, 16)];
    payForLabel.centerY = payForView.height/2;
    payForLabel.font = [UIFont systemFontOfSize:15];
    payForLabel.text = @"实付款";
    payForLabel.textColor = [UIColor blackColor];
    [payForView addSubview:payForLabel];
    
    UILabel *payForMoney = [[UILabel alloc]initWithFrame:CGRectMake(payForView.width-15-50, 15, 50, 16)];
    payForMoney.text = @"¥136";
    payForMoney.textColor = [UIColor redColor];
    payForMoney.font = [UIFont systemFontOfSize:15];
    [payForView addSubview:payForMoney];
    
    UILabel *payForFreight = [[UILabel alloc]initWithFrame:CGRectMake(payForView.width-15-60, payForMoney.bottom+5, 60, 16)];
    payForFreight.text = @"含运费7元";
    payForFreight.font = [UIFont systemFontOfSize:12];
    payForFreight.textColor = XMHeigtGaryColor;
    [payForView addSubview:payForFreight];
    
    
    UIView *linePayForView = [[UIView alloc]initWithFrame:CGRectMake(12, 64, payForView.width-24, 1)];
    linePayForView.backgroundColor = XMGaryColor;
    [payForView addSubview:linePayForView];
    
    //第五部分 笔icon 添加备注 textView
    
    UIView *remarkView = [[UIView alloc]initWithFrame:CGRectMake(0, payForView.bottom, _orderViewTwo.width, 65)];
    [_orderViewTwo addSubview:remarkView];
    
    UIImageView *remarkImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 20, 20)];
    remarkImg.image = [UIImage imageNamed:@"iconTradeNote"];
    [remarkView addSubview:remarkImg];
    
    UITextField *remarkTextFile = [[UITextField alloc]initWithFrame:CGRectMake(remarkImg.right+15, 0, remarkView.width -remarkImg.right -15-10, 20)];
    remarkTextFile.centerY = remarkView.height/2;
    remarkTextFile.placeholder = @"添加备注...";
    remarkTextFile.font = [UIFont systemFontOfSize:14];
    remarkTextFile.clearButtonMode = UITextFieldViewModeWhileEditing;
    [remarkView addSubview:remarkTextFile];
}

- (void)backClick{
    //此处有动画
    [UIView animateWithDuration:0.15 animations:^{
        self.orderViewTwo.size = CGSizeMake(SCREEN_WIDTH-30, 400);
    } completion:^(BOOL finished) {
        self.orderViewTwo.size = CGSizeMake(SCREEN_WIDTH-30, 465);
        //隐藏第二个界面
        _orderViewTwo.hidden = YES;
        _orderViewOne.hidden = NO;
    }];
    
}

- (void)chooseBuyBtnClick{
}
@end
