//
//  XMArticleViewController.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMArticleViewController.h"
#import "XMBuyShopView.h"
#import "XMMeAddressEmpty.h"
#import "XMMeCoupon.h"

#define HeadHeight 164
@interface XMArticleViewController ()<UIScrollViewDelegate>{
    CGRect orginYframe;
}
/*
 毛玻璃界面
 */
@property (nonatomic,strong)UIVisualEffectView *effectView;
/*购买界面
 */
@property (nonatomic,strong) XMBuyShopView *shopView;
/*
 购买按钮
 */
@property (weak, nonatomic) IBOutlet UIImageView *buyBtnImg;

/*
 头部背景图片
 */
@property (nonatomic, strong) UIImageView *headBgView;
@property (nonatomic, strong) UIScrollView *bgView; //底部滚动视图

@end

@implementation XMArticleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //处理navigationBar
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    [self createNavigationBar];
    
    self.buyBtnImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *buyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyViewShow)];
    [self.buyBtnImg addGestureRecognizer:buyTap];
    
    //主题view
    _bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    _bgView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.5);
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.showsVerticalScrollIndicator = FALSE;
    _bgView.showsHorizontalScrollIndicator = FALSE;
    _bgView.alwaysBounceHorizontal = NO;
    _bgView.layer.masksToBounds = YES;
    _bgView.delegate = self;
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    
    _headBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeadHeight)];
    _headBgView.image = [UIImage imageNamed:@"Img_default"];
    orginYframe = _headBgView.frame;
    _headBgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_headBgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark - btnClick
- (void)buyViewShow
{
    //产生毛玻璃效果盖在最顶层
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    //必须给effcetView的frame赋值,因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
    _effectView.frame = self.view.bounds;
    [self.view addSubview:_effectView];
    //将view显示出来
    [self.view addSubview:self.shopView];
    //计算上移动大小
    [UIView animateWithDuration:0.35 animations:^{
        self.shopView.centerY = SCREEN_HEIGHT/2;
    }];
}

//返回首页
- (IBAction)goToHomeClick:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}
 
#pragma mark - lazyInit
- (XMBuyShopView*)shopView
{
    if (!_shopView){
        _shopView = [[XMBuyShopView alloc]init];
        __block XMArticleViewController *blockSelf = self;
        //取消按钮 响应
        _shopView.cancelBtnBlock = ^{
            [UIView animateWithDuration:0.15 animations:^{
                blockSelf.shopView.y = SCREEN_HEIGHT;
            } completion:^(BOOL finished) {
                [blockSelf.shopView removeFromSuperview];
            }];
            [blockSelf.effectView removeFromSuperview];
        };
        //支付按钮响应
        _shopView.payBtnBlock = ^{
            [UIView animateWithDuration:0.15 animations:^{
                blockSelf.shopView.y = SCREEN_HEIGHT;
            } completion:^(BOOL finished) {
                [blockSelf.shopView removeFromSuperview];
            }];
            [blockSelf.effectView removeFromSuperview];
        };
        //地址按钮响应
        _shopView.adressBtnBlock = ^{
            XMMeAddressEmpty *addressVC = [[XMMeAddressEmpty alloc]init];
            [blockSelf.navigationController pushViewController:addressVC animated:YES];
        };
        
        //优惠券按钮响应
        _shopView.couponsBlock = ^{
            XMMeCoupon *couponVc =[[XMMeCoupon alloc]init];
            [blockSelf.navigationController pushViewController:couponVc animated:YES];
        };
    }
    return _shopView;
}

#pragma maek - 视图主体设置

/*
 scrollViewDidScroll Delegate
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y+20;
    if (offSetY >= 0)
    {
        _headBgView.frame = ({
            CGRect frame = _headBgView.frame;
            frame.origin.y = orginYframe.origin.y - offSetY;
            frame;
        });
    }
    else
    {
        _headBgView.frame = ({
            CGRect frame = _headBgView.frame;
            frame.size.width =orginYframe.size.width -offSetY;
            frame.size.height = orginYframe.size.height *frame.size.width/ orginYframe.size.width;
            frame.origin.x = -(frame.size.width - orginYframe.size.width)/2;
            frame;
        });
    }
}
@end
