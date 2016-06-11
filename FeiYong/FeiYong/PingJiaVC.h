//
//  PingJiaVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingJiaVC : BaseVC

@property (nonatomic,strong) SAuntInfo *mAunt;
@property (nonatomic,strong) NSString *mPjType; //评论类型:工作评价、一面之缘、线上评价
@property (weak, nonatomic) IBOutlet UITextView *mPingjia;

@property (weak, nonatomic) IBOutlet UILabel *mLable;
@property (weak, nonatomic) IBOutlet UIImageView *mStar1;
@property (weak, nonatomic) IBOutlet UIImageView *mStar2;
@property (weak, nonatomic) IBOutlet UIImageView *mStar3;
@property (weak, nonatomic) IBOutlet UIImageView *mStar4;
@property (weak, nonatomic) IBOutlet UIImageView *mStar5;
- (IBAction)mSubmitClick:(id)sender;
@end
