//
//  ReAuntCell.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReAuntCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UIButton *mWorkBt;
@property (weak, nonatomic) IBOutlet UIButton *mYearBt;
@property (weak, nonatomic) IBOutlet UILabel *mAge;
@property (weak, nonatomic) IBOutlet UILabel *mPlace;
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
@property (weak, nonatomic) IBOutlet UILabel *mWages;
@property (weak, nonatomic) IBOutlet UIImageView *mStar1;
@property (weak, nonatomic) IBOutlet UIImageView *mStar2;
@property (weak, nonatomic) IBOutlet UIImageView *mStar3;
@property (weak, nonatomic) IBOutlet UIImageView *mStar4;
@property (weak, nonatomic) IBOutlet UIImageView *mStar5;

- (void)initCell:(SAuntInfo *)info;

@end
