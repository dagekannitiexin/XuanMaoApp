//
//  XMMeHeadStyleView.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/7.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMMeHeadStyleView.h"

@implementation XMMeHeadStyleView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconImg.layer.cornerRadius = self.iconImg.width/2;
    self.iconImg.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
