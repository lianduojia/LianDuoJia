//
//  HourWorkPayVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/24.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourWorkPayVC : BaseVC

@property (nonatomic,strong) SOrder *mOrder;
@property (nonatomic,strong) NSString *mAddr;
@property (nonatomic,strong) NSString *mServiceTime;
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UILabel *mPhone;
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
- (IBAction)mPayClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *mCheck;
@property (weak, nonatomic) IBOutlet UILabel *mGoodsText;
- (IBAction)mCheckClick:(id)sender;

- (IBAction)mGoodsClick:(id)sender;
@end
