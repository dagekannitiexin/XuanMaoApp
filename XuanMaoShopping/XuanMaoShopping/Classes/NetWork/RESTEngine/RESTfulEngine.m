//
//  RESTfulEngine.m
//  traderen
//
//  Created by 林林尤达 on 2017/5/19.
//  Copyright © 2017年 林尤达. All rights reserved.
//

#import "RESTfulEngine.h"
#import "JSONKit.h"
#import "Base64.h"
//#import "ModelLocator.h"


@implementation RESTfulEngine

- (id)sendRequesttoSLT:(NSMutableDictionary *)requestInfo portPath:(NSString *)portPath Method:(NSString *)method onSucceeded:(DictronaryBlock)succeededBlock onError:(ErrorBlock)errorBlock
{
    //检查网络的
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if(reach ==nil || !reach.isReachable){
        [SVProgressHUD showErrorWithStatus:kServiceErrorMessage];
        errorBlock(nil);
        return nil;
    }

    //简单的GET操作请求URL
    RESTfulOperation *op = (RESTfulOperation*) [self operationWithPath:portPath params:requestInfo httpMethod:method];
    op.stringEncoding = NSUTF8StringEncoding;

    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@",completedOperation);
        NSString *jsonStirng = @"{\"Rdt\":{\"ErrorMessage\":\"\",\"ReData\":[{\"Name\":\"测试用数据2\",\"ProductCategory\":\"科技\",\"Intro\":\"测试简介\",\"OwnerName\":\"蛤蟆\",\"OwnerIntro\":\"蛤蟆\",\"OwnerImage\":\"\",\"OldValue\":2.0000,\"NewValue\":2.0000,\"Image\":\"\"},{\"Name\":\"测试用数据3\",\"ProductCategory\":\"科技\",\"Intro\":\"测试3\",\"OwnerName\":\"钩子\",\"OwnerIntro\":\"钩子\",\"OwnerImage\":null,\"OldValue\":24.0000,\"NewValue\":12.0000,\"Image\":\"\"},{\"Name\":\"测试用数据4\",\"ProductCategory\":\"科技\",\"Intro\":\"测试4\",\"OwnerName\":\"小猫\",\"OwnerIntro\":\"小猫\",\"OwnerImage\":null,\"OldValue\":121.0000,\"NewValue\":24.0000,\"Image\":\"\"}]},\"ReFlag\":\"1\"}";
        
        NSString *resString = [op responseString];
        NSString *res = [resString substringWithRange:NSMakeRange(1, resString.length-2)];
        NSDictionary *responseDictionary = [res  objectFromJSONString];
//        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:[res dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        //如果无返回数据
        if (!responseDictionary)
        {
            errorBlock(nil);
            return ;
        }
        
        //有返回数据的情况下  暂时拿时间字判断
        NSString *ret = [responseDictionary valueForKey:@"timestamp"];
        if(ret.length>0){
            
            [SVProgressHUD dismiss];
            succeededBlock(responseDictionary);
        }
        
        
        
    } onError:^(NSError *error) {
        if(error.code == 404){
            [SVProgressHUD showErrorWithStatus: kRequestFailedMessage  ];
        }else{
            [SVProgressHUD showErrorWithStatus: kTimeOutMessage  ];
        }
        
        errorBlock(error);
    }];
    [self enqueueOperation:op];
    return op;
}

@end
