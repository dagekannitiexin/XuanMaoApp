//
//  XMMeMyOrder.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/11.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeMyOrder.h"
#import "XMMeMtOrderViewCell.h"

@interface XMMeMyOrder ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}

@end

@implementation XMMeMyOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatnavigationbar];
    
    //如果无数据
//    [self createEmptyView];
    //有数据
    [self createTableView];
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
    titleLabel.text = @"我的订单";
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
    messageLabel.text = @"暂时还没有定单";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.textColor = XMGaryColor;
    [emptyView addSubview:messageLabel];
    [emptyView addSubview:bgView];
}

/*
 tableView
 */
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = LYBgColor;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XMMeMtOrderViewCell" bundle:nil] forCellReuseIdentifier:@"XMMeMtOrderViewCell"];
    [self.view addSubview:_tableView];
}

#pragma maek - uitableViewDelegate -uitableViewDateSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 198;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = LYBgColor;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"XMMeMtOrderViewCell";
    XMMeMtOrderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[XMMeMtOrderViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.orderState.text = @"已完成";
    cell.orderState.textColor = [UIColor blackColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
@end
