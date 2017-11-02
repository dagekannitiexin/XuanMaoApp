//
//  XMLearnStyleViewFour.h
//  XuanMaoShopping
//
//  Created by apple on 17/9/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMLearnStyleViewFour : UIView

/*
 底部覆盖视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *bagView;

/*
  详细的视图白色
 */
@property (weak, nonatomic) IBOutlet UIView *homeView;
/*
 icon
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

/*
 关注人数
 */
@property (weak, nonatomic) IBOutlet UILabel *payAttentionPeo;

/*
 主播标题
 */
@property (weak, nonatomic) IBOutlet UILabel *title;

/*
 主题描述
 */
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

/*
 作者写的文章数量
 */
@property (weak, nonatomic) IBOutlet UIView *numberOfTitle;
@property (weak, nonatomic) IBOutlet UILabel *numberOfArticle;

/*
 创建标签方法
 */
- (void)createLabel:(NSArray*)label;

/*
 创建序列图片的办法
 */
- (void)createImg:(NSArray *)imageArray;
@end
