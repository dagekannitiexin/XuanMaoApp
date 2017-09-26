//
//  XMThematilOfficialCell.h
//  XuanMaoShopping
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMThematilOfficialCell : UITableViewCell
/*作者头像*/
@property (weak, nonatomic) IBOutlet UIImageView *writerImg;
/*作者名字*/
@property (weak, nonatomic) IBOutlet UILabel     *writerName;
/*文章头图*/
@property (weak, nonatomic) IBOutlet UIImageView *articlesImg;
/*文章发表时间*/
@property (weak, nonatomic) IBOutlet UILabel     *articlesTime;
/*文章标题*/
@property (weak, nonatomic) IBOutlet UILabel     *articlesTitle;
@end
