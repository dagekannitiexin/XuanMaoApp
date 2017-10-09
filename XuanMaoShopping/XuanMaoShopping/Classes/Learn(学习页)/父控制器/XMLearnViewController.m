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

@interface XMLearnViewController ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>{
    CGFloat _totleHeight;
    UITableView *_tableView;
    UIView *_headView;
    NSMutableArray *_imageArray;
    NewPagedFlowView *_pageFlowView;
    NSMutableArray *_activeArray;
}

@end

@implementation XMLearnViewController

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _imageArray = [NSMutableArray array];
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:@"Img_default"];
        [_imageArray addObject:image];
    }
    
    _activeArray = [NSMutableArray arrayWithObjects:@"摇一摇",@"商学院",@"积分兑换",@"团队福利",@"团队公告", nil];
    
    //设置导航栏
    [self creatnavigationbar];
    
    UIImageView *dragon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-40)/2, 64, 40, 40)];
    dragon.backgroundColor = [UIColor yellowColor];
    dragon.image = [UIImage imageNamed:@"dragon"];
    [self.view addSubview:dragon];
    
    //创建头部视图
    [self initHeadView];
    
    //初始化tabview
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)creatnavigationbar
{
    self.title = @"商学院";
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = LYBgColor;
 _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setTableHeaderView:_headView];
    //设置上下拉刷新
//    _tableView.estimatedRowHeight = 100;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerViewRefresh)];
//    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerViewRefresh)];
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作.
    }];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [gifHeader setImages:@[[UIImage imageNamed:@"dragon1"],[UIImage imageNamed:@"dragon2"]] forState:MJRefreshStateRefreshing];
//    [gifHeader setImages:@[[UIImage imageNamed:@"dragon2"]]
//                forState:MJRefreshStateRefreshing];
    _tableView.header = gifHeader;
}

- (void)initHeadView
{
    //headView
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = [UIColor whiteColor];
    _totleHeight = 0; //设置总head高度
    
    //创建轮转图
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH, SCREEN_WIDTH *9/16.0)];
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
    UIScrollView *activeView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 80)];
    activeView.backgroundColor = [UIColor whiteColor];
    activeView.showsVerticalScrollIndicator = FALSE;
    activeView.showsHorizontalScrollIndicator = FALSE;
    activeView.alwaysBounceHorizontal = YES;
    activeView.layer.masksToBounds = YES;
    [_headView addSubview:activeView];
    
    CGFloat btnrecommendedW = 60;
    CGFloat btnrecommendedH = 81;
    CGFloat recommendedspace = (SCREEN_WIDTH -2*15-5*btnrecommendedW)/4;
    for (int i=0; i<_activeArray.count; i++) {
        HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake(15 + (btnrecommendedW+recommendedspace)*i, 0, btnrecommendedW, btnrecommendedH)];
        btn.tag = i+100;
        [btn setImage:[UIImage imageNamed:@"Img_default"] forState:UIControlStateNormal];
        [btn setTitle:[_activeArray objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = i+100;
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
    UIView *headViewThree = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 315)];
    headViewThree.backgroundColor = [UIColor yellowColor];
    
    XMLearnStyleTitleView *titleView = [[XMLearnStyleTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    titleView.titleLabel.text =@"最热买手";
    titleView.backgroundColor = [UIColor whiteColor];
    [headViewThree addSubview:titleView];
    
    //滚动介绍栏
    CGFloat hostW = 230;
    CGFloat hostH = 230;
    CGFloat hostSpace = 15;
    CGFloat hostViewSpace = 10;
    
    UIScrollView *hostScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, titleView.bottom, SCREEN_WIDTH, headViewThree.height-titleView.bottom)];
    hostScrView.backgroundColor = RGBACOLOR(247, 247, 247, 1);
    hostScrView.showsVerticalScrollIndicator = FALSE;
    hostScrView.showsHorizontalScrollIndicator = FALSE;
    hostScrView.alwaysBounceHorizontal = YES;
    hostScrView.layer.masksToBounds = YES;
    [headViewThree addSubview:hostScrView];
    
    
    for (int i=0; i<5; i++) {
        XMLearnStyleViewTwo *hostView = [[[NSBundle mainBundle]loadNibNamed:@"XMLearnStyleViewTwo" owner:nil options:nil]lastObject];
        hostView.origin = CGPointMake(hostSpace +(hostW+hostViewSpace)*i, 0);
        [hostScrView addSubview:hostView];
        hostScrView.contentSize = CGSizeMake(hostView.right+20, hostH);
        
        NSArray *array = [NSArray arrayWithObjects:@"男生护肤",@"男闺蜜推荐",@"真人实测", nil];
        [hostView setlabelOfHost:array];
    }
    
    
    _totleHeight = _totleHeight +headViewThree.height;
    return headViewThree;
}

- (UIView*)madeHeadViewFour
{
    UIView *headViewFour = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 200)];
    headViewFour.backgroundColor = [UIColor yellowColor];
    
    XMLearnStyleTitleView *titleView = [[XMLearnStyleTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    titleView.titleLabel.text =@"推荐买手";
    titleView.backgroundColor = [UIColor whiteColor];
    [headViewFour addSubview:titleView];
    
    for (int i=0; i<10; i++) {
        XMLearnStyleViewFour *viewFour = [[[NSBundle mainBundle]loadNibNamed:@"XMLearnStyleViewFour" owner:nil options:nil]lastObject];
        viewFour.origin = CGPointMake(0, titleView.bottom+viewFour.height*i);
        viewFour.width = SCREEN_WIDTH;
        NSArray *array = [NSArray arrayWithObjects:@"美妆控",@"爱实测",@"爱分享~~", nil];
        [viewFour createLabel:array];
        
        NSArray *array2 = [NSArray arrayWithObjects:@"Img_default",@"Img_default",@"Img_default", nil];
        [viewFour createImg:array2];
        
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
    
}

- (void)footerViewRefresh
{

}

- (void)activeBtnclick:(UIButton*)sender
{

}

#pragma mark --NewPagedFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"CustomViewController 滚动到了第%ld页",pageNumber);
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
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = _imageArray[index];
    
    return bannerView;
}
@end
