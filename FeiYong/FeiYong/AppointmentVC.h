//
//  AppointmentVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentVC : BaseVC

@property (weak, nonatomic) IBOutlet UIButton *mCheck;
@property (nonatomic,strong) NSString *mAuntName;
@property (nonatomic,strong) SOrder *mOrder;
@property (nonatomic,strong) NSArray *mTempArray;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UITextField *mTime;

@property (weak, nonatomic) IBOutlet UITextField *mAddress;

@property (weak, nonatomic) IBOutlet UILabel *mDefaultAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mDefaultHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mDefaultBottomHeight;

- (IBAction)mCheckClick:(id)sender;

- (IBAction)ChoseDayClick:(id)sender;

- (IBAction)SubmitClick:(id)sender;
@end
