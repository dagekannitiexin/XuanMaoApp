//
//  XMCreditsExchangeTableViewCell.h
//  XuanMaoShopping
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLearnVideoListModel.h"

@interface XMCreditsExchangeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *HeadPortrait;

@property (weak, nonatomic) IBOutlet UILabel *ProductName;

@property (weak, nonatomic) IBOutlet UIImageView *HeadImageUrl;

@property (weak, nonatomic) IBOutlet UILabel *OwnerName;

@property (weak, nonatomic) IBOutlet UILabel *VideoLength;

@property (weak, nonatomic) IBOutlet UILabel *ReadNum;

@property (nonatomic ,strong)listVideoModel *listModel;

@end
