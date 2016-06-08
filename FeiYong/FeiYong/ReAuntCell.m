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

@end
