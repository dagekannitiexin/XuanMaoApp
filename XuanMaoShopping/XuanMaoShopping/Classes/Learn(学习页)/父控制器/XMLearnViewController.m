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
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 46)];
    titleLabel.text = @"商学院";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    [self.view addSubview:_tableView];
    
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setTableHeaderView:_headView];

}

- (void)initHeadView
{
    //headView
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = MRGlobalBg;
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
    
    CGFloat btnrecommendedW = 90;
    CGFloat btnrecommendedH = 125;
    CGFloat recommendedspace = 15;
    for (int i=0; i<_activeArray.count; i++) {
        HeadButton *btn = [[HeadButton alloc]initWithFrame:CGRectMake(5 + (btnrecommendedW+recommendedspace)*i, 20, btnrecommendedW, btnrecommendedH)];
        btn.tag = i+100;
        [btn setImage:[UIImage imageNamed:@"Img_default"] forState:UIControlStateNormal];
        [btn setTitle:[_activeArray objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = i+100;
        [btn addTarget:self action:@selector(activeBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [activeView addSubview:btn];
        activeView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame)+20, activeView.height);
    }
    _totleHeight = _totleHeight +activeView.height;
    return activeView;
}

- (UIView*)madeHeadViewThree
{
    XMLearnStyleTitleView *titleView = [[XMLearnStyleTitleView alloc]initWithFrame:CGRectMake(0, _totleHeight, SCREEN_WIDTH, 60)];
    titleView.titleLabel.text =@"最热买手";
    titleView.backgroundColor = [UIColor whiteColor];
    _totleHeight = _totleHeight +titleView.height+50;
    return titleView;
}

#pragma mark - btnClick
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
