//
//  HealthCareVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/9/18.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthCareVC : BaseVC

@property (nonatomic,assign) int mType;
@property (weak, nonatomic) IBOutlet UIImageView *mJjyl;
@property (weak, nonatomic) IBOutlet UIImageView *mYdyl;
@property (weak, nonatomic) IBOutlet UIImageView *mKfyl;

@property (weak, nonatomic) IBOutlet UIImageView *mJkyl;
@property (weak, nonatomic) IBOutlet UIImageView *mAyyl;

@property (weak, nonatomic) IBOutlet UIImageView *mFlb;
@property (weak, nonatomic) IBOutlet UIImageView *mHg;
@property (weak, nonatomic) IBOutlet UIImageView *mRb;


@end
