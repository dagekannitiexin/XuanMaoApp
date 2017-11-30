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
#import "XMLearnVideoListModel.h"

@interface XMCreditsExchange ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    NSMutableArray *_videoArray;
}

@property (nonatomic ,strong)XMLearnVideoListModel *listModel;

@end

@implementation XMCreditsExchange


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self cerateNetWork];
//    _videoArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/*
 主网络请求
 */
- (void)cerateNetWork
{
    //设置常用参数
    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
    [requestInfo setValue:@"10" forKey:@"page.pagesize"];
    [requestInfo setValue:@"1" forKey:@"page.pageIndex"];
    
    NSString *netPath = [NSString stringWithFormat:@"%@%@",kBaseURL,@"/smartapi/api/Product/getProductList"];
    __weak XMCreditsExchange *weakSelf = self;
    [XM_AppDelegate.engine sendRequesttoSLT:requestInfo portPath:netPath Method:@"GET" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        NSLog(@"%@",aDictronaryBaseObjects);
        weakSelf.listModel = [XMLearnVideoListModel mj_objectWithKeyValues:[aDictronaryBaseObjects objectForKey:@"Rdt"]];
        
        //初始化tabview
        [weakSelf createTableView];

    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
}

/*
 tableView
 */
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
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
    return self.listModel.ReData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 285;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"XMCreditsExchangeTableViewCell";
    XMCreditsExchangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.listModel = self.listModel.ReData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMLearnVideoViewController *VC = [[XMLearnVideoViewController alloc]init];
    VC.URLString = @"http://flv.bn.netease.com/videolib3/1710/31/tbNPI5923/SD/movie_index.m3u8";
    [self.navigationController pushViewController:VC animated:YES];
}
@end
