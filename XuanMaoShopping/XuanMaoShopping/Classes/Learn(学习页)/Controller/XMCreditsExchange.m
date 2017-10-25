//
//  XMCreditsExchange.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/23.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMCreditsExchange.h"
#import "XMCreditsExchangeTableViewCell.h"
#import "XMLearnVideoViewController.h"

@interface XMCreditsExchange ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_videoArray;
}

@end

@implementation XMCreditsExchange


- (void)viewDidLoad {
    [super viewDidLoad];

    _videoArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
 tableView
 */
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"XMCreditsExchangeTableViewCell" bundle:nil] forCellReuseIdentifier:@"XMCreditsExchangeTableViewCell"];
    [self.view addSubview:_tableView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    backView.backgroundColor = [UIColor clearColor];
    [_tableView setTableHeaderView:backView];
}

#pragma maek - uitableViewDelegate -uitableViewDateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _videoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 285;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"XMCreditsExchangeTableViewCell";
    XMCreditsExchangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMLearnVideoViewController *VC = [[XMLearnVideoViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
@end
