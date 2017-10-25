//
//  XMMeMtOrderViewCell.h
//  XuanMaoShopping
//
//  Created by apple on 2017/10/20.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMMeMtOrderViewCell : UITableViewCell

/*
 作者头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
/*
 作者名称
 */
@property (weak, nonatomic) IBOutlet UILabel *writeName;
/*
 shopIcon
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopIcon;
/*
 shopTitle
 */
@property (weak, nonatomic) IBOutlet UILabel *shopTitle;
/*
 商品参数
 */
@property (weak, nonatomic) IBOutlet UILabel *parameter;
/*
 订单状态
 */
@property (weak, nonatomic) IBOutlet UILabel *orderState;

@property (weak, nonatomic) IBOutlet UIButton *checkTheLogistics;

@property (weak, nonatomic) IBOutlet UIButton *toScore;


@end
