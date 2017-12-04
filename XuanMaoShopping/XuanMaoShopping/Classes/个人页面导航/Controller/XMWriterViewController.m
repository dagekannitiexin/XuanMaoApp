//
//  XMWriterViewController.m
//  XuanMaoShopping
//
//  Created by apple on 2017/12/2.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMWriterViewController.h"
#import "WMPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "XMProductViewTableViewCell.h"

@interface XMWriterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    WMPlayer    *wmPlayer;
    UIView      *_headView;
    CGFloat  _heigLight;
}

@property (nonatomic,strong)MPMoviePlayerController *moviePlayerController;
@property (nonatomic,strong)UITapGestureRecognizer *tap;

@end

@implementation XMWriterViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //处理navigationBar
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTableView];
    [self createTableHead];
    [self createNavigation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)createTableHead
{
    _headView = [[UIView alloc]initWithFrame:CGRectZero];
    _headView.origin = CGPointZero;
    _headView.backgroundColor = [UIColor whiteColor];
    [_tableView setTableHeaderView:_headView];
    
    //头部播放视频
    [self addVideoView];
    //icon
    [self addIconImg];
    
    //重设容器大小
    _headView.size = CGSizeMake(SCREEN_WIDTH, _heigLight);
}

//video one
- (void)addVideoView
{
    UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/16*9)];
    tapView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:tapView];
    //路径
    self.moviePlayerController.contentURL = [NSURL URLWithString:@"https://oexd4utdf.qnssl.com/FjwGJ9GxGd7jVSfED8RKlArPCdH6"];
    [tapView addSubview:self.moviePlayerController.view];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moviewStopOrPlay)];
    [tapView addGestureRecognizer:self.tap];
    [self.moviePlayerController play];
    
    _heigLight = _heigLight + tapView.height;
}

//iconImg  and 简介
- (void)addIconImg
{
    UIView *iconViwe = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    iconViwe.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    iconViwe.centerY = _heigLight;
    [_headView addSubview:iconViwe];
    
    UIImageView *iconPlace = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 147, 168)];
    iconPlace.image = [UIImage imageNamed:@"iconRecommendNormal"];
    iconPlace.contentMode = UIViewContentModeScaleAspectFill;
    iconPlace.centerY = iconViwe.height/2;
    [iconViwe addSubview:iconPlace];
    
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 85, 85)];
    iconImg.layer.cornerRadius = iconImg.width/2;
    iconImg.clipsToBounds = YES;
    [iconImg sd_setImageWithURL:[NSURL URLWithString:@"https://oexd4utdf.qnssl.com/c1cafd9060248ce520dc_500_500.png"]];
    iconImg.center = iconPlace.center;
    [iconViwe addSubview:iconImg];
    
    //name
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconImg.left, iconImg.bottom+20, 200, 30)];
    nameLabel.numberOfLines = 1;
    nameLabel.text = @"爱生活的马克君";
    nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:27];
    nameLabel.textColor = [UIColor blackColor];
    [iconViwe addSubview:nameLabel];
    
    //关注按钮
    UIButton *guanzhuBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 65, 30)];
    guanzhuBtn.right = SCREEN_WIDTH-20;
    guanzhuBtn.centerY = nameLabel.centerY;
    [guanzhuBtn setTitle:@"已关注" forState:UIControlStateNormal];
    [guanzhuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [iconViwe addSubview:guanzhuBtn];
    
    //关注人数
    UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.x, nameLabel.bottom+15, 100, 15)];
    numLabel.numberOfLines = 1;
    numLabel.text = @"107.3万人关注";
    numLabel.font = [UIFont systemFontOfSize:12];
    numLabel.textColor = [UIColor blackColor];
    [iconViwe addSubview:numLabel];
    
    //图标
    UIImageView *markImg = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.x-5, numLabel.bottom +10, 25, 30)];
    markImg.image = [UIImage imageNamed:@"iconBuyerGrade"];
    markImg.contentMode = UIViewContentModeScaleAspectFill;
    [iconViwe addSubview:markImg];
    
    UILabel *markLabel = [[UILabel alloc]initWithFrame:CGRectMake(markImg.right +10, 0, 100, 15)];
    markLabel.centerY = markImg.centerY;
    markLabel.numberOfLines = 1;
    markLabel.text = @"微道认证优质导师";
    markLabel.textColor = RGBACOLOR(248, 210, 109, 1);
    markLabel.font = [UIFont systemFontOfSize:12];
    [iconViwe addSubview:markLabel];
    
    //detail
    UILabel *introduce = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.x, markLabel.bottom +10, SCREEN_WIDTH -20-nameLabel.x, 100)];
    introduce.numberOfLines = 0;
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:10];
    NSString  *introduceString = @"微博：@爱生活的马克君 \n主理人：马克君，一个喜欢入手各种各样生活好物的男青年，每天8点10分更新。只推荐最具性价比的好物，我的实拍实测，希望你能让你的生活更有品";
    NSMutableAttributedString  *setString = [[NSMutableAttributedString alloc] initWithString:introduceString];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [introduceString length])];
    
    // 设置Label要显示的text
    [introduce  setAttributedText:setString];
    introduce.textColor = RGBACOLOR(171, 171, 171, 1);
    introduce.font = [UIFont systemFontOfSize:14];
    [iconViwe addSubview:introduce];
    
    //添加横线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(introduce.x, introduce.bottom +15, SCREEN_WIDTH-introduce.x, 1)];
    lineView.backgroundColor = RGBACOLOR(171, 171, 171, 0.3);
    [iconViwe addSubview:lineView];
    
    _heigLight = _heigLight + lineView.bottom -100 +15;
}

/*
 创建导航栏
 */
- (void)createNavigation
{
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(16, 30, 22, 44)];
    [backBtn setImage:[UIImage imageNamed:@"Back Chevron"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"Back Helight"] forState:UIControlStateHighlighted];
    [self.view addSubview:backBtn];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    [shareBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:shareBtn];
}

- (MPMoviePlayerController *)moviePlayerController
{
    if (!_moviePlayerController) {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        _moviePlayerController.view.backgroundColor = [UIColor whiteColor];
        _moviePlayerController.movieSourceType = MPMovieControlStyleEmbedded;
        _moviePlayerController.controlStyle = MPMovieControlStyleNone;
        _moviePlayerController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/16*9);
        [_moviePlayerController setFullscreen:NO];
        [_moviePlayerController setShouldAutoplay:YES];
        _moviePlayerController.initialPlaybackTime = -1.0;
        _moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
        [_moviePlayerController setRepeatMode:MPMovieRepeatModeOne];
    }
    return _moviePlayerController;
}

- (void)moviewStopOrPlay
{
    MPMoviePlaybackState state = self.moviePlayerController.playbackState;
    
    if (state ==MPMoviePlaybackStatePlaying){
        [_moviePlayerController pause];
    }else if (state ==MPMoviePlaybackStatePaused){
        [_moviePlayerController play];
    }
}
#pragma maek - uitableView  Delegate DataSource
- (void)createTableView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.alwaysBounceVertical = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"XMProductViewTableViewCell" bundle:nil] forCellReuseIdentifier:@"productCell"];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 365;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"productCell";
    XMProductViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell){
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//禁止下拉刷新
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y <= 100) {
        _tableView.bounces = NO;
    }
    else
    {
        _tableView.bounces = YES;
    }
}
@end
