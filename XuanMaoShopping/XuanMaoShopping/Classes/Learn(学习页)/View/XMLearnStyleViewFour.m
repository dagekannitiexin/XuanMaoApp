//
//  XMLearnStyleViewFour.m
//  XuanMaoShopping
//
//  Created by apple on 17/9/6.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMLearnStyleViewFour.h"
#import "XMLabelExtension.h"

@interface XMLearnStyleViewFour (){
    CGFloat _bottomWith;
}

@end
@implementation XMLearnStyleViewFour

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.homeView.layer.cornerRadius = 5;
    self.iconImg.layer.cornerRadius = self.iconImg.width/2;
    self.iconImg.clipsToBounds = YES;
    self.numberOfTitle.layer.borderWidth = 1.0;
    self.numberOfTitle.layer.borderColor = RGBACOLOR(230, 230, 230, 1).CGColor;
    self.numberOfTitle.layer.cornerRadius = 3.0;
    //重设位置
    self.numberOfTitle.x = self.iconImg.bottom+177;
}

/*
 创建标签方法
 由于标签宽度不定 设置外部变量布局
 */
- (void)createLabel:(NSArray*)label
{
    CGFloat labelSpace = 15;
    CGFloat labelViewSpace = 5;
    _bottomWith = labelSpace+self.iconImg.bottom;
    NSInteger num = 0;
    if (label.count >3){
        num = 3;
    }else {
        num = label.count;
    }
    for (int i=0; i<num; i++) {
        XMLabelExtension *labelext = [[XMLabelExtension alloc]init];
        [labelext setLabelTextColor:RGBACOLOR(175, 175, 175, 1) textName:label[i]];
        labelext.frame = CGRectMake(_bottomWith, self.descLabel.bottom+10, labelext.width, labelext.height);
        
        [self.homeView addSubview:labelext];
        _bottomWith = _bottomWith+labelext.width+labelViewSpace;
    }
}

/*
 创建序列图片的办法
 */
- (void)createImg:(NSArray *)imageArray
{
    CGFloat imageSpace = 15;
    CGFloat imageViewSapce = 9;
    CGFloat imageW = 45;
    CGFloat imageH = 45;
    NSInteger num = 0;
    if (imageArray.count >3){
        num = 3;
    }else {
        num = imageArray.count;
    }
    for (int i=0; i<num; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.iconImg.bottom+imageSpace+(imageW+imageViewSapce)*i, self.descLabel.bottom+45, imageW,imageH)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[imageArray[i]objectForKey:@"img"]]] placeholderImage:[UIImage imageNamed:@"Img_default"]];
        imageView.layer.cornerRadius = 3.0;
        imageView.clipsToBounds = YES;
        [self.homeView addSubview:imageView];
        
    }
}
@end
