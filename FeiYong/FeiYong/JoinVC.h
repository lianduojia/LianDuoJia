//
//  JoinVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/15.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinVC : BaseVC
@property (weak, nonatomic) IBOutlet UITextField *mName;
@property (weak, nonatomic) IBOutlet UITextField *mPhone;
@property (weak, nonatomic) IBOutlet UITextField *mAddress;
@property (weak, nonatomic) IBOutlet UITextView *mRemark;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;
- (IBAction)mSubmitClick:(id)sender;

- (IBAction)mChoseAddress:(id)sender;
@end
