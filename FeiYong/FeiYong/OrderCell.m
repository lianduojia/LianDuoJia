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

-(void)initCell:(SOrder *)order{

//    @property (weak, nonatomic) IBOutlet UILabel *mTitle;
//    @property (weak, nonatomic) IBOutlet UILabel *mDetail;
//    @property (weak, nonatomic) IBOutlet UILabel *mOrderNo;
//    @property (weak, nonatomic) IBOutlet UIButton *mButton;
//    @property (weak, nonatomic) IBOutlet UILabel *mMoney;
//    @property (weak, nonatomic) IBOutlet UILabel *mMoneylabel;
//    @property (unsafe_unretained, nonatomic) IBOutlet UIButton *mButtonTwo;
    if([order.mGoods_info isEqualToString:@"中介费"]){
       
        _mTitle.text = [NSString stringWithFormat:@"预约%d位%@",order.mMaid_count,order.mWork_type];
        _mMoneylabel.text = @"月薪";
    }else{
        _mTitle.text = [NSString stringWithFormat:@"聘用%d位%@",order.mMaid_count,order.mWork_type];
        _mMoneylabel.text = @"中介费";
    }
   
    NSString *stringName = @"";
    if (order.mMaids.count>0) {
        for (NSString *s in order.mMaids) {
            stringName = [stringName stringByAppendingString:[NSString stringWithFormat:@"%@ ",s]];
        }
    }
    _mDetail.text = stringName;
    
    _mOrderNo.text = [NSString stringWithFormat:@"订单号：%@",order.mNo];
    
    _mMoney.text = [NSString stringWithFormat:@"¥%d",order.mAmount];
    
    
}
@end
