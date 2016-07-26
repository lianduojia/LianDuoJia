//
//  OrderCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initCell:(SOrder *)order index:(int)index{
    
    NSString *type = @"";
    if (order.mMaids.count>0) {
        
        type = [[order.mMaids objectAtIndex:0] objectForKey:@"work_type"];
        [_mHeadImg sd_setImageWithURL:[NSURL URLWithString:[[APIClient sharedClient] photoUrl:[[order.mMaids objectAtIndex:0] objectForKey:@"photo_url"]]] placeholderImage:[UIImage imageNamed:@"o_default"]];
    }
    
    if([order.mGoods_info isEqualToString:@"中介费"]){
        
        _mTitle.text = [NSString stringWithFormat:@"预约%lu位%@",(unsigned long)order.mMaids.count,type];
        _mMoneylabel.text = @"中介费";
    }else{
        _mTitle.text = [NSString stringWithFormat:@"聘用%lu位%@",(unsigned long)order.mMaids.count,type];
        _mMoneylabel.text = @"月薪";
    }
    switch (index) {
        case 0:
            
            
            break;
            
        default:
            break;
    }
    
   
    NSString *stringName = @"";
    if (order.mMaids.count>0) {
        for (NSDictionary *s in order.mMaids) {
            stringName = [stringName stringByAppendingString:[NSString stringWithFormat:@"%@ ",[s objectForKey:@"maid_name"]]];
        }
    }
    _mDetail.text = stringName;
    
    _mOrderNo.text = [NSString stringWithFormat:@"订单号：%@",order.mNo];
    
    _mMoney.text = [NSString stringWithFormat:@"¥%d",order.mAmount];
    
    
}

-(void)initPjCell:(SOrder *)order{
    
    _mButtonTwo.hidden = NO;
    if ([order.mStatus isEqualToString:@"聘用"]) {
        [_mButtonTwo setTitle:@"已聘用" forState:UIControlStateNormal];
        _mButtonTwo.userInteractionEnabled = NO;
    }else{
        [_mButtonTwo setTitle:@"聘用阿姨" forState:UIControlStateNormal];
        _mButtonTwo.userInteractionEnabled = YES;
    }
    
    [_mHeadImg sd_setImageWithURL:[NSURL URLWithString:order.mMail_photo_url] placeholderImage:[UIImage imageNamed:@"o_default"]];
    _mTitle.text = [NSString stringWithFormat:@"预约%@",order.mMail_name];
    _mOrderNo.text = order.mMail_work_type;
    _mDetail.text = [NSString stringWithFormat:@"%@见面",order.mMeet_location];
}

@end
