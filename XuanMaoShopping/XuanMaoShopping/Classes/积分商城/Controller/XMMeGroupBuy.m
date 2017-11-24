//
//  XMMeGroupBuy.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/11.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeGroupBuy.h"
#import "XMIntegralHeadView.h"
#import "XMShopCostIntegralViewController.h"
#import "SignViewController.h"

@interface XMMeGroupBuy ()<UIViewControllerTransitioningDelegate>{
    UIScrollView *_scrShopView;
    XMIntegralHeadView *_headView;
    UIView   *_segView;
    UIButton *_costIntegral;
    UIButton *_getIntegral;
    UIButton *_exchangeIntegral;
    UIView   *_lineViewRed; //选择按钮的划痕
    UIView   *_conteView;
}

@property (nonatomic ,strong)XMShopCostIntegralViewController *costView;
@end

@implementation XMMeGroupBuy

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    // Do any additional setup after loading the view.
    
    [self creatnavigationbar];
    
    //有数据
    [self createShopView];
    
    //如果无数据
//    [self createEmptyView];
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
    titleLabel.text = @"积分商城";
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
    bgView.image = [UIImage imageNamed:@"bgOrderEmpty"];
    bgView.size = CGSizeMake(190, 190);
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    bgView.y = 140*KHeight_Scale;
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    messageLabel.y = bgView.bottom +20;
    messageLabel.text = @"还没有拼团";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textColor = XMGaryColor;
    [emptyView addSubview:messageLabel];
    [emptyView addSubview:bgView];
}


#pragma mark - centerView
/*
 创建积分商城页
 */
- (void)createShopView
{
    _scrShopView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _scrShopView.backgroundColor = XMBgColor;
    [self.view addSubview:_scrShopView];
    
    //创建积分View
    [self createIntegralHeadView];
    //创建选择按钮区
    [self createSegment];
    //内容页
    [self createContent];
}

#pragma mark - 次一级的视图
/*
 积分头部
 */
- (void)createIntegralHeadView
{
    _headView = [[NSBundle mainBundle]loadNibNamed:@"XMIntegralHeadView" owner:nil options:nil].lastObject;
    [_headView.qiandao addTarget:self action:@selector(qiandao:) forControlEvents:UIControlEventTouchUpInside];
    [_scrShopView addSubview:_headView];
    
}
/*
 选择按钮
 */
- (void)createSegment
{
    _segView = [[UIView alloc]initWithFrame:CGRectMake(0, _headView.bottom, SCREEN_WIDTH, 36)];
    _segView.backgroundColor = [UIColor whiteColor];
    [_scrShopView addSubview:_segView];
    
    //花积分
    _costIntegral = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 34)];
    _costIntegral.titleLabel.font = [UIFont systemFontOfSize:14];
    [_costIntegral setTitle:@"花积分" forState:UIControlStateNormal];
    [_costIntegral setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_costIntegral setTitleColor:RGBACOLOR(234, 47, 113, 1) forState:UIControlStateSelected];
    [_costIntegral addTarget:self action:@selector(removeView:) forControlEvents:UIControlEventTouchUpInside];
    _costIntegral.tag = 101;
    [_segView addSubview:_costIntegral];
    //挣积分
    _getIntegral = [[UIButton alloc]initWithFrame:CGRectMake(_costIntegral.right, 0, SCREEN_WIDTH/3, 34)];
    _getIntegral.titleLabel.font = [UIFont systemFontOfSize:14];
    [_getIntegral setTitle:@"挣积分" forState:UIControlStateNormal];
    [_getIntegral setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_getIntegral setTitleColor:RGBACOLOR(234, 47, 113, 1) forState:UIControlStateSelected];
    [_getIntegral addTarget:self action:@selector(removeView:) forControlEvents:UIControlEventTouchUpInside];
    _getIntegral.tag = 102;
    [_segView addSubview:_getIntegral];
    //兑换记录
    _exchangeIntegral = [[UIButton alloc]initWithFrame:CGRectMake(_getIntegral.right, 0, SCREEN_WIDTH/3, 34)];
    _exchangeIntegral.titleLabel.font = [UIFont systemFontOfSize:14];
    [_exchangeIntegral setTitle:@"兑换记录" forState:UIControlStateNormal];
    [_exchangeIntegral setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_exchangeIntegral setTitleColor:RGBACOLOR(234, 47, 113, 1) forState:UIControlStateSelected];
    [_exchangeIntegral addTarget:self action:@selector(removeView:) forControlEvents:UIControlEventTouchUpInside];
    _exchangeIntegral.tag = 103;
    [_segView addSubview:_exchangeIntegral];
    
    _lineViewRed = [[UIView alloc]initWithFrame:CGRectMake(0, 34, 70, 2)];
    _lineViewRed.backgroundColor = RGBACOLOR(235, 80, 26, 1);
    _lineViewRed.centerX = SCREEN_WIDTH/6;
    [_segView addSubview:_lineViewRed];
}


/* 选择按钮移动view*/
- (void)removeView:(UIButton *)sender
{
    //将所有按钮还原
    _costIntegral.selected = NO;
    _getIntegral.selected = NO;
    _exchangeIntegral.selected = NO;
    sender.selected = YES;
    
    //将下表移动
    if (sender.tag == 101){
        [UIView animateWithDuration:0.15 animations:^{
            _lineViewRed.centerX = SCREEN_WIDTH/6;
            _conteView.x = 0;
        }];
    }else if (sender.tag ==102){
        [UIView animateWithDuration:0.15 animations:^{
            _lineViewRed.centerX = SCREEN_WIDTH/2;
            _conteView.x = - SCREEN_WIDTH;
        }];
    }else if (sender.tag == 103){
        [UIView animateWithDuration:0.15 animations:^{
            _lineViewRed.centerX = SCREEN_WIDTH/6*5;
            _conteView.x = - SCREEN_WIDTH*2;
        }];
    }
}

/*
 内容页
 */
- (void)createContent
{
    _conteView = [[UIView alloc]initWithFrame:CGRectMake(0, _segView.bottom, SCREEN_WIDTH*3, SCREEN_HEIGHT-_segView.bottom)];
    [_scrShopView addSubview:_conteView];
    
    //花积分
    _costView = [[XMShopCostIntegralViewController alloc]init];
    _costView.view.origin = CGPointMake(0, 0);
    [_conteView addSubview:_costView.view];
    
    //积分规则
    UIScrollView *scr = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _conteView.height)];
    scr.backgroundColor = [UIColor whiteColor];
    scr.contentSize = CGSizeMake(SCREEN_WIDTH, _conteView.height+150);
    [_conteView addSubview:scr];
    
    UILabel *regulalLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, SCREEN_WIDTH-40, _conteView.height)];
    regulalLabel.userInteractionEnabled = NO;
    regulalLabel.numberOfLines = 0;
    regulalLabel.font = [UIFont systemFontOfSize:12];
    regulalLabel.textColor = [UIColor blackColor];

    NSString *textLabel = @"一、什么是美的积分？ \n 1. 美的积分定义：美的积分仅限美的平台（美的商城www.midea.com、“美的商城”微信公众号、“美的会员”微信公众号、淘系美的旗下指定旗舰店、专卖店等）内使用，是对美的用户完善个人资料、评价、签到、 线上购买美的产品等相关活动情况的奖励。\n 2. 美的积分有效期：积分可以累积，有效期至少为1年，即从获得开始至次年年底，逾期自动作废。\n3. 积分消耗逻辑：会员在使用积分时，优先消耗有效期更近的积分（如累积积分包括今年年底到期和明年年底到期的积分，则优先消耗今年年底到期的积分）。 \n \n 二、如何获得美的积分? \n 以下6种途径可以获得积分： \n 1. 对购物订单进行评价：在美的商城购买产品并确认收货后，可对所购买的产品进行评价，提交评价可获得10积分。如有晒图则可获得20积分的奖励。\n 2. 首次完成手机验证：首次成功绑定手机号可获得积分，每个会员仅可获得一次。\n 3. 个人资料100%完善：“个人中心”中“我的资料”的信息完整度100%可获得积分，每个会员仅可获得一次。 \n 4. 每日首次签到：在“个人中心”或“每日签到”每天首次签到可获得积分，每个会员每天仅可获得一次。 \n 5. 参与美的线上活动：可获得活动奖励积分，如：积分抽奖、冷知识、微砍价等活动。 \n 6. 线上购买美的产品：从2015年5月1日起，在线上指定店铺购买美的产品，收货人可获得相应积分；获得的积分需在30日内在“我的美的产品”中点击领取，否则积分失效；请收货人及时关注“美的商城”微信公众号，并注册美的会员，否则积分发放失败不予补偿。在美的商城购买的产品会在购买人确认收货后的24小时内自动发放到购买人的账号，购买人可在积分明细中进行查询。\n 线上购买美的产品获得积分公式为：交易金额X平台系数X积分返点； \n 平台系数：美的商城、淘系美的旗下指定店铺的平台系数为1，其他线上平台为0.8； \n 积分返点：积分的基准返点比例为商品交易金额的10%；";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textLabel];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textLabel length])];
    regulalLabel.attributedText = attributedString;

    [regulalLabel sizeToFit];
    [scr addSubview:regulalLabel];

    
    //兑换记录
    UILabel *noThingsLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 15, SCREEN_WIDTH, 20)];
    noThingsLabel.textAlignment = NSTextAlignmentCenter;
    noThingsLabel.text = @"暂时没有先关数据";
    noThingsLabel.font = [UIFont systemFontOfSize:12];
    noThingsLabel.textColor = [UIColor grayColor];
    [_conteView addSubview:noThingsLabel];
}


#pragma mark - qiandao
- (void)qiandao:(UIButton*)sender
{
            SignViewController * vc = [[SignViewController alloc]init];
    
            NSArray *array1 = [NSArray arrayWithObjects:@"5",@"10",@"15",@"20",@"25", nil];
            NSDictionary *rule = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"5",@"1",
                                  @"10",@"2",
                                  @"15",@"3",
                                  @"20",@"4",
                                  @"25",@"5",nil];
    
            NSDictionary *dicnew = [NSDictionary dictionaryWithObjectsAndKeys:
                                    array1,@"analysis_rule",
                                    @"1",@"current",
                                    rule,@"rule",
                                    @"103",@"score",
                                    @"5",@"sign_score",
                                    nil];
            vc.transitioningDelegate = [UIApplication sharedApplication].keyWindow.rootViewController;
            vc.modalPresentationStyle = UIModalPresentationCustom;
            vc.dic = dicnew;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:^{
    
            }];
}
@end
