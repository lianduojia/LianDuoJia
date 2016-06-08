//
//  PingJiaCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "PingJiaCell.h"

@implementation PingJiaCell

- (void)awakeFromNib {
    // Initialization code
    _mHeadImg.layer.masksToBounds = YES;
    _mHeadImg.layer.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
