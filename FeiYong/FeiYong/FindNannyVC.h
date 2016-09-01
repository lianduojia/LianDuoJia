//
//  FindNannyVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/8/12.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSlider.h"

@interface FindNannyVC : BaseVC

@property (weak, nonatomic) IBOutlet UIImageView *mBanner;
@property (nonatomic,assign) int mType;
@property (weak, nonatomic) IBOutlet UIImageView *mJiantou;
@property (weak, nonatomic) IBOutlet UITextField *mAddress;
@property (weak, nonatomic) IBOutlet UITextField *mHuji;
@property (weak, nonatomic) IBOutlet UITextField *mAge;

@property (weak, nonatomic) IBOutlet UITextField *mTime;
@property (weak, nonatomic) IBOutlet UITextField *mTimeLength;


@property (weak, nonatomic) IBOutlet UILabel *mPholder;
@property (weak, nonatomic) IBOutlet UITextView *mRemark;
//流程图 高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mGroupHeight;
@property (weak, nonatomic) IBOutlet YLSlider *mSlider;
@property (weak, nonatomic) IBOutlet UILabel *mStar;
@property (weak, nonatomic) IBOutlet UILabel *mStarDetail;
@property (weak, nonatomic) IBOutlet UIImageView *mQipao;


@property (weak, nonatomic) IBOutlet UIButton *mItem1;
@property (weak, nonatomic) IBOutlet UIButton *mItem2;
@property (weak, nonatomic) IBOutlet UIButton *mItem3;

//小时工
@property (weak, nonatomic) IBOutlet UIButton *mHourBT;
@property (weak, nonatomic) IBOutlet UIButton *mNumBT;
@property (weak, nonatomic) IBOutlet UIButton *mCheck1;
@property (weak, nonatomic) IBOutlet UIButton *mCheck2;
@property (weak, nonatomic) IBOutlet UIButton *mCheck3;


//其它服务高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mOtherHeight;
@property (weak, nonatomic) IBOutlet UIView *mContentView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIImageView *mOtherJiantou;

- (IBAction)mAddressClick:(id)sender;
- (IBAction)mHujiClick:(id)sender;
- (IBAction)mAgeClick:(id)sender;
- (IBAction)mRemarkClick:(id)sender;
- (IBAction)mTimeClick:(id)sender;
- (IBAction)mTimeLengthClick:(id)sender;

//陪护
- (IBAction)mSexClick:(id)sender;
- (IBAction)mDayClick:(id)sender;
- (IBAction)mManClick:(id)sender;

//小时工
- (IBAction)mHourClick:(id)sender;
- (IBAction)mNumClick:(id)sender;

- (IBAction)mCheckClick:(id)sender;


- (IBAction)mSubmitClick:(id)sender;
- (IBAction)mOpenClick:(id)sender;
- (IBAction)mOpenOtherClick:(id)sender;
@end
