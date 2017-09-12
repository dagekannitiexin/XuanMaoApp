//
//  XMMeGift.h
//  XuanMaoShopping
//
//  Created by apple on 17/9/12.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMBaseViewController.h"

@interface XMMeGift : XMBaseViewController<UIWebViewDelegate>

/** 地址 */
@property (strong,nonatomic) NSString *urlStr;

/** web */
@property (strong,nonatomic) UIWebView *web;
@end
