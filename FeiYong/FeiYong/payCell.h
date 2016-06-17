//
//  payCell.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface payCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
@property (weak, nonatomic) IBOutlet UILabel *mPayMoney;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

-(void)initCell:(SAuntInfo *)aunt;

@end
