//
//  AuntHeadView.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuntHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UIImageView *mStar1;
@property (weak, nonatomic) IBOutlet UIImageView *mStar2;
@property (weak, nonatomic) IBOutlet UIImageView *mStar3;
@property (weak, nonatomic) IBOutlet UIImageView *mStar4;
@property (weak, nonatomic) IBOutlet UIImageView *mStar5;
@property (weak, nonatomic) IBOutlet UIButton *mPjBt;
@property (weak, nonatomic) IBOutlet UIImageView *mYuanImg;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

+ (AuntHeadView *)shareView;

@end
