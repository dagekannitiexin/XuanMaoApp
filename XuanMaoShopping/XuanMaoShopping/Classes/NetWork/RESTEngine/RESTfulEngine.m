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

        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:[[op responseString] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        //如果无返回数据
        if (!responseDictionary)
        {
            errorBlock(nil);
            return ;
        }
        
        //有返回数据的情况下  暂时拿时间字判断
        NSString *ret = [responseDictionary valueForKey:@"ReFlag"];
        if(ret){
            
            [SVProgressHUD dismiss];
            succeededBlock(responseDictionary);
            return;
        }
        [SVProgressHUD dismiss];
        succeededBlock(responseDictionary);
        
        
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
