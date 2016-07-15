//
//  CityCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/7/12.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell

- (void)awakeFromNib {
    // Initialization code
    _mImg.layer.masksToBounds = YES;
    _mImg.layer.cornerRadius = 6;
}

@end
