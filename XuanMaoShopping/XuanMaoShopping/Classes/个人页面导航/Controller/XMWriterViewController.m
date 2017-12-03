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

@interface XMWriterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    WMPlayer  *wmPlayer;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)createTableHead
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectZero];
    headView.origin = CGPointZero;
    [_tableView setTableHeaderView:headView];
    
    
    UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/16*9)];
    tapView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tapView];
    //路径
    self.moviePlayerController.contentURL = [NSURL URLWithString:@"https://oexd4utdf.qnssl.com/FjwGJ9GxGd7jVSfED8RKlArPCdH6"];
    [tapView addSubview:self.moviePlayerController.view];
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moviewStopOrPlay)];
    [tapView addGestureRecognizer:self.tap];
    [self.moviePlayerController play];
    
    //重设容器大小
    headView.size = CGSizeMake(SCREEN_WIDTH, wmPlayer.bottom);
}

- (MPMoviePlayerController *)moviePlayerController
{
    if (!_moviePlayerController) {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
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
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
    _tableView.backgroundColor = LYBgColor;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}

@end
