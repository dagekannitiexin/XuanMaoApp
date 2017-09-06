//
//  XMLearnStyleViewTwo.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLearnStyleViewTwo.h"
#import "XMLabelExtension.h"

@interface XMLearnStyleViewTwo (){
    CGFloat _bottomWith; //前一个标签的bottom
}

@end

@implementation XMLearnStyleViewTwo

- (void)awakeFromNib
{
    [super awakeFromNib];
    //初始化样式
    self.layer.cornerRadius = 3;
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    self.iconImg.layer.cornerRadius  = self.iconImg.width/2;
    self.iconView.clipsToBounds = YES;
    self.iconImg.clipsToBounds = YES;
    
}

- (void)setlabelOfHost:(NSArray*)hostLabels
{
    CGFloat labelSpace = 15;
    CGFloat labelViewSpace = 5;
    _bottomWith = labelSpace;
    for (int i=0; i<3; i++) {
        XMLabelExtension *labelext = [[XMLabelExtension alloc]init];
        [labelext setLabelTextColor:RGBACOLOR(175, 175, 175, 1) textName:hostLabels[i]];
        labelext.frame = CGRectMake(labelViewSpace+_bottomWith, self.hostDescribe.bottom+13, labelext.width, labelext.height);
        
        [self addSubview:labelext];
        _bottomWith = _bottomWith+labelext.width+labelViewSpace;
    }
}

@end
