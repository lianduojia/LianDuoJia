//
//  BalanceVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceVC : BaseVC
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
@property (weak, nonatomic) IBOutlet UIButton *mBack;
- (IBAction)mBackClick:(id)sender;

@end
