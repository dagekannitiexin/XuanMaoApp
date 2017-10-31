//
//  XMMeGift.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/12.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeGift.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import "XMShareBtn.h"

@interface XMMeGift ()<NJKWebViewProgressDelegate>

@property(nonatomic,strong)NJKWebViewProgress * progressProxy;
@property(nonatomic,strong)NJKWebViewProgressView * progressView;

@end

@implementation XMMeGift

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self creatnavigationbar];
    
    
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 400)];
    [self.view addSubview:_web];
    
    _web.backgroundColor = [UIColor whiteColor];
    _web.allowsInlineMediaPlayback = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _web.scalesPageToFit = YES;
    
    _progressView =[[NJKWebViewProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    _progressView.progress = 0;
    [self.view addSubview:_progressView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _web.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_web loadRequest:request];
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
    titleLabel.text = @"分享有奖";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    [navView addSubview:titleLabel];
    
    //添加更多按钮
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44, 20, 44, 44)];
    [moreBtn setImage:[UIImage imageNamed:@"iconBlackDot"] forState:UIControlStateNormal];
    [navView addSubview:moreBtn];
    
    //添加底线
    UIView * bottomline = [[UIView alloc]initWithFrame:CGRectMake(0, navView.height-0.5, SCREEN_WIDTH, 0.5)];
    bottomline.backgroundColor = XMBottomLine;
    [navView addSubview:bottomline];
}

- (void)addShareBtn
{
    CGFloat btnWith = 50;
    CGFloat btnHeight = 80;
    CGFloat spaceWithBgView = 50;
    CGFloat spaceWithBtn = (SCREEN_WIDTH - btnWith*3 -spaceWithBgView*2)/2;
    NSArray *title = [NSArray arrayWithObjects:@"微信好友",@"朋友圈",@"微博", nil];
    NSArray *iconImg = [NSArray arrayWithObjects:@"iconColorWechat",@"iconColorTimeLine",@"iconColorWeibo", nil];
    for (int i =0; i<3; i++) {
        XMShareBtn *shareBtn = [[XMShareBtn alloc]initWithFrame:CGRectMake(spaceWithBgView+i*(btnWith+spaceWithBtn), _web.bottom+50, btnWith, btnHeight)];
        [shareBtn setTitle:title[i] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:iconImg[i]] forState:UIControlStateNormal];
        shareBtn.tag = i+100;
        [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:shareBtn];
    }
}

- (void)shareBtnClick:(UIButton*)sender
{
    if (sender.tag ==100){
        NSLog(@"微信分享被点击啦");
    }else if (sender.tag == 101){
        NSLog(@"朋友圈分享被点击啦");
    }else if (sender.tag == 102){
        NSLog(@"微博分享被点击啦");
    }
}
- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 设置进度条
 */
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    

    NSLog(@"加载完成啦");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //添加微信 朋友圈 微博 按钮
        [self addShareBtn];
    });
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    self.urlStr = request.URL.absoluteString;
    NSLog(@"%@",self.urlStr);
    return  YES;
}

@end
