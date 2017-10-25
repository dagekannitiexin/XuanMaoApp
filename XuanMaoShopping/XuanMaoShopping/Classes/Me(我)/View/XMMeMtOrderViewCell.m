//
//  XMMeMtOrderViewCell.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/20.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeMtOrderViewCell.h"


@implementation XMMeMtOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.width = SCREEN_WIDTH;
    _iconImg.layer.cornerRadius = _iconImg.width/2.0;
    _iconImg.clipsToBounds = YES;
    _checkTheLogistics.layer.borderWidth = 1.0;
    _checkTheLogistics.layer.borderColor = XMGaryColor.CGColor;
    _checkTheLogistics.layer.cornerRadius = 15.0;
    _toScore.layer.cornerRadius = 15.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
