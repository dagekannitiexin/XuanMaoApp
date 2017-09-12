//
//  Utility.h
//  Shopping
//
//  Created by 林林尤达 on 2017/8/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/** 进入视图 */
+(void)goVcForItemId:(NSString *)itemid WithURL:(NSString *)url WithType:(NSString *)type WithNavGation:(UINavigationController *)nav;


/** url加密 */
+ (NSString *)getH5token:(NSString*)url;
@end
