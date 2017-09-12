//
//  XMShareBtn.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/12.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMShareBtn.h"

@implementation XMShareBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

//设置比例为 50*50  11*50
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, 50, 50);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 80-11, 50, 11);
}

@end
