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
@property (weak, nonatomic) IBOutlet UIView *mContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mContentHeight;
@property (weak, nonatomic) IBOutlet UIImageView *mEmpty;


- (IBAction)mAddressClick:(id)sender;
@end
