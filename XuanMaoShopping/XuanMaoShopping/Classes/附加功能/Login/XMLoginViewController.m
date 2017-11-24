//
//  XMLoginViewController.m
//  XuanMaoShopping
//
//  Created by apple on 2017/9/20.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLoginViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "XMLoginPhone.h"
#import <UMSocialCore/UMSocialCore.h>


@interface XMLoginViewController ()

@property (nonatomic,strong)MPMoviePlayerController *moviePlayerController;

@property (nonatomic,strong)UITapGestureRecognizer *tap;

@property (nonatomic,strong)UIView *loginViewOne;
@property (nonatomic,strong)UIView *loginViewTwo;
@property (nonatomic,strong)UIView *LoginView;

@end

@implementation XMLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.moviePlayerController play];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //添加播放器
    [self createMp4];
    
    //添加底部视图
    [self createFootView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

/*
 添加MP4视图
 */
- (void)createMp4
{
    //路径
    NSString *moviePath = [[NSBundle mainBundle]pathForResource:@"SFTMoview" ofType:@"mp4"];
    
    self.moviePlayerController.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    self.moviePlayerController.view.backgroundColor = [UIColor whiteColor];
    
    UIView *tapView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    tapView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tapView];
    
    self.tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moviewStopOrPlay)];
    [tapView addGestureRecognizer:self.tap];
    
    [self.moviePlayerController play];
}
/*
    loginView
 */
- (void)createFootView
{
    _LoginView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-135, SCREEN_WIDTH*2, 135)];
    _LoginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_LoginView];
    
    //增加分界线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*2, 0.5)];
    lineView.backgroundColor = XMLowBottomLine;
    [_LoginView addSubview:lineView];
    
    //手机登录 微信登录界面
    _loginViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 134)];
    _loginViewOne.backgroundColor = [UIColor whiteColor];
    [_LoginView addSubview:_loginViewOne];
    [self createButtonToViewOne];
    
    //qq  微博登录
    _loginViewTwo = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 1, SCREEN_WIDTH, 134)];
    _loginViewTwo.backgroundColor = [UIColor whiteColor];
    [_LoginView addSubview:_loginViewTwo];
    [self createButtonToViewTwo];
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

- (void)createButtonToViewOne
{
    CGFloat buttonWith = 150;
    CGFloat buttonOrginX = 28*KWidth_Scale;
    CGFloat buttonSapce = SCREEN_WIDTH - buttonWith*2 -buttonOrginX*2;
    
    UIButton *weCatBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonOrginX, 14, buttonWith, 45)];
    weCatBtn.backgroundColor = RGBACOLOR(106, 188, 64, 1);
    weCatBtn.layer.cornerRadius = 5;
    weCatBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [weCatBtn setTitle:@"使用微信登录" forState:UIControlStateNormal];
    [weCatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [weCatBtn setImage:[UIImage imageNamed:@"iconLoginWechat"] forState:UIControlStateNormal];
    weCatBtn.tag = 102;
    [weCatBtn addTarget:self action:@selector(loginWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginViewOne addSubview:weCatBtn];
    
    UIButton *phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonOrginX+buttonWith+buttonSapce, 14, buttonWith, 45)];
    phoneBtn.backgroundColor = RGBACOLOR(90, 144, 220, 1);
    phoneBtn.layer.cornerRadius = 5;
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [phoneBtn setTitle:@"使用手机登录" forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [phoneBtn setImage:[UIImage imageNamed:@"iconLoginPhone"] forState:UIControlStateNormal];
    phoneBtn.tag = 101;
    [phoneBtn addTarget:self action:@selector(loginWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginViewOne addSubview:phoneBtn];
    
    UILabel *otherLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, weCatBtn.bottom+20, 66, 50)];
    otherLabel.centerX = self.loginViewOne.centerX;
    otherLabel.textAlignment = NSTextAlignmentCenter;
    [otherLabel setLineBreakMode:NSLineBreakByWordWrapping];
    otherLabel.numberOfLines = 1;
    [otherLabel setFont:[UIFont systemFontOfSize:11]];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"其他方式登录"]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    otherLabel.attributedText = content;
    [self.loginViewOne addSubview:otherLabel];
    
    //手势跳转动画
    otherLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapLogin = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removieViewOne)];
    [otherLabel addGestureRecognizer:tapLogin];
    
}

- (void)createButtonToViewTwo
{
    CGFloat buttonWith = 150;
    CGFloat buttonOrginX = 28*KWidth_Scale;
    CGFloat buttonSapce = SCREEN_WIDTH - buttonWith*2 -buttonOrginX*2;
    UIButton *qqBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonOrginX, 14, buttonWith, 45)];
    qqBtn.backgroundColor = RGBACOLOR(111, 184, 238, 1);
    qqBtn.layer.cornerRadius = 5;
    qqBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [qqBtn setTitle:@"使用QQ登录" forState:UIControlStateNormal];
    [qqBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [qqBtn setImage:[UIImage imageNamed:@"iconLoginQQ"] forState:UIControlStateNormal];
    qqBtn.tag = 103;
    [qqBtn addTarget:self action:@selector(loginWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginViewTwo addSubview:qqBtn];
    
    UIButton *weiBoBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonOrginX+buttonWith+buttonSapce, 14, buttonWith, 45)];
    weiBoBtn.backgroundColor = RGBACOLOR(222, 94, 46, 1);
    weiBoBtn.layer.cornerRadius = 5;
    weiBoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [weiBoBtn setTitle:@"使用微博登录" forState:UIControlStateNormal];
    [weiBoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [weiBoBtn setImage:[UIImage imageNamed:@"iconLoginWeibo"] forState:UIControlStateNormal];
    weiBoBtn.tag = 104;
    [weiBoBtn addTarget:self action:@selector(loginWay:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginViewTwo addSubview:weiBoBtn];
    
    //增加返回按钮
    UIButton *backToViewTwoBtn = [[UIButton alloc]initWithFrame:CGRectMake(buttonOrginX, qqBtn.bottom+15, SCREEN_WIDTH -2*buttonOrginX, 45)];
    backToViewTwoBtn.backgroundColor = RGBACOLOR(246, 246, 246, 1);
    [backToViewTwoBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backToViewTwoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backToViewTwoBtn addTarget:self action:@selector(backToViewOne) forControlEvents:UIControlEventTouchUpInside];
    backToViewTwoBtn.layer.cornerRadius = 5.0;
    [self.loginViewTwo addSubview:backToViewTwoBtn];
}
#pragma mark - lazyinit

- (MPMoviePlayerController *)moviePlayerController
{
    if (!_moviePlayerController) {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        _moviePlayerController.movieSourceType = MPMovieSourceTypeFile;
        _moviePlayerController.controlStyle = MPMovieControlStyleNone;
        _moviePlayerController.view.frame = [UIScreen mainScreen].bounds;
        [_moviePlayerController setFullscreen:NO];
        [_moviePlayerController setShouldAutoplay:NO];
        _moviePlayerController.initialPlaybackTime = -1.0;
        [_moviePlayerController setRepeatMode:MPMovieRepeatModeNone];
        [self.view addSubview:self.moviePlayerController.view];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }
    return _moviePlayerController;
}

- (void)playbackStateChanged
{
    NSLog(@"播放完成啦");
    self.tap.enabled = NO;
}

/*
 移动到loginViewTwo
 */
- (void)removieViewOne
{
    [UIView animateWithDuration:0.5 animations:^{
        self.LoginView.x = -SCREEN_WIDTH;
    }];
}

/*
 移动回loginViewOne
 */

- (void)backToViewOne
{
    [UIView animateWithDuration:0.5 animations:^{
        self.LoginView.x = 0;
    }];
}

/*
 各种登录方式
 */
- (void)loginWay:(UIButton*)sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 101:
        {
            NSLog(@"使用手机登录");
            XMLoginPhone *VCPhone = [[XMLoginPhone alloc]init];
            [self.navigationController pushViewController:VCPhone animated:YES];
        }
            break;
        case 102:
        {
            NSLog(@"使用微信登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    //1 授权信息
                    NSLog(@"Wechat uid: %@", resp.uid);
                    NSLog(@"Wechat openid: %@", resp.openid);
                    NSLog(@"Wechat unionid: %@", resp.unionId);
                    NSLog(@"Wechat accessToken: %@", resp.accessToken);
                    NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                    NSLog(@"Wechat expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"Wechat name: %@", resp.name);
                    NSLog(@"Wechat iconurl: %@", resp.iconurl);
                    NSLog(@"Wechat gender: %@", resp.unionGender);
                    
                    // 第三方平台SDK源数据
                    NSLog(@"Wechat originalResponse: %@", resp.originalResponse);

                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"Openid"];
                    [requestInfo setValue:resp.unionId forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"sex"] forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"country"] forKey:@"Country"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"privilege"] forKey:@"Privilege"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:[NSNumber numberWithInteger:1] forKey:@"Flag"];
                    [self postInfo:requestInfo LoginType:@"微信"];
                }
            }];
        }
            break;
        case 103:
        {
            NSLog(@"使用QQ登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    // 授权信息
                    NSLog(@"QQ uid: %@", resp.uid);
                    NSLog(@"QQ openid: %@", resp.openid);
                    NSLog(@"QQ unionid: %@", resp.unionId);
                    NSLog(@"QQ accessToken: %@", resp.accessToken);
                    NSLog(@"QQ expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"QQ name: %@", resp.name);
                    NSLog(@"QQ iconurl: %@", resp.iconurl);
                    NSLog(@"QQ gender: %@", resp.unionGender);
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    // 第三方平台SDK源数据
                    NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"Openid"];
                    [requestInfo setValue:resp.accessToken forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [requestInfo setValue:[NSNumber numberWithInteger:2] forKey:@"Flag"];
                    [self postInfo:requestInfo LoginType:@"QQ"];
                }
            }];
    }
            break;
        case 104:
        {
            NSLog(@"使用微博登录");
            [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:nil completion:^(id result, NSError *error) {
                if (error) {
                    
                } else {
                    UMSocialUserInfoResponse *resp = result;
                    
                    // 授权信息
                    NSLog(@"Sina uid: %@", resp.uid);
                    NSLog(@"Sina accessToken: %@", resp.accessToken);
                    NSLog(@"Sina refreshToken: %@", resp.refreshToken);
                    NSLog(@"Sina expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"Sina name: %@", resp.name);
                    NSLog(@"Sina iconurl: %@", resp.iconurl);
                    NSLog(@"Sina gender: %@", resp.unionGender);
                    NSNumber *sex = [NSNumber new];
                    if ([resp.unionGender isEqualToString:@"男"]){
                        sex = [NSNumber numberWithInteger:1];
                    }else {
                        sex = [NSNumber numberWithInteger:0];
                    }
                    // 第三方平台SDK源数据
                    NSLog(@"Sina originalResponse: %@", resp.originalResponse);
                    //统一调用一个方法
                    NSMutableDictionary *requestInfo = [[NSMutableDictionary alloc]init];
                    [requestInfo setValue:resp.uid forKey:@"Openid"];
                    [requestInfo setValue:resp.accessToken forKey:@"Unionid"];
                    [requestInfo setValue:resp.name forKey:@"Nickname"];
                    [requestInfo setValue:sex forKey:@"Sex"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"province"] forKey:@"Province"];
                    [requestInfo setValue:[resp.originalResponse objectForKey:@"city"] forKey:@"City"];
                    [requestInfo setValue:resp.iconurl forKey:@"HeadImageUrl"];
                    [requestInfo setValue:@"中国" forKey:@"Country"];
                    [requestInfo setValue:nil forKey:@"Privilege"];
                    [requestInfo setValue:[NSNumber numberWithInteger:3] forKey:@"Flag"];
                    [self postInfo:requestInfo LoginType:@"新浪"];
                    
                }
            }];
    }
            break;
        default:
            break;
    }
}

/*
 上传用户信息
 */
- (void)postInfo:(NSMutableDictionary *)resp LoginType:(NSString*)type{

    NSString *netPath = [NSString stringWithFormat:@"%@",@"192.168.50.178/smartapi/api/User/LoginByWechat"];
    [XM_AppDelegate.engine sendRequesttoSLT:resp portPath:netPath Method:@"POST" onSucceeded:^(NSDictionary *aDictronaryBaseObjects) {
        NSLog(@"%@",aDictronaryBaseObjects);
        if (![aDictronaryBaseObjects objectForKey:@"ReFlag"]){
            return;
        }
        NSDictionary *dic = [aDictronaryBaseObjects objectForKey:@"Rdt"];
        if ([[dic objectForKey:@"ReData"]isEqualToString:@"NoTel"]){
            NSLog(@"跳到手机验证页");
            XMLoginPhone *VCPhone = [[XMLoginPhone alloc]init];
            VCPhone.openid = [dic objectForKey:@"IdData"];
            [self.navigationController pushViewController:VCPhone animated:YES];
        }

    } onError:^(NSError *engineError) {
        NSLog(@"no");
    }];
}
@end
