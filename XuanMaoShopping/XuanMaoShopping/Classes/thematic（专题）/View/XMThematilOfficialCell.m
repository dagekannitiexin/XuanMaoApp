//
//  XMThematilOfficialCell.m
//  XuanMaoShopping
//
//  Created by apple on 2017/9/26.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMThematilOfficialCell.h"

@implementation XMThematilOfficialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.writerImg.layer.cornerRadius = self.writerImg.width/2;
    self.width = SCREEN_WIDTH;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
