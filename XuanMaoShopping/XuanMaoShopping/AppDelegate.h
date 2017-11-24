//
//  AppDelegate.h
//  XuanMaoShopping
//
//  Created by 林林尤达 on 2017/8/29.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESTfulEngine.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
#define XM_AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@property (strong, nonatomic) UIWindow *window;

/** 后台连接管理*/
@property (strong, nonatomic) RESTfulEngine *engine;

- (void)setRootView;
@end

