//
//  XMMeViewController.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeViewController.h"
#import "XMMeHeadStyleView.h"
#import "XMMeCellStyleOne.h"
//跳转到下列控制器
#import "XMMeMessageCenter.h"
#import "XMMeMyOrder.h"
#import "XMMeGroupBuy.h"
#import "XMMeFollowing.h"

@interface XMMeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_arrayWithTitlte;
    NSArray *_arrayWithTitleTwo;
    NSArray *_arrayWithTitleThree;
    NSArray *_arrayWithImg;
    NSArray *_arrayWithImgTwo;
    NSArray *_arrayWithImgThree;
}

@end

@implementation XMMeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrayWithTitlte = [NSArray arrayWithObjects:@"消息中心",@"我的订单",@"我的拼团",@"我的关注",@"我的喜欢", nil];
    _arrayWithImg = [NSArray arrayWithObjects:@"iconMeMessage",@"iconMeOrder",@"iconGroupBuy",@"iconMeFollowing",@"iconMeLike",nil];
    
    _arrayWithTitleTwo = [NSArray arrayWithObjects:@"分享有奖",@"优惠券", nil];
    _arrayWithImgTwo = [NSArray arrayWithObjects:@"iconMeGift",@"iconMeCoupon", nil];
    
    _arrayWithTitleThree = [NSArray arrayWithObjects:@"联系客服",@"供应商入驻申请",@"买手入驻申请",@"管理地址",@"设置", nil];
    _arrayWithImgThree = [NSArray arrayWithObjects:@"iconMeService",@"iconMeSupplier",@"iconBuyerApplication",@"iconMeAddress",@"iconMeSetting", nil];
    //设置导航栏
    [self creatnavigationbar];
    
    //创建头部视图  暂时不需要
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
}

/*
 头部图
 */
- (void)initHeadView
{
    
}

-(void)initTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    [self.view addSubview:_tableView];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XMMeHeadStyleView" bundle:nil] forCellReuseIdentifier:@"CellStyleOne"];
    [_tableView registerNib:[UINib nibWithNibName:@"XMMeCellStyleOne" bundle:nil] forCellReuseIdentifier:@"CellDefault"];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - UITableViewDelegate UITableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0){
        return _arrayWithTitlte.count;
    }else if (section ==1){
        return _arrayWithTitleTwo.count;
    }else{
        return _arrayWithTitleThree.count;
    }
    
}

//footView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0){
        return 0;
    }else {
        return 30;
    }
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headView.backgroundColor = [UIColor whiteColor];
    return headView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 144.0;
    }else {
        return 62.0;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0 && indexPath.section ==0){
        static NSString *identifier = @"CellStyleOne";
        XMMeHeadStyleView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell){
            cell = [[XMMeHeadStyleView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        static NSString *identifier = @"CellDefault";
        XMMeCellStyleOne *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell){
            cell = [[XMMeCellStyleOne alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        //判断标题 section
        if (indexPath.section ==0){
            cell.titleLabel.text = _arrayWithTitlte[indexPath.row-1];
            cell.iconImg.image = [UIImage imageNamed:_arrayWithImg[indexPath.row-1]];
        }else if (indexPath.section ==1){
            cell.titleLabel.text = _arrayWithTitleTwo[indexPath.row];
            cell.iconImg.image = [UIImage imageNamed:_arrayWithImgTwo[indexPath.row]];
        }else if (indexPath.section ==2){
            cell.titleLabel.text = _arrayWithTitleThree[indexPath.row];
            cell.iconImg.image = [UIImage imageNamed:_arrayWithImgThree[indexPath.row]];
        }
        
        return cell;
    }
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //分组点击事件触发
    if (indexPath.section ==0){
        
        if (indexPath.row == 1){ //消息中心
            XMMeMessageCenter *VCMessage = [[XMMeMessageCenter alloc]init];
            [self.navigationController pushViewController:VCMessage animated:YES];
        }else if (indexPath.row == 2){//我的订单
            XMMeMyOrder *VCOrder = [[XMMeMyOrder alloc]init];
            [self.navigationController pushViewController:VCOrder animated:YES];
        }else if (indexPath.row == 3){ //我的拼团
            XMMeGroupBuy *VCGroup = [[XMMeGroupBuy alloc]init];
            [self.navigationController pushViewController:VCGroup animated:YES];
        }else if (indexPath.row == 4){ //我的关注
            XMMeFollowing *VCFollow = [[XMMeFollowing alloc]init];
            [self.navigationController pushViewController:VCFollow animated:YES];
        }
    }
}
@end
