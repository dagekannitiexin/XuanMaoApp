//
//  XMCreditsExchangeTableViewCell.m
//  XuanMaoShopping
//
//  Created by apple on 2017/10/24.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import "XMCreditsExchangeTableViewCell.h"

@implementation XMCreditsExchangeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.HeadImageUrl.layer.cornerRadius = self.HeadImageUrl.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setListModel:(listVideoModel *)listModel
{
    _listModel = listModel;
    //产品图片
    [self.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:self.listModel.HeadPortraitUrl]placeholderImage:[UIImage imageNamed:@"Img_default"]];
    //产品名称
    self.ProductName.text = self.listModel.ProductName;
    
    //头像地址
    [self.HeadImageUrl sd_setImageWithURL:[NSURL URLWithString:self.listModel.HeadImageUrl]placeholderImage:[UIImage imageNamed:@"Img_default"]];
    
    //所有者名称
    self.OwnerName.text = self.listModel.OwnerName;
    
    //视频时间
    self.VideoLength.text = self.listModel.VideoLength;
    
    //阅读人数
    self.ReadNum.text = self.listModel.ReadNum;
}
@end
