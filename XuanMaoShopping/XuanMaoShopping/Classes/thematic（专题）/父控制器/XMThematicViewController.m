//
//  XMThematicViewController.m
//  XuanMaoShopping
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMThematicViewController.h"
#import "XMThematilOfficialCell.h"

@interface XMThematicViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView  *_tableView;
    UIScrollView *_headView;
    NSArray      *_wetArray;
    NSArray      *_urlImg;
}

@end

@implementation XMThematicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //处理数据
    [self loadData];
    [self createHeadView];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)loadData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PublicSFTResources" ofType:@"plist"];
    _wetArray = [NSArray arrayWithContentsOfFile:path];
    _urlImg = [NSArray arrayWithObjects:@"https://img0.cosmeapp.com/FryatMdcb8bqeV00Ytb91Y-CaUuJ",@"https://img0.cosmeapp.com/FgtNd-6HqsFeR8gS7SFXZ1iAJLhK",@"https://img0.cosmeapp.com/Fk7Jqcog8gWUIALCFTbJeur0a73I",@"https://img0.cosmeapp.com/Fl0161g1xwiwbXWuOrWKTmA2esLo",@"https://img0.cosmeapp.com/FriVc4UYIQ3n5N2WH9lvsbHlkVm6",@"https://img0.cosmeapp.com/Fgog3pb1UZzmYqdDD3kay4WNqU8h",@"https://img0.cosmeapp.com/Fl1K88p4qveDxqpi135bkdy_0q1d",@"https://img0.cosmeapp.com/Fk96TyHs7wZ06bPSvuJ2vyWUX_ao", nil];
}

- (void)createHeadView{
    _headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95)];
    _headView.backgroundColor = [UIColor whiteColor];
    _headView.showsVerticalScrollIndicator = FALSE;
    _headView.showsHorizontalScrollIndicator = FALSE;
    _headView.alwaysBounceHorizontal = YES;
    _headView.layer.masksToBounds = YES;
    
    CGFloat btnrecommendedW = 135;
    CGFloat btnrecommendedH = 75;
    CGFloat recommendedspace = 10;
    for (int i =0; i<_urlImg.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15 + (btnrecommendedW+recommendedspace)*i, 10, btnrecommendedW, btnrecommendedH)];
        [btn sd_setImageWithURL:[NSURL URLWithString:_urlImg[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Img_default"]];
        btn.tag = i+100;
        [btn addTarget:self action:@selector(headBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:btn];
        _headView.contentSize = CGSizeMake(CGRectGetMaxX(btn.frame)+20, _headView.height);
    }
}

- (void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64)];
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView setTableHeaderView:_headView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"XMThematilOfficialCell" bundle:nil] forCellReuseIdentifier:@"ThematilOfficialCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - btnclick
- (void)headBtnclick:(UIButton *)sender{
    
}

#pragma maek - uitableViewDelegate -uitableViewDateSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 368.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _wetArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ThematilOfficialCell";
    XMThematilOfficialCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[XMThematilOfficialCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = _wetArray[indexPath.row];
    cell.writerImg.image = [UIImage imageNamed:@"Img_default"];
    cell.writerName.text = @"首富团推荐";
    [cell.articlesImg sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"img"]]];
    cell.articlesTime.text  = [dic objectForKey:@"date"];
    cell.articlesTitle.text = [dic objectForKey:@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * tag = @"没有tag";
    NSString * out_url = [_wetArray[indexPath.row]objectForKey:@"webUrl"];
    NSString * type = @"专题";
    [Utility goVcForItemId:tag WithURL:out_url WithType:type WithNavGation:self.navigationController];
}
@end
