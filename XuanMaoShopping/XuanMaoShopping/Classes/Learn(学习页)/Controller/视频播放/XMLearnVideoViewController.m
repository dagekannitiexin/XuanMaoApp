//
//  XMLearnVideoViewController.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/25.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLearnVideoViewController.h"
#import "WMPlayer.h"
#import "UIViewController+GestureStateBlock.h"
#import "XMVideoInfo.h"

@interface XMLearnVideoViewController ()<WMPlayerDelegate>{
    WMPlayer  *wmPlayer;
    CGRect     playerFrame;
    BOOL isHiddenStatusBar;//记录状态的隐藏显示
    BOOL isRotateEable;//记录支不支持旋转
    BOOL isStartPlay; //记录第一次播放
}

@property (nonatomic , strong)XMVideoInfo *videoInfo;

@end

@implementation XMLearnVideoViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(BOOL)prefersStatusBarHidden{
    if (isHiddenStatusBar) {//隐藏
        return YES;
    }
    return NO;
}
//视图控制器实现的方法
- (BOOL)shouldAutorotate{
    if (isRotateEable==NO) {
        return NO;
    }
    //是否允许转屏
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    UIInterfaceOrientationMask result = [super supportedInterfaceOrientations];
    //viewController所支持的全部旋转方向
    return result;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //对于present出来的控制器，要主动的更新一个约束，让wmPlayer全屏，更安全
    if (wmPlayer.isFullscreen==NO) {
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
            make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.center.equalTo(wmPlayer.superview);
        }];
        wmPlayer.isFullscreen = YES;
        
    }
    return UIInterfaceOrientationLandscapeRight;
}
///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    if (wmplayer.isFullscreen) {
        
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        //刷新
        [UIViewController attemptRotationToDeviceOrientation];
        
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).with.offset(0);
            make.left.equalTo(self.view).with.offset(0);
            make.right.equalTo(self.view).with.offset(0);
            make.height.equalTo(@(playerFrame.size.height));
        }];
        wmPlayer.isFullscreen = NO;
    }else{
        [self releaseWMPlayer];
        if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
}
///播放暂停
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    NSLog(@"clickedPlayOrPauseButton");
}
///全屏按钮
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (wmPlayer.isFullscreen==YES) {//全屏
        //强制翻转屏幕，Home键在下边。
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        
        wmPlayer.isFullscreen = NO;
        
    }else{//非全屏
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
        [self toOrientation:UIInterfaceOrientationLandscapeRight];
        wmPlayer.isFullscreen = YES;
    }
}
///单击播放器
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    
}
///双击播放器
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}
///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    //    NSLog(@"wmplayerDidReadyToPlay");
    if (state == WMPlayerStatePlaying && !isStartPlay){
        isStartPlay = YES;
        wmplayer.state =WMPlayerStateStopped;
        [wmPlayer play];
    }
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{

}
//操作栏隐藏或者显示都会调用此方法
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    isHiddenStatusBar = isHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
            wmPlayer.isFullscreen = NO;
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            [self toOrientation:UIInterfaceOrientationPortrait];
            wmPlayer.isFullscreen = NO;
            
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            [self toOrientation:UIInterfaceOrientationLandscapeLeft];
            wmPlayer.isFullscreen = YES;
            
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            [self toOrientation:UIInterfaceOrientationLandscapeRight];
            wmPlayer.isFullscreen = YES;
        }
            break;
        default:
            break;
    }
}

//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    if (isRotateEable==NO) {
        return;
    }
    if (orientation ==UIInterfaceOrientationPortrait) {//
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).with.offset(0);
            make.left.equalTo(self.view).with.offset(0);
            make.right.equalTo(self.view).with.offset(0);
            make.height.equalTo(@(playerFrame.size.height));
        }];
    }else{
        [wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
            make.center.equalTo(wmPlayer.superview);
        }];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewDidAppear:animated];
}
#pragma mark
#pragma mark viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.fd_prefersNavigationBarHidden = YES;
    isRotateEable = YES;
    playerFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.width)* 9 / 16);
    
    wmPlayer = [[WMPlayer alloc]init];
    
    wmPlayer.delegate = self;
    wmPlayer.URLString = self.URLString;
    wmPlayer.titleLabel.text = self.title;
    wmPlayer.closeBtn.hidden = NO;
    
    [self.view addSubview:wmPlayer];
    [wmPlayer play];
    
    [wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(0);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.equalTo(@(playerFrame.size.height));
    }];
    
    ///手势开始时刻回调block
    self.gestureBeganBlock = ^(UIViewController *viewController) {
        NSLog(@"gestureBegan");
        isRotateEable = NO;
    };
    
    ///手势作用期间回调block
    self.gestureChangedBlock = ^(UIViewController *viewController) {
        NSLog(@"gestureChanged");
        isRotateEable = NO;
    };
    
    ///手势结束时刻回调block
    self.gestureEndedBlock = ^(UIViewController *viewController) {
        NSLog(@"gestureEnded");
        isRotateEable = YES;
    };
    
    //增加视屏下面的视图
    _videoInfo = [[[NSBundle mainBundle]loadNibNamed:@"XMVideoInfo" owner:nil options:nil]lastObject];
    _videoInfo.origin = CGPointMake(0, playerFrame.size.height);
    [self setViewInfo];
    [self.view addSubview:_videoInfo];
     
}

- (void)releaseWMPlayer
{
    //堵塞主线程
    [wmPlayer pause];
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}
- (void)dealloc
{
    [self releaseWMPlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"DetailViewController deallco");
}

#pragma mark - 下视图设置
- (void)setListModel:(listVideoModel *)listModel
{
    _listModel = listModel;
}

/*
 设置view
 */
- (void)setViewInfo
{
    //产品名称
    self.videoInfo.ProductName.text = _listModel.ProductName;
    
    //头像地址
    [self.videoInfo.HeadImageUrl sd_setImageWithURL:[NSURL URLWithString:_listModel.HeadImageUrl]placeholderImage:[UIImage imageNamed:@"Img_default"]];
    
    //所有者名称
    self.videoInfo.OwnerName.text = _listModel.OwnerName;
    
    //视频时间
    self.videoInfo.VideoLength.text = _listModel.VideoLength;
    
    //阅读人数
    self.videoInfo.ReadNum.text = _listModel.ReadNum;
    
    //导师标签
    self.videoInfo.Tag.text = _listModel.Tag;
}
@end
