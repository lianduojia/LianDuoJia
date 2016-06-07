//
//  LoginVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : BaseVC
@property (weak, nonatomic) IBOutlet UITextField *mPhone;
@property (weak, nonatomic) IBOutlet UITextField *mPwd;
- (IBAction)ForgetPwdClick:(id)sender;
- (IBAction)mLoginClick:(id)sender;
- (IBAction)mRegisterClick:(id)sender;
- (IBAction)BackClick:(id)sender;

@end
