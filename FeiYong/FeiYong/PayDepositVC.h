//
//  PayDepositVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/23.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayDepositVC : BaseVC

@property (nonatomic,strong) NSMutableArray *mTempArray;
@property (nonatomic,assign) int mType;

@property (nonatomic,assign) int min_age;
@property (nonatomic,assign) int max_age;
@property (nonatomic,assign) int star;
@property (nonatomic,strong) NSString *service_duration;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *work_province;
@property (nonatomic,strong) NSString *work_city;
@property (nonatomic,strong) NSString *work_area;
@property (nonatomic,strong) NSString *work_address;
@property (nonatomic,strong) NSString *province;
@property (nonatomic,strong) NSString *service_time;
@property (nonatomic,strong) NSString *over_night;
@property (nonatomic,strong) NSString *care_type;
@property (nonatomic,strong) NSString *additional;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mGoAuntHeight;

@property (weak, nonatomic) IBOutlet UILabel *mNum;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;
- (IBAction)GoAuntClick:(id)sender;

- (IBAction)PayClick:(id)sender;
@end
