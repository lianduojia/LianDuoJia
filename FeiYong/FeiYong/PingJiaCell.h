//
//  PingJiaCell.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingJiaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UIButton *mWork;
@property (weak, nonatomic) IBOutlet UILabel *mContent;
@property (weak, nonatomic) IBOutlet UILabel *mTime;

-(void)initCell:(SComment *)comment;

@end
