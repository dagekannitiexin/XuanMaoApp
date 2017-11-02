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
    self.layer.cornerRadius = 5.0;
    self.clipsToBounds = YES;
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    self.iconImg.layer.cornerRadius  = self.iconImg.width/2;
    self.iconView.clipsToBounds = YES;
    self.iconImg.clipsToBounds = YES;
    
}

- (void)setlabelOfHost:(NSArray*)hostLabels
{
    
    CGFloat labelViewSpace = 5;
    _bottomWith = 0;
    NSInteger num = 0;
    if (hostLabels.count >3){
        num = 3;
    }else {
        num = hostLabels.count;
    }
    UIView *arrayView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hostDescribe.bottom+13, 200, 20)];

    [self addSubview:arrayView];
    
    for (int i=0; i<num; i++) {
        XMLabelExtension *labelext = [[XMLabelExtension alloc]init];
        [labelext setLabelTextColor:RGBACOLOR(175, 175, 175, 1) textName:hostLabels[i]];
        labelext.frame = CGRectMake(labelViewSpace+_bottomWith,0, labelext.width, labelext.height);
        
        _bottomWith = _bottomWith+labelext.width+labelViewSpace;
        [arrayView addSubview:labelext];
        arrayView.size = CGSizeMake(labelext.right-labelViewSpace, labelext.height);
        arrayView.centerX = self.width/2;
    }
}

@end
