//
//  ParentalServiceVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ParentalServiceDelegate <NSObject>

- (void)selectString:(NSString *)string index:(int)index;

@end

@interface ParentalServiceVC : BaseVC<ParentalServiceDelegate>

@property (nonatomic,assign) int mType;

@property (weak, nonatomic) IBOutlet UIImageView *mHeadImg;
//流程
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mProcessHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mProcessHeight2;


//需求
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTableViewHeight;

//年龄

@property (weak, nonatomic) IBOutlet UILabel *mAgelb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mAgeHeight;
@property (weak, nonatomic) IBOutlet UIButton *mBuxian;
@property (weak, nonatomic) IBOutlet UIButton *mSwyn;
@property (weak, nonatomic) IBOutlet UIButton *mSwSb;
@property (weak, nonatomic) IBOutlet UIButton *mSbys;
- (IBAction)mAgeClick:(id)sender;

//服务时间
@property (weak, nonatomic) IBOutlet UILabel *mTimelb;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTimeHeight;
@property (weak, nonatomic) IBOutlet UIButton *mHome;
@property (weak, nonatomic) IBOutlet UIButton *mDay;
@property (weak, nonatomic) IBOutlet UIButton *mItem2;
@property (weak, nonatomic) IBOutlet UIButton *mOld;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mItemTwoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mItemThreeHeight;

- (IBAction)mItemClick:(id)sender;

- (IBAction)mItemTwoClick:(id)sender;

- (IBAction)mItemThreeClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *mRemarklb;
@property (weak, nonatomic) IBOutlet UITextView *mRemark;
@property (weak, nonatomic) IBOutlet UILabel *mRemarkHolder;


- (IBAction)mSumitClick:(id)sender;

@end
