//
//  AuntDetailCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AuntDetailCell.h"

@implementation AuntDetailCell

- (void)awakeFromNib {
    // Initialization code
    UIImage * img= [UIImage imageNamed:@"a_qipao1"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3) resizingMode:UIImageResizingModeStretch];
    _mQipao.image = img;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
