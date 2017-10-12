//
//  NewShakeViewController.m
//  点看宁波
//
//  Created by wbq on 16/6/14.
//  Copyright © 2016年 wbq. All rights reserved.
//

#import "NewShakeViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "UIImageView+WebCache.h"
#import <AudioToolbox/AudioToolbox.h>


@interface NewShakeViewController () <UIViewControllerTransitioningDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *recordConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *shopConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *piontlabelW;
@property (strong, nonatomic) IBOutlet UIView *pointView;
@property (strong, nonatomic) IBOutlet UIImageView *Icon;
@property (strong, nonatomic) IBOutlet UILabel *piontlabel;
@property(nonatomic,strong)UIView * ExplainView;
@property(nonatomic,strong)UIView * BGshadowView;
@property(nonatomic,strong)UITextView *text;
@property(nonatomic,strong)NSString * string;
@property (strong, nonatomic) IBOutlet UIImageView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *hand;
@property(nonatomic,assign)CGRect oldFrame;
@property(nonatomic,assign)BOOL isShake;

@end

@implementation NewShakeViewController
static SystemSoundID soundIDTest = 0;
static SystemSoundID soundIDTest2 = 1;

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
    
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    NSLog(@"-------");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!iphone4 && !iphone5s)
        
    {
        self.recordConstraint.constant = -100;
        self.shopConstraint.constant = 100;
       
       
    }
    
    [self CreatmypointView];
    
 

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.hand.layer.anchorPoint = CGPointMake(0.5,0.5);
//    self.hand.frame = self.oldFrame;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self creatnavigationbar];
    [self becomeFirstResponder];

    self.title = @"摇一摇";
    [self CreatBGshadowView];
//    [self GetInfo];
    if(iphone4)
    {
       self.bottomConstraint.constant = -50;
    }
//    [self Getpoint];
    [self.view layoutIfNeeded];
    
   
   
}



-(void)CreatmypointView
{
    
    self.pointView.hidden = YES;
}


-(void)hidenView
{
 
    [UIView animateWithDuration:0.35 animations:^{
        
        _BGshadowView.alpha = 0;
        _isShake = NO;
        
    }];
    
}

-(void)CreatBGshadowView
{
    _BGshadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _BGshadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _BGshadowView.alpha = 0;
    UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [_BGshadowView addGestureRecognizer:tap];
    
    
    
}





-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if( _isShake )
    {
        return;
        
    }
    NSLog(@"我摇了摇");
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self handShakeAnimation];
    
    
}
- (IBAction)shop:(id)sender {
    if([self.type isEqualToString:@"addfun"])
    {
        
        
    }
    else
    {
         [self.navigationController popToRootViewControllerAnimated:YES];
        
    
        [self performSelector:@selector(pushgood) withObject:nil afterDelay:0.3];
    }
    
    
}



-(void)pushgood
{
    
    
    
}


-(void)handShakeAnimation
{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //设置抖动幅度
    shake.fromValue = [NSNumber numberWithFloat:-0.2];
    
    shake.toValue = [NSNumber numberWithFloat:+0.2];
    
    shake.duration = 0.06;
    
    shake.autoreverses = YES; //是否重复
    
    shake.repeatCount = 8;
    
    [self.hand.layer addAnimation:shake forKey:@"imageView"];
    
    self.hand.alpha = 1.0;
    
    
    //修改anchorPoint而不想移动layer，在修改anchorPoint后再重新设置一遍frame就可以达到目的
    self.oldFrame =  self.hand.frame;
    
    self.hand.layer.anchorPoint = CGPointMake(0.5,0.75);
    
    self.hand.frame = self.oldFrame;
    
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
    [self ShakestartSound];

}


- (void)ShakestartSound{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"摇一摇音效" ofType:@"mp3"];
        if (path) {
            
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest);
            
        }
        AudioServicesPlaySystemSound( soundIDTest );
}


-(void)RewardstartSound{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"中奖音效" ofType:@"mp3"];
    if (path) {
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundIDTest2);
       
        
    }
    AudioServicesPlaySystemSound( soundIDTest2 );
}




-(void)creatnavigationbar
{
//       self.navigationController.navigationBar.backgroundColor = RGBCOLOR(27, 137, 290);
//       self.navigationController.navigationBar.alpha = 1;
//        self.navigationController.navigationBar.translucent = NO;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,20, 20)];
    [backButton setImage:[UIImage imageNamed:@"user_back"] forState:UIControlStateNormal];
    [backButton setTintColor:[UIColor whiteColor]];
    [backButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIButton *rule  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,40, 20)];
    rule.titleLabel.font = [UIFont systemFontOfSize:15];
    [rule setTitle:@"规则" forState:UIControlStateNormal];
    [rule setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rule addTarget:self action:@selector(Rule) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem1 = [[UIBarButtonItem alloc] initWithCustomView:rule];
    self.navigationItem.rightBarButtonItem = backItem1;

}

-(void)Rule
{
    self.isShake = YES;
    self.hand.layer.anchorPoint = CGPointMake(0.5,0.5);
    
    [self CreatExplain];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _BGshadowView.alpha = 1;
        
    }];
     self.hand.frame = self.oldFrame;



}

-(void)CreatExplain
{
    
    
    [_ExplainView removeFromSuperview];
    _ExplainView = [[UIView alloc]initWithFrame:CGRectMake(30, 40, SCREEN_WIDTH-60, (SCREEN_WIDTH-60)*1.4)];
    
    _ExplainView.backgroundColor = [UIColor whiteColor];
    UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _ExplainView.width, 5)];
    imageview.image  = [UIImage imageNamed:@"弹窗条"];
    [_ExplainView addSubview:imageview];
    [_BGshadowView addSubview:_ExplainView];
    _ExplainView.center = CGPointMake(_BGshadowView.width/2, _BGshadowView.height/2-20);
    UITapGestureRecognizer * tap1  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(stoptouch)];
    [_ExplainView addGestureRecognizer:tap1];
    
    [self.view addSubview:_BGshadowView];
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, _ExplainView.width, 50)];
    title.text = @"活动说明";
    
    title.textColor = RGBCOLOR(25, 86, 160);
    title.textAlignment = NSTextAlignmentCenter;
    [_ExplainView addSubview:title];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(title.frame), _ExplainView.width - 40, 1)];
    line.backgroundColor =RGBCOLOR(220, 220, 220);
    [_ExplainView addSubview:line];
    
    _text = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame), _ExplainView.width -20, _ExplainView.height -100)];
    [_ExplainView addSubview:_text];
    _text.editable = NO;
    if(self.string)
    {
        _text.text = self.string;
    }
    else
    {
        _text.text = @"一.活动时间 \n     每周一到周一: 18:45-19:45 \n     每周六:18:45-19:20 \n     锁定宁波电视台都市文体频道《讲大道》、《宁波老话》栏目。  \n二.参与方式 \n     1.屏幕右上方出现“摇一摇”提示，摇动手机即可参与。 \n     2.摇动即有奖，进入积分商城将积分独欢礼品。 \n三.得分规则 \n     每成功摇动1次可获得随机数额积分,最高可获得500个积分。  \n四.兑换奖品 \n     积分可在商城兑换奖品，由快递发送。 \n     部分奖品需上门自取。 \n五.活动说明 \n     活动细则详询“点看宁波”客服，苹果公司不是该游戏的发起者，也没有任何方式参与该活动，“点看宁波”保留对本次活动的最终解释权。";
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_text.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:3];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _text.text.length)];
    
    _text.attributedText = attributedString;
    _text.textColor = RGBCOLOR(150, 150, 150);
    [_text setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
    
    UIButton *btn  = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
    btn.center = CGPointMake(_ExplainView.width/2, _ExplainView.height - 10 -15);
    btn.backgroundColor = RGBCOLOR(25, 86, 160);
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"我知道了" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5.0;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(hidenView) forControlEvents:UIControlEventTouchUpInside];
    [_ExplainView addSubview:btn];
    
    
     self.hand.frame = self.oldFrame;
}


- (IBAction)ShakeRecord:(id)sender {
    
    

    
    
    
    
}

-(void)stoptouch
{
    
    
    
}

-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
