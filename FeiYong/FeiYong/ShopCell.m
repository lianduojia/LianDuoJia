//
//  ShopCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/7/14.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (void)awakeFromNib {
    // Initialization code
    
    _mBgView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    _mBgView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    _mBgView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    _mBgView.layer.shadowRadius = 10;//阴影半径，默认3
    
    _mBgView.layer.masksToBounds = YES;
    _mBgView.layer.cornerRadius = 5;
    
    _mTelBt.layer.masksToBounds = YES;
    _mTelBt.layer.cornerRadius = 3;
    
    _mTelBt.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
