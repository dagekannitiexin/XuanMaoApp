//
//  Utility.m
//  Shopping
//
//  Created by 林林尤达 on 2017/8/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "Utility.h"
#import "WebViewController.h"
#import "WebViewBannerController.h"

@implementation Utility


+(void)goVcForItemId:(NSString *)itemid WithURL:(NSString *)url WithType:(NSString *)type WithNavGation:(UINavigationController *)nav
{
    if ([type isEqualToString:@"banner"]){
        WebViewBannerController *web = [[WebViewBannerController alloc]init];
        web.urlStr = url;
        web.fd_prefersNavigationBarHidden = YES;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"美妆鉴赏"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"美妆心得大赛";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"专题栏"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"专题栏";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"变美视频"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"变美视频";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"大牌试用"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"大牌试用";
        web.urlStr = url;
        [nav pushViewController:web animated:YES];
        return;
    }
    if ([type isEqualToString:@"专题"]){
        WebViewController *web = [[WebViewController alloc]init];
        web.title = @"SoFullTeam首富团官微";
        web.urlStr = url;
        
        [nav pushViewController:web animated:YES];
        return;
    }
}

+ (NSString *)getH5token:(NSString*)url
{
    return url;  //假装加密了 回头设置
}
@end
