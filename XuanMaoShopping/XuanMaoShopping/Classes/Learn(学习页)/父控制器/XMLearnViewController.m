//
//  XMLearnViewController.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLearnViewController.h"
#import "SDCycleScrollView.h"
#import "PGIndexBannerSubiew.h"
#import "NewPagedFlowView.h"
#import "HeadButton.h"
#import "XMLearnStyleTitleView.h"
#import "XMLearnStyleViewTwo.h"
#import "XMLearnStyleViewFour.h"
#import "XMFootLineView.h"
#import "NewShakeViewController.h"
#import "SignViewController.h"
#import "XMArticleViewController.h"
#import "XMCreditsExchange.h"




@interface XMLearnViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UIViewControllerTransitioningDelegate>{
    CGFloat _totleHeight;
    UITableView *_tableView;
    UIView *_headView;
    
    NewPagedFlowView *_pageFlowView;
    NSMutableArray *_activeArray;
    NSMutableArray *_imageArray; //bannerImg
    NSMutableArray *_urlBannerArray;//bannerUrl
    NSMutableArray *_urlRecommend; //推荐栏目的urlImg
    NSArray        *_modelOfHotPeoPle; //最热买手
    NSArray        *_modelOfNewPeoPle; //最新买手
    NSMutableArray *_urlWithMeiZhuang; //美妆鉴赏
}

@end

@implementation XMLearnViewController


#pragma mark - init

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //banner
    [self ccreateData];
    [self createNetWork];
    //设置导航栏
    
    UIImageView *dragon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2, 64, 40, 40)];
    dragon.image = [UIImage imageNamed:@"dragon"];
    [self.view addSubview:dragon];
    
//    //创建头部视图
//    [self initHeadView];
//
//    //初始化tabview
//    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = LYBgColor;
 _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setTableHeaderView:_headView];
    //设置上下拉刷新
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
//
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerViewRefresh)];
//    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerViewRefresh)];
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作.
    }];
    gifHeader.stateLabel.hidden = NO;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    [gifHeader setImages:@[[UIImage imageNamed:@"dragon1"]] forState:MJRefreshStateIdle];
    [gifHeader setImages:@[[UIImage imageNamed:@"dragon2"]] forState:MJRefreshStatePulling];
    [gifHeader setImages:@[[UIImage imageNamed:@"dragon1"],[UIImage imageNamed:@"dragon2"]] duration:0.5 forState:MJRefreshStateRefreshing];
    [gifHeader setRefreshingTarget:self refreshingAction:@selector(headerViewRefresh)];
    _tableView.mj_header = gifHeader;
}

- (void)initHeadView
{
    //headView
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    _totleHeight = 0; //设置总head高度
    
    //创建轮转图
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH, SCREEN_WIDTH/2)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    
#warning 假设产品需求左右卡片间距30，底部对齐
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    
    pageFlowView.orginPageCount = _imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24, SCREEN_WIDTH, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    _pageFlowView = pageFlowView;
    [_headView addSubview:pageFlowView];
    [pageFlowView reloadData];
    _totleHeight = _totleHeight +_pageFlowView.bottom;
    
    // 添加第二个view
    [_headView addSubview:[self madeHeadViewTwo]];
    
    // 添加第三个view
    [_headView addSubview:[self madeHeadViewThree]];
    
    //添加第四个view
    [_headView addSubview:[self madeHeadViewFour]];
    
    //填加一个底线
    [_headView addSubview:[self addFootLineView]];
    
    //最后统计_headView大小
    _headView.frame = CGRectMake(0, 64, SCREEN_WIDTH, _totleHeight);
    [self.view addSubview:_headView];
}

//2view
- (UIView*)madeHeadViewTwo
{
    //创建活动栏
    UIScrollView *activeView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _totleHeight+15, SCREEN_WIDTH, 90)];
    activeView.backgroundColor = [UIColor whiteColor];
    activeView.showsVerticalScrollIndicator = FALSE;
    activeView.showsHorizontalScrollIndicator = FALSE;
    activeView.alwaysBounceHorizontal = YES;
    activeView.layer.masksToBounds = YES;
    [_headView addSubview:activeView];
    
    CGFloat btnrecommendedW = 50;
    CGFloat btnrecommendedH = 70;
    CGFloat recommendedspace = (SCREEN_WIDTH -2*20-4*btnrecommendedW)/3;
    for (int i=0; i<_activeArray.count; i++) {
        HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake(20 + (btnrecommendedW+recommendedspace)*i, 0, btnrecommendedW, btnrecommendedH)];
        btn.tag = i+100;
        [btn sd_setImageWithURL:[NSURL URLWithString:_urlRecommend[i]] forState:UIControlStateNormal];
        [btn setTitle:[_activeArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(activeBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.imageView.layer.cornerRadius = btnrecommendedW/2;
        btn.imageView.clipsToBounds = YES;
        [activeView addSubview:btn];
        activeView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame)+20, activeView.height);
    }
    _totleHeight = _totleHeight +activeView.height;
    return activeView;
}

- (UIView*)madeHeadViewThree
{
    UIView *headViewThree = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 290)];
    headViewThree.backgroundColor = XMBgColor;
    
    //添加背景板
    UIImageView *backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headViewThree.width, headViewThree.height)];
    backImg.image = [UIImage imageNamed:@"bgWhiteGradient"];
    [headViewThree addSubview:backImg];
    
    XMLearnStyleTitleView *titleView = [[XMLearnStyleTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    titleView.titleLabel.text =@"最热导师";
    titleView.backgroundColor = [UIColor whiteColor];
    [headViewThree addSubview:titleView];
    
    //滚动介绍栏
    CGFloat hostW = 230;
    CGFloat hostH = 230;
    CGFloat hostSpace = 15;
    CGFloat hostViewSpace = 10;
    
    UIScrollView *hostScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleView.bottom, SCREEN_WIDTH, headViewThree.height-titleView.bottom)];
    hostScrView.backgroundColor = [UIColor clearColor ];
    hostScrView.showsVerticalScrollIndicator = FALSE;
    hostScrView.showsHorizontalScrollIndicator = FALSE;
    hostScrView.alwaysBounceHorizontal = YES;
    hostScrView.layer.masksToBounds = YES;
    [headViewThree addSubview:hostScrView];
    
    
    
    for (int i=0; i<_modelOfHotPeoPle.count; i++) {
        XMLearnStyleViewTwo *hostView = [[[NSBundle mainBundle]loadNibNamed:@"XMLearnStyleViewTwo" owner:nil options:nil]lastObject];
        hostView.origin = CGPointMake(hostSpace +(hostW+hostViewSpace)*i, 0);
        [hostScrView addSubview:hostView];
        hostScrView.contentSize = CGSizeMake(hostView.right+20, hostH);
        
        //赋值
        NSDictionary *dicHost = _modelOfHotPeoPle[i];
        [hostView.backImg sd_setImageWithURL:[NSURL URLWithString:[dicHost objectForKey:@"buyerTabBg"]]];
        [hostView.iconImg sd_setImageWithURL:[NSURL URLWithString:[dicHost objectForKey:@"icon"]]];
        hostView.hostTitle.text = [NSString stringWithFormat:@"%@",[dicHost objectForKey:@"name"]];
        hostView.hostDescribe.text = [NSString stringWithFormat:@"%@",[dicHost objectForKey:@"summary"]];
        
        NSArray *array = [dicHost objectForKey:@"labels"];
        [hostView setlabelOfHost:array];
    }
    
    
    _totleHeight = _totleHeight +headViewThree.height;
    return headViewThree;
}

- (UIView*)madeHeadViewFour
{
    //微调_totleHeight
    _totleHeight = _totleHeight-10;
    UIView *headViewFour = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 200)];
    headViewFour.backgroundColor = [UIColor yellowColor];
    
    XMLearnStyleTitleView *titleView = [[XMLearnStyleTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    titleView.titleLabel.text =@"🔥爆课程";
    titleView.backgroundColor = [UIColor whiteColor];
    [headViewFour addSubview:titleView];
    
    for (int i=0; i<_modelOfNewPeoPle.count; i++) {
        XMLearnStyleViewFour *viewFour = [[[NSBundle mainBundle]loadNibNamed:@"XMLearnStyleViewFour" owner:nil options:nil]lastObject];
        viewFour.origin = CGPointMake(0, titleView.bottom+viewFour.height*i);
        viewFour.width = SCREEN_WIDTH;
        
        //赋值
        NSDictionary *dicHost = _modelOfNewPeoPle[i];
        [viewFour.bagView sd_setImageWithURL:[NSURL URLWithString:[dicHost objectForKey:@"buyerTabBg"]]];
        [viewFour.iconImg sd_setImageWithURL:[NSURL URLWithString:[dicHost objectForKey:@"background"]]];
        viewFour.title.text = [NSString stringWithFormat:@"%@",[dicHost objectForKey:@"name"]];
        viewFour.descLabel.text = [NSString stringWithFormat:@"%@",[dicHost objectForKey:@"summary"]];
        viewFour.numberOfArticle.text = [NSString stringWithFormat:@"%@",[dicHost objectForKey:@"reviewcount"]];
        NSArray *array = [dicHost objectForKey:@"labels"];
        [viewFour createLabel:array];
        
        
        NSArray *array2 = [dicHost objectForKey:@"reviews"];
        [viewFour createImg:array2];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailAltcter)];
        [viewFour addGestureRecognizer:tap];
        
        [headViewFour addSubview:viewFour];
        
        headViewFour.size = CGSizeMake(SCREEN_WIDTH, viewFour.bottom);
        
    }
    _totleHeight = _totleHeight +headViewFour.height;
    return headViewFour;
}

- (UIView*)addFootLineView
{
    UIView *footLineView = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 200)];
    footLineView.backgroundColor = RGBACOLOR(231, 231, 231, 1);
    UIView *dixian = [[[NSBundle mainBundle]loadNibNamed:@"XMFootLineView" owner:nil options:nil]lastObject];
    [footLineView addSubview:dixian];
    return footLineView;
}

#pragma mark - btnClick
- (void)headerViewRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_tableView.mj_header endRefreshing];
    });
}

- (void)footerViewRefresh
{

}

- (void)activeBtnclick:(UIButton*)sender
{
    if (sender.tag ==100){
//        //摇一摇
//        NewShakeViewController * shake = [[NewShakeViewController alloc] init];
//        shake.title = @"摇一摇";
//        [self.navigationController pushViewController:shake animated:YES];
        //美妆鉴赏
        NSString * tag = @"没有tag";
        NSString * out_url = _urlWithMeiZhuang[0];
        NSString * type = @"美妆鉴赏";
        [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:self.navigationController];
    }else if (sender.tag ==101){
  
        NSString * tag = @"没有tag";
        NSString * out_url = _urlWithMeiZhuang[1];
        NSString * type = @"专题栏";
        [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:self.navigationController];
    }else if (sender.tag == 102){
        XMCreditsExchange *credits = [[XMCreditsExchange alloc]init];
        credits.title = @"变美视频";
        [self.navigationController pushViewController:credits animated:YES];
//        NSString * tag = @"没有tag";
//        NSString * out_url = _urlWithMeiZhuang[2];
//        NSString * type = @"变美视频";
//        [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:self.navigationController];
    }else if (sender.tag ==103){
        NSString * tag = @"没有tag";
        NSString * out_url = _urlWithMeiZhuang[3];
        NSString * type = @"大牌试用";
        [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:self.navigationController];
    }
}

#pragma mark --NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSString * tag = @"没有tag";
    NSString * out_url = _urlBannerArray[subIndex];
    NSString * type = @"banner";
    [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:self.navigationController];
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
}

#warning 假设产品需求左右中间页显示大小为 Width - 50, (Width - 50) * 9 / 16
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 50, (SCREEN_WIDTH - 50) * 9 / 16);
}
#pragma mark --NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return _imageArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
//      [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:_imageArray[index]] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    NSArray *array = [NSArray arrayWithObjects:@"_DSC3849",@"37877_20151208",@"37888_20151208",@"20170223微商-化妆品00106",@"20170223微商-化妆品00166",@"乳液03", nil];
    bannerView.mainImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",array[index]]];
//    bannerView.mainImageView.image = _imageArray[index];
    
    return bannerView;
}

#pragma mark - detailAlter
- (void)detailAltcter
{
    XMArticleViewController *article = [[XMArticleViewController alloc]init];
    [self.navigationController pushViewController:article animated:YES];
}

#pragma mark  - 假数据
- (void)ccreateData
{
    _imageArray = [NSMutableArray arrayWithObjects:@"http://img0.cosmeapp.com/product/201710/10/10/59/59dc37a3525d2452.jpg",@"http://img0.cosmeapp.com/product/201710/26/18/25/59f1b8003d86d798.jpg",@"http://img0.cosmeapp.com/product/201710/30/17/18/59f6ee63a619d938.jpg",@"http://img0.cosmeapp.com/product/201710/31/16/58/59f83b3b016ef967.jpg",@"http://img0.cosmeapp.com/product/201710/31/18/58/59f85744a2f44188.jpg",@"http://img0.cosmeapp.com/product/201711/01/10/48/59f936151d677883.jpg", nil];
    
    _urlBannerArray = [NSMutableArray arrayWithObjects:@"https://h5.cosmeapp.com/group/thread/292433?stats_type=bbsthread&stats_data=292433",@"https://h5.cosmeapp.com/group/thread/293726?stats_type=bbsthread&stats_data=293726",@"https://h5.cosmeapp.com/group/thread/293974?stats_type=bbsthread&stats_data=293974",@"https://h5.cosmeapp.com/group/thread/294079?stats_type=bbsthread&stats_data=294079",@"http://h5.cosmeapp.com/article/detail/295",@"https://h5.cosmeapp.com/group/thread/294149?stats_type=bbsthread&stats_data=294149", nil];
    
    _activeArray   = [NSMutableArray arrayWithObjects:@"美妆鉴赏",@"专题",@"变美视频",@"大牌试用", nil];
    
    _urlRecommend  = [NSMutableArray arrayWithObjects:@"http://img0.cosmeapp.com/FulPtuDJpHpmjRa-VUUceTRjQZUJ",@"http://img0.cosmeapp.com/Frq7O6Ip9MhAI98oUuH0aFBKi0aZ",@"http://img0.cosmeapp.com/FkIaA6pmXaHaceUUxVH87S6fdFBm",@"http://img0.cosmeapp.com/FuKpvsn6eQ4bB0Jg5h8zWLc-dr5q", nil];
    
    _urlWithMeiZhuang = [NSMutableArray arrayWithObjects:@"https://public.cosmeapp.com/mapp/ranklist/2017m/list.html",
        @"https://h5.cosmeapp.com/pgc/hot-thread",
         @"https://h5.cosmeapp.com/pgc/new-video",
         @"https://h5.cosmeapp.com/try/list",
                         nil];
}

- (void)createNetWork
{
    //设置常用参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:@"G99NrwRHnT1N3aQzV8TOIZZJ" forKey:@"token"];
    NSString *netPath = [NSString stringWithFormat:@"%@",@"api.xinpinget.com/buyermarket/list"];
    [XM_AppDelegate.engine sendRequesttoSLT:requestInfo portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        NSDictionary *dicOne = [aDictronaryBaseObjects objectForKey:@"result"][0];
        NSDictionary *dicPeoPle = [dicOne objectForKey:@"channelItem"];
        NSArray *arrayChannel = [dicPeoPle objectForKey:@"channels"];
        _modelOfHotPeoPle = arrayChannel;
        
        NSArray *arrayNewBuy = [[[aDictronaryBaseObjects objectForKey:@"result"][1]objectForKey:@"channelItem"]objectForKey:@"channels"];
        _modelOfNewPeoPle = arrayNewBuy;
        //创建头部视图
        [self initHeadView];
        
        //初始化tabview
        [self initTableView];
    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
}
@end

