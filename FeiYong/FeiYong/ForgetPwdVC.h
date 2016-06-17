//
//  ForgetPwdVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPwdVC : BaseVC
@property (weak, nonatomic) IBOutlet UIButton *mCodebt;
@property (weak, nonatomic) IBOutlet UITextField *mPhone;
@property (weak, nonatomic) IBOutlet UITextField *mCode;
@property (weak, nonatomic) IBOutlet UITextField *mPwd;
@property (weak, nonatomic) IBOutlet UIView *mPoint;
- (IBAction)mSubmit:(id)sender;
- (IBAction)mGetCode:(id)sender;
- (IBAction)mBackClick:(id)sender;
- (IBAction)goXieyiClick:(id)sender;

@end
