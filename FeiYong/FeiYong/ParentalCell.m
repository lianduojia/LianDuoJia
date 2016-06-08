//
//  ParentalCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ParentalCell.h"

@implementation ParentalCell

- (void)awakeFromNib {
    // Initialization code
    _mDetail.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
