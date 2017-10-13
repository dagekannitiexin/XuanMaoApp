//
//  XMTabBarController.m
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMTabBarController.h"
#import "XMNavigationController.h"
#import "XMHomeViewController.h"
#import "XMLearnViewController.h"
#import "XMMeViewController.h"
#import "XMThematicViewController.h"
#import "SignPresentingAnimator.h"
#import "SignDismissingAnimator.h"

@interface XMTabBarController ()<UITabBarDelegate,UIViewControllerTransitioningDelegate>

@end

@implementation XMTabBarController
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [SignPresentingAnimator new];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [SignDismissingAnimator new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    [self addChildController:[[XMLearnViewController alloc]init] imageName:@"tabar_Homenew0" selectedImage:@"tabar_Homenew1" title:@"首页"];
    
    [self addChildController:[[XMThematicViewController alloc]init] imageName:@"tabar_activitynew0" selectedImage:@"tabar_activitynew1" title:@"专题"];
    
    [self addChildController:[[XMMeViewController alloc]init] imageName:@"tabar_shakenew0" selectedImage:@"tabar_shakenew1" title:@"我的"];
    
}

/**
 *	@brief	设置TabBarItem主题
 */

+ (void)initialize {
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = MRGlobalBg;
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

/**
 *	@brief	添加子控制器
 *
 *	@param 	childVC 	子控制期器
 *	@param 	image 	默认图片
 *	@param 	selectedImage 	选中图片
 *	@param 	title 	标题
 */
- (void)addChildController:(UIViewController *)childVC imageName:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    // 设置文字和图片
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage mr_imageOriginalWithName:image];
    childVC.tabBarItem.selectedImage = [UIImage mr_imageOriginalWithName:selectedImage];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBACOLOR(181, 38, 45, 1)} forState:UIControlStateSelected];     
    // 包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    XMNavigationController *nav = [[XMNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
