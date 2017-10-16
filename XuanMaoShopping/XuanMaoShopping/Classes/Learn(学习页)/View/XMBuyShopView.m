//
//  XMBuyShopView.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMBuyShopView.h"

@implementation XMBuyShopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        self.size = CGSizeMake(SCREEN_WIDTH-30,400);
        self.layer.cornerRadius = 7.0;
        //设置初始位置
        self.centerX = SCREEN_WIDTH/2;
        self.y = SCREEN_HEIGHT;
        
        //创建第一步
        [self editTheOrder];
    }
    return self;
}

#pragma mark -创建订单
/*
 创建订单
 */
- (void)editTheOrder{
    //创建导航栏 和底部确认栏
    [self createEditNavView];
    [self createDetermineView];
    //创建详细
    [self createDetailView];
}

- (void)createEditNavView{
    //导航栏 取消and 编辑订单
    UIView * editNavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 55)];
    [self addSubview:editNavView];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 20, 30, 15)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal
     ];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [editNavView addSubview:cancelBtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    titleLabel.center = editNavView.center;
    titleLabel.text = @"编辑订单";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [editNavView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(12, 54, editNavView.width-24, 1)];
    lineView.backgroundColor = XMGaryColor;
    [editNavView addSubview:lineView];
}

- (void)createDetermineView{
    UIView *footView =[[UIView alloc]initWithFrame:CGRectMake(0, self.height-75, self.width, 75)];
    [self addSubview:footView];
    
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
    [footView addSubview:determine];
}
- (void)createDetailView{
    //设置homeView
    UIScrollView *scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 55, self.width, 250)];
    scrView.backgroundColor = [UIColor whiteColor];
    scrView.showsVerticalScrollIndicator = FALSE;
    scrView.showsHorizontalScrollIndicator = FALSE;
    scrView.alwaysBounceHorizontal = YES;
    scrView.layer.masksToBounds = YES;
    [self addSubview:scrView];
    
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-68-15, 20, 68, 68)];
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
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, self.width-30, 100)];

    
}
@end
