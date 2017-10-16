//
//  XMArticleViewController.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMArticleViewController.h"
#import "XMBuyShopView.h"
@interface XMArticleViewController ()
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

@end

@implementation XMArticleViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //处理navigationBar
    [self createNavigationBar];
    
    self.buyBtnImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *buyTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buyViewShow)];
    [self.buyBtnImg addGestureRecognizer:buyTap];
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

#pragma mark - lazyInit
- (XMBuyShopView*)shopView
{
    if (!_shopView){
        _shopView = [[XMBuyShopView alloc]init];
    }
    return _shopView;
}

@end
