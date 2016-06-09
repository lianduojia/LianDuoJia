//
//  LoginVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "ForgetPwdVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.hiddenNavBar = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ForgetPwdClick:(id)sender {
    
    ForgetPwdVC *fgp = [[ForgetPwdVC alloc] initWithNibName:@"ForgetPwdVC" bundle:nil];
    
    [self presentViewController:fgp animated:YES completion:nil];
}

- (IBAction)mLoginClick:(id)sender {
    
    if (_mPhone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不能为空！"];
        [_mPhone becomeFirstResponder];
        return;
    }
    if(_mPhone.text.length !=11){
        
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码！"];
        [_mPhone becomeFirstResponder];
        return;
    }
    if((_mPwd.text.length > 0 && _mPwd.text.length<4) || _mPwd.text.length > 16 ){
        [SVProgressHUD showErrorWithStatus:@"密码为4～16个字母或数字！"];
        [_mPwd becomeFirstResponder];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"登陆中" maskType:SVProgressHUDMaskTypeClear];
    [SUser login:_mPhone.text code:_mPwd.text block:^(SResBase *retobj) {
       
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (IBAction)mRegisterClick:(id)sender {
    
    RegisterVC *reg = [[RegisterVC alloc] initWithNibName:@"RegisterVC" bundle:nil];
    
    [self presentViewController:reg animated:YES completion:nil];
}

- (IBAction)BackClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
