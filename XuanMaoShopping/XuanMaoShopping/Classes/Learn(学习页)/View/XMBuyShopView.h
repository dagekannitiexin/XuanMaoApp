//
//  XMBuyShopView.h
//  XuanMaoShopping
//
//  Created by apple on 2017/10/16.
//  Copyright © 2017年 林林尤达. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cancelBtn) ();

@interface XMBuyShopView : UIView

@property (nonatomic ,copy) cancelBtn cancelBtnBlock;

@property (nonatomic ,copy) cancelBtn payBtnBlock;
- (instancetype)initWithFrame:(CGRect)frame;
@end
