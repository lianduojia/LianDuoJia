//
//  AppointmentVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentVC : BaseVC

@property (nonatomic,strong) NSString *mAuntName;
@property (nonatomic,strong) SOrder *mOrder;
@property (nonatomic,strong) NSArray *mTempArray;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mDay;
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UITextField *mAddress;
- (IBAction)ChoseDayClick:(id)sender;
- (IBAction)ChoseTimeClick:(id)sender;
- (IBAction)SubmitClick:(id)sender;
@end
