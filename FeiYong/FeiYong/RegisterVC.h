//
//  RegisterVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC : BaseVC
@property (weak, nonatomic) IBOutlet UITextField *mName;
@property (weak, nonatomic) IBOutlet UITextField *mPwd;

@property (weak, nonatomic) IBOutlet UITextField *mPhone;
@property (weak, nonatomic) IBOutlet UIButton *mCodeBt;
@property (weak, nonatomic) IBOutlet UITextField *mCode;
@property (weak, nonatomic) IBOutlet UIView *mQuan;
- (IBAction)getCodeClick:(id)sender;
- (IBAction)mNextClick:(id)sender;
- (IBAction)mGoXieyiClick:(id)sender;
- (IBAction)mRegisterClick:(id)sender;
- (IBAction)mBackClick:(id)sender;
@end
