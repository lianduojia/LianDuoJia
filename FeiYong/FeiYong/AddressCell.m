//
//  AddressCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)initCell:(SAddress *)address{

    _mName.text = address.mLink_man;
    _mPhone.text = address.mLink_phone;
    _mAddress.text = [NSString stringWithFormat:@"%@%@%@%@",address.mAddress_province,address.mAddress_city,address.mAddress_area,address.mAddress_detail];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
