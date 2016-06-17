//
//  payCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "payCell.h"

@implementation payCell

- (void)awakeFromNib {
    // Initialization code
    _mImg.hidden = NO;
    _mMoney.hidden = NO;
    _mPayMoney.hidden = NO;
    _mName.hidden = NO;
    _mLabel.hidden = NO;
}

- (void)initCell:(SAuntInfo *)aunt{

//    @property (weak, nonatomic) IBOutlet UIImageView *mImg;
//    @property (weak, nonatomic) IBOutlet UILabel *mMoney;
//    @property (weak, nonatomic) IBOutlet UILabel *mPayMoney;
//    @property (weak, nonatomic) IBOutlet UILabel *mName;
//    @property (weak, nonatomic) IBOutlet UILabel *mLabel;
    
    [_mImg sd_setImageWithURL:[NSURL URLWithString:aunt.mPhoto_url] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    _mMoney.text = [NSString stringWithFormat:@"￥%d/月",aunt.mPay];
    _mPayMoney.text = [NSString stringWithFormat:@"￥%d",aunt.mPay];
    _mName.text = aunt.mName;
}

@end
