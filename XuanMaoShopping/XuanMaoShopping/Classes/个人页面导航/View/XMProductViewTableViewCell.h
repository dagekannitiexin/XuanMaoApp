//
//  XMProductViewTableViewCell.h
//  XuanMaoShopping
//
//  Created by apple on 2017/12/4.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

//cell  长：scr  高：365
@interface XMProductViewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImg; //头像
@property (weak, nonatomic) IBOutlet UILabel *name; //昵称
@property (weak, nonatomic) IBOutlet UILabel *timeOut; //收到时间
@property (weak, nonatomic) IBOutlet UIImageView *backImg; //背景图片
@property (weak, nonatomic) IBOutlet UILabel *introduce; //介绍
@property (weak, nonatomic) IBOutlet UILabel *like; //喜欢
@property (weak, nonatomic) IBOutlet UILabel *share; //分享







@end
