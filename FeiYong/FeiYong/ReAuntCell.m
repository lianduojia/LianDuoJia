//
//  ReAuntCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ReAuntCell.h"

@implementation ReAuntCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initCell:(SAuntInfo *)info{

    _mName.text = info.mName;
    [_mImg sd_setImageWithURL:[NSURL URLWithString:info.mPhoto_url] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    [_mWorkBt setTitle:info.mWork_type forState:UIControlStateNormal];
    [_mYearBt setTitle:[NSString stringWithFormat:@"从业%d年",info.mWorking_years] forState:UIControlStateNormal];
    _mAge.text = [NSString stringWithFormat:@"%d岁",info.mAge];
    _mPlace.text = [NSString stringWithFormat:@"%@人",info.mLiving_province];
    _mAddress.text = [NSString stringWithFormat:@"现居住于%@%@%@",info.mWork_province,info.mWork_city,info.mWork_area];
    _mWages.text = [NSString stringWithFormat:@"￥%d/月",info.mPay];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:_mStar1,_mStar2,_mStar3,_mStar4,_mStar5, nil];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *imgV = [array objectAtIndex:i];
        
        
        if (i < [info.mLeave intValue]) {
            imgV.image = [UIImage imageNamed:@"a_star"];
        }else{
            imgV.image = [UIImage imageNamed:@"a_starhui"];
        }
    }
    
}

@end
