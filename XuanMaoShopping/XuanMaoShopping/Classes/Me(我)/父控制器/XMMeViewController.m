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

@interface XMMeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSArray *_arrayWithTitlte;
}

@end

@implementation XMMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrayWithTitlte = [NSArray arrayWithObjects:@"消息中心",@"我的订单",@"我的拼团",@"我的关注",@"我的喜欢", nil];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
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
    if (indexPath.row ==0){
        static NSString *identifier = @"CellStyleOne";
        XMMeHeadStyleView *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell){
            cell = [[XMMeHeadStyleView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;
    }else {
        static NSString *identifier = @"CellDefault";
        XMMeCellStyleOne *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell){
            cell = [[XMMeCellStyleOne alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.titleLabel.text = _arrayWithTitlte[indexPath.row-1];
        if (indexPath.row == 4){
            cell.detailfootLabel.hidden = NO;
        }
        
        return cell;
    }
}
@end
