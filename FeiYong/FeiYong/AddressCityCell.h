//
//  AddressCityCell.h
//  FeiYong
//
//  Created by 周大钦 on 16/9/1.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mActivity;

@property (weak, nonatomic) IBOutlet UIButton *mJhBt;
@property (weak, nonatomic) IBOutlet UIButton *mBjBt;
@property (weak, nonatomic) IBOutlet UIButton *mShBt;
@property (weak, nonatomic) IBOutlet UIButton *mGzBt;
@property (weak, nonatomic) IBOutlet UIButton *mSzBt;
@end
