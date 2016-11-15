//
//  ReAuntVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReAuntVC : BaseVC

@property (nonatomic,assign) BOOL mIsHour;
@property (nonatomic,strong) NSMutableArray *mTempArray;
@property (nonatomic,strong) NSString *mOverNight;  //住家  白班
@property (nonatomic,strong) NSString *mCareType;  //老人、病人
@property (nonatomic,strong) NSString *mType;  //服务类型
@property (nonatomic,strong) NSString *mDate;  //服务时间
@property (nonatomic,strong) NSString *mServiceTime;//服务时段 09:00
@property (nonatomic,strong) NSString *mServiceDuration;//服务时长 1小时
@property (nonatomic,strong) NSString *mServiceNum;//服务人数

@property (nonatomic,strong) NSString *mProvince;
@property (nonatomic,strong) NSString *mCity;
@property (nonatomic,strong) NSString *mArea;
@property (nonatomic,strong) NSString *mAddress;//详细地址
@property (nonatomic,strong) NSString *mRemark;         //备注 附加条件
@property (weak, nonatomic) IBOutlet UIButton *mPayBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mPayBtHeight;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)mPayClick:(id)sender;

@end
