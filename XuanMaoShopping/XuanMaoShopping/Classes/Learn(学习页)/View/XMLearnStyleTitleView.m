//
//  XMLearnStyleTitleView.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/5.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLearnStyleTitleView.h"

@implementation XMLearnStyleTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        //  设置title
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 200, 18)];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self addSubview:self.titleLabel];
        
        // 查看更多标志
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 28, 28)];
        image.image = [UIImage imageNamed:@"Img_default"];
        [self addSubview:image];
        //重设位置
        image.centerY = self.titleLabel.centerY;
        image.right = self.width - 10;
        
        //查看更多文字
        UILabel *seeMore = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 53, 13)];
        [seeMore setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        [seeMore setTextColor:XMGaryColor];
        seeMore.text = @"查看更多";
        [self addSubview:seeMore];
        //重设位置
        seeMore.centerY = self.titleLabel.centerY;
        seeMore.right = image.x-10;
        
    }
    return self;
}

@end
