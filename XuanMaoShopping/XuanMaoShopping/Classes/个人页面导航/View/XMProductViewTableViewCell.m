//
//  XMProductViewTableViewCell.m
//  XuanMaoShopping
//
//  Created by apple on 2017/12/4.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMProductViewTableViewCell.h"

@implementation XMProductViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.width = SCREEN_WIDTH;
    
    //圆角设置
    self.iconImg.layer.cornerRadius = self.iconImg.width/2;
    self.iconImg.clipsToBounds = YES;
    self.backImg.layer.cornerRadius = 5.0;
    self.backImg.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
