//
//  XMLabelExtension.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLabelExtension.h"

@implementation XMLabelExtension


- (void)setLabelTextColor:(UIColor*)color textName:(NSString*)text
{
    //高17 宽不定
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(6, 3.5, 10, 10)];
    label.numberOfLines =1;
    label.textColor = color;
    label.text = text;
    label.font = [UIFont systemFontOfSize:10.0];
    [label sizeToFit];
    [self addSubview:label];
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGBACOLOR(230, 230, 230, 1).CGColor;
    
    
    self.height = 17;
    self.width = label.width+12;
}

@end
