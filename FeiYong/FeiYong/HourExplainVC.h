//
//  HourExplainVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/2.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourExplainVC : BaseVC
@property (weak, nonatomic) IBOutlet UIButton *mAddress;
@property (weak, nonatomic) IBOutlet UIView *mCotentView;
@property (weak, nonatomic) IBOutlet UIView *mHourView;
@property (weak, nonatomic) IBOutlet UIView *mBlView;
@property (weak, nonatomic) IBOutlet UIView *mZfView;
@property (weak, nonatomic) IBOutlet UIView *mQjjView;
@property (weak, nonatomic) IBOutlet UIView *mMbView;
@property (weak, nonatomic) IBOutlet UIView *mKhView;

@property (weak, nonatomic) IBOutlet UILabel *mLab1;
@property (weak, nonatomic) IBOutlet UILabel *mContent1;
@property (weak, nonatomic) IBOutlet UILabel *mLab2;
@property (weak, nonatomic) IBOutlet UILabel *mContent2;
@property (weak, nonatomic) IBOutlet UILabel *mLab3;
@property (weak, nonatomic) IBOutlet UILabel *mContent3;
@property (weak, nonatomic) IBOutlet UILabel *mLab4;
@property (weak, nonatomic) IBOutlet UILabel *mContent4;
@property (weak, nonatomic) IBOutlet UILabel *mLab5;
@property (weak, nonatomic) IBOutlet UILabel *mContent5;
@property (weak, nonatomic) IBOutlet UILabel *mLab6;
@property (weak, nonatomic) IBOutlet UILabel *mContent6;

- (IBAction)mAddressClick:(id)sender;
@end
