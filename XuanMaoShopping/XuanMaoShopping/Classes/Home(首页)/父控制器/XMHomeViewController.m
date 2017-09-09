//
//  XMHomeViewController.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMHomeViewController.h"
#import "SDCycleScrollView.h"
#import "HeadButton.h"
#import "XMGoodsTitleStyleView.h"
#import "goodsViewStyleOne.h"
#import "XMGoodsViewStyleTwoHeadView.h"
#import "XMGoodsViewStyleTwoView.h"
#import "XMGoodsViewStyleThreeView.h"


@interface XMHomeViewController ()<SDCycleScrollViewDelegate>{
    UITableView *_tableView;
    SDCycleScrollView *_lunzhuanView;
    UIView *_headView;
    CGFloat _totleHeight;
    NSMutableArray *_activeArray; //活动视图数据
    NSMutableArray *_goodsThree;  //商品展示数据 viewthree模块
    
}
@end

@implementation XMHomeViewController

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //假数据
    _activeArray = [NSMutableArray arrayWithObjects:@"摇一摇",@"商学院",@"积分兑换",@"团队福利",@"团队公告", nil];
    
    _goodsThree = [NSMutableArray arrayWithObjects:@"切尔西牛皮女靴",@"小馒头  多色双肩包",@"全棉色织磨毛四件套",@"男式基础合体窄脚",@"素风男／女家居产品",@"男士无缝休闲运动",@"女士紧身运动长裤",@"法国麻男士休闲衬衫",nil];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置导航栏背景
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


- (void)creatnavigationbar
{
    
//    self.navigationItem.titleView = [[UIView alloc]init];
    //设置leftBarButtonItem
    UIButton *leftViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,30, 30)];
    [leftViewBtn setImage:[UIImage imageNamed:@"home_PersonalCenter"] forState:UIControlStateNormal];
    [leftViewBtn setBackgroundColor:RGBACOLOR(0, 0, 0, 0.4)];
    leftViewBtn.layer.cornerRadius = leftViewBtn.frame.size.width/2;
    [leftViewBtn addTarget:self action:@selector(leftViewBtnShow) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftViewItem = [[UIBarButtonItem alloc] initWithCustomView:leftViewBtn];
    self.navigationItem.leftBarButtonItem = leftViewItem;
    
    UIButton *rightViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightViewBtn setImage:[UIImage imageNamed:@"shoppingcar"] forState:UIControlStateNormal];
    [rightViewBtn setBackgroundColor:RGBACOLOR(0, 0, 0, 0.4)];
    rightViewBtn.layer.cornerRadius = rightViewBtn.frame.size.width/2;
    [rightViewBtn addTarget:self action:@selector(rightViewBtnShow) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightViewItem = [[UIBarButtonItem alloc] initWithCustomView:rightViewBtn];
    self.navigationItem.rightBarButtonItem = rightViewItem;
    
    // 设置中间导航按钮
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 304, 21)];
    searchBtn.backgroundColor = RGBACOLOR(220, 220,220, 1);
    [searchBtn setTitle:@"搜索代理手机号码、姓名、微信号、店铺名" forState:UIControlStateNormal];
    [searchBtn setImage:[UIImage imageNamed:@"searchTag"] forState:UIControlStateNormal];
    [searchBtn setTitleColor:RGBACOLOR(127, 127, 127, 1) forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    searchBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    searchBtn.layer.cornerRadius = 10.5;
    self.navigationItem.titleView =searchBtn;
    
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    [self.view addSubview:_tableView];
    
    [_tableView setTableHeaderView:_headView];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setTableHeaderView:_headView];
}

/*
 头部图
 */
- (void)initHeadView
{
    //headView
    _headView = [[UIView alloc]init];
    _headView.backgroundColor = XMBgColor;
    _totleHeight = 0; //设置总head高度
    
    //创建轮转图
    __weak XMHomeViewController *weakSelf = self;
    _lunzhuanView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/25*14) imageNamesGroup:[NSArray arrayWithObjects:@"1",@"2",@"3", nil]];
    _lunzhuanView.backgroundColor = [UIColor yellowColor];
    _lunzhuanView.placeholderImage=[UIImage imageNamed:@"Img_default"];
    _lunzhuanView.delegate=self;
    _lunzhuanView.pageControlStyle=SDCycleScrollViewPageContolStyleClassic;
    _lunzhuanView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _lunzhuanView.pageDotColor =RGBACOLOR(19,150,224,0.7);
    _lunzhuanView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        NSLog(@"hah");
    };
    [_headView addSubview:_lunzhuanView];
    _totleHeight = _totleHeight +_lunzhuanView.frame.size.height;
    
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
    
    //将第二个view加入视图
    [_headView addSubview:[self madeHeadViewTwo]];
    
    //第三个view（周1周4新品首发）
    [_headView addSubview:[self madeHeadViewThree]];
    
    //第四个view（人气推荐部分）
    [_headView addSubview:[self madeHeadViewFour]];
    
    //填加一个底线
    [_headView addSubview:[self addFootLineView]];
    //最后统计_headView大小
    _headView.frame = CGRectMake(0, 64, SCREEN_WIDTH, _totleHeight);
}

//品牌制造商直供
- (UIView*)madeHeadViewTwo
{
    //最外层嵌套
    UIView *viewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight+10, SCREEN_WIDTH, 295)];
    viewTwo.backgroundColor = [UIColor whiteColor];
    XMGoodsTitleStyleView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"XMGoodsTitleStyleView" owner:nil options:nil]lastObject];
    titleView.width = SCREEN_WIDTH;
    [viewTwo addSubview:titleView];
    
    
    CGFloat spaceWithCenter = 5.0;
    CGFloat shopViewHeight = 115.0;
    CGFloat spaceWith = 10;
    CGFloat shopViewWith = (SCREEN_WIDTH - spaceWithCenter - 2*spaceWith)/2;
    for (int i =0; i<4; i++) {
        goodsViewStyleOne *shopView = [[[NSBundle mainBundle]loadNibNamed:@"goodsViewStyleOne" owner:nil options:nil]lastObject];
        shopView.width = shopViewWith;
        [viewTwo addSubview:shopView];
        CGPoint viewPoint;
        if (i<=1){
            viewPoint = CGPointMake(spaceWith+i*(shopViewWith+spaceWithCenter), 0);
        }else {
            viewPoint = CGPointMake(spaceWith+(i-2)*(shopViewWith+spaceWithCenter), shopViewHeight+spaceWithCenter);
        }
        shopView.x =viewPoint.x;
        shopView.y =viewPoint.y+titleView.bottom;
    }
    
    // 加10原因是因为存在边线_totleHeight+10 过了
    _totleHeight = _totleHeight +viewTwo.height+10;
    return viewTwo;
}
	
//品牌制造商直供
- (UIView*)madeHeadViewThree
{
    UIView *viewThree = [[UIView alloc]initWithFrame:CGRectMake(0, _totleHeight+10, SCREEN_WIDTH, 385)];
    viewThree.backgroundColor = [UIColor whiteColor];
    
    //头部view
    XMGoodsViewStyleTwoHeadView *shopHeadView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsViewStyleTwoHeadView" owner:nil options:nil]lastObject];
    shopHeadView.width = SCREEN_WIDTH;
    [viewThree addSubview:shopHeadView];
    
    //创建商品视图
    UIScrollView *goodsScr = [[UIScrollView alloc]initWithFrame:CGRectMake(0, shopHeadView.bottom, SCREEN_WIDTH, 256)];
    goodsScr.backgroundColor = [UIColor clearColor];
    goodsScr.showsVerticalScrollIndicator = FALSE;
    goodsScr.showsHorizontalScrollIndicator = FALSE;
    goodsScr.alwaysBounceHorizontal = YES;
    goodsScr.layer.masksToBounds = YES;
    [viewThree addSubview:goodsScr];
    
    //创建scrollerView内部商品视图
    CGFloat shopTwoSapce = 10;
    CGFloat shopTwoWith = 141;
    for (int i = 0;i<_goodsThree.count;i++){
        XMGoodsViewStyleTwoView *shopView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsViewStyleTwoView" owner:nil options:nil]lastObject];
        [goodsScr addSubview:shopView];
        CGPoint orginPoint = CGPointMake(shopTwoSapce+(shopTwoSapce+shopTwoWith)*i, shopTwoSapce);
        shopView.origin = orginPoint;
        goodsScr.contentSize = CGSizeMake(shopView.right+20, goodsScr.height);
    }
    _totleHeight = _totleHeight +viewThree.height+25;
    return viewThree;
}

- (UIView*)madeHeadViewFour
{
    //这个view上面包含灰色界面  orgin：viewfour+10
    UIView *viewFour = [[UIView alloc]init];
    viewFour.backgroundColor = [UIColor whiteColor];
    //标题栏
    XMGoodsTitleStyleView *titleView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsTitleStyleView" owner:nil options:nil]lastObject];
    [viewFour addSubview:titleView];
    
    CGFloat goodsViewHeighSpace = 15;
    CGFloat goodsViewWidthSpace = 15;
    CGFloat goodsViewHeight = 140;
    CGFloat goodsViewWidth = SCREEN_WIDTH -2*goodsViewWidthSpace;
    ;
    for (int i =0; i<10; i++) {
        XMGoodsViewStyleThreeView *goodsView = [[[NSBundle mainBundle]loadNibNamed:@"XMGoodsViewStyleThreeView" owner:nil options:nil]lastObject];
        goodsView.width = goodsViewWidth;
        [viewFour addSubview:goodsView];
        //设置位置
        goodsView.origin = CGPointMake(goodsViewWidthSpace, titleView.bottom+(goodsViewHeight+goodsViewHeighSpace)*i);
        viewFour.frame = CGRectMake(0, _totleHeight+10, SCREEN_WIDTH, goodsView.bottom+15);
    }
    _totleHeight = _totleHeight +viewFour.height+20;
    return viewFour;
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
- (void)activeBtnclick:(UIButton*)sender
{
    
}


@end
