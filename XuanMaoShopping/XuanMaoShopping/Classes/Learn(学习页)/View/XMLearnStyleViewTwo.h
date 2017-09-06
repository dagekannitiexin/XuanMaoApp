//
//  XMLearnStyleViewTwo.h
//  XuanMaoShopping
//
//  Created by apple on 17/9/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLearnStyleViewTwo : UIView

/*
 保存背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *backImg;

/*
 包裹icon的白色view
 */
@property (weak, nonatomic) IBOutlet UIView *iconView;

/*
 包含头像的imageView
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

/*
 主播标题
 */
@property (weak, nonatomic) IBOutlet UILabel *hostTitle;

/*
 主播房间描述
 */
@property (weak, nonatomic) IBOutlet UILabel *hostDescribe;

/*
 主播标签array
 */
//@property (nonatomic,strong) NSArray *hostLabels;
/*
 设置标签
 */
- (void)setlabelOfHost:(NSArray*)hostLabels;
@end
