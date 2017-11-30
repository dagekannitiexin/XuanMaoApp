//
//  XMLearnVideoListModel.h
//  XuanMaoShopping
//
//  Created by apple on 2017/11/30.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <Foundation/Foundation.h>

@class listVideoModel;

@interface XMLearnVideoListModel : NSObject
@property (nonatomic,strong)NSString *ErrorMessage;
@property (nonatomic,strong)NSString *IdData;
@property (nonatomic,strong)NSArray<listVideoModel*> *ReData;;

@end

@interface listVideoModel : NSObject

@property (nonatomic ,strong)NSString *ProductID; //产品名称
@property (nonatomic ,strong)NSString *ProductName; //产品名称
@property (nonatomic ,strong)NSString *CreateTime; //视频时间
@property (nonatomic ,strong)NSString *HeadImageUrl; //头像
@property (nonatomic ,strong)NSString *OwnerID; //所有者id
@property (nonatomic ,strong)NSString *OwnerName; //所有者名称
@property (nonatomic ,strong)NSString *HeadPortraitUrl; //产品图片
@property (nonatomic ,strong)NSString *Tag; //所有者标签
@property (nonatomic ,strong)NSString *VideoUrl; //视频地址
@property (nonatomic ,strong)NSString *VideoLength; //视频长度
@property (nonatomic ,strong)NSString *ReadNum; //阅读人数

@end
