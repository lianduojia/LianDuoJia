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
    
    if (order.mWork_type.length>0) {
        type = order.mWork_type;
    }else{
        
        if (order.mMaids.count>0) {
            
            type = [[order.mMaids objectAtIndex:0] objectForKey:@"work_type"];
            
            if (order.mMaids.count == 0) {
                
                [_mHeadImg sd_setImageWithURL:[NSURL URLWithString:[[APIClient sharedClient] photoUrl:[[order.mMaids objectAtIndex:0] objectForKey:@"photo_url"]]] placeholderImage:[UIImage imageNamed:@"o_default"]];
            }
        }
        
    }
    
    
    _mTitle.text = [NSString stringWithFormat:@"聘用%d位%@",order.mMaid_count,type];
    
    
//    if ([type isEqualToString:@"小时工"]) {
//        _mMoneylabel.text = @"工时费";
//    }
    
   
    NSString *stringName = @"";
    if (order.mMaids.count>0) {
        for (NSDictionary *s in order.mMaids) {
            stringName = [stringName stringByAppendingString:[NSString stringWithFormat:@"%@ ",[s objectForKey:@"maid_name"]]];
        }
    }
    _mDetail.text = stringName;
    
    _mOrderNo.text = [NSString stringWithFormat:@"订单号：%@",order.mNo];
    if (order.mAmount == order.mAll_amount) {
        _mMoneylabel.text = order.mGoods_info;
    }else{
        _mMoneylabel.text = @"金额";
    }
    _mMoney.text = [NSString stringWithFormat:@"¥%g",order.mAll_amount];
    
    
}

-(void)initPjCell:(SOrder *)order isGet:(BOOL)get{
    
    [_mHeadImg sd_setImageWithURL:[NSURL URLWithString:order.mMail_photo_url] placeholderImage:[UIImage imageNamed:@"o_default"]];
    
    _mOrderNo.text = order.mMail_work_type;
    if ([order.mMail_work_type isEqualToString:@"小时工"] || get) {
        _mTitle.text = [NSString stringWithFormat:@"%@",order.mMail_name];
        _mDetail.text = @"上门服务";
    }else{
        _mTitle.text = [NSString stringWithFormat:@"预约%@",order.mMail_name];
        _mDetail.text = [NSString stringWithFormat:@"%@见面",order.mMeet_location];
    }

    
}

@end
