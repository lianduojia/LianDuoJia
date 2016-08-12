//
//  RegisterVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "RegisterVC.h"
#import "SMS_SDK/SMSSDK.h"
#import "MZTimerLabel.h"
#import "WebVC.h"
#import "APIClient.h"
#import "UMMobClick/MobClick.h"

@interface RegisterVC ()<MZTimerLabelDelegate>{

    UILabel *timer_show;//倒计时label
}

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.hiddenNavBar = YES;
    
    _mQuan.layer.masksToBounds = YES;
    _mQuan.layer.cornerRadius = 4.5;
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

- (IBAction)getCodeClick:(id)sender {
    
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
    
    
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_mPhone.text zone:@"86" customIdentifier:@"" result:^(NSError *error) {
//        
//        if (!error) {
//            
//            [self timeCount];
//            
//        }else{
////            [self timeCount];
//            [SVProgressHUD showErrorWithStatus:error.description];
//        }
//    }];
    [SUser getCode:_mPhone.text block:^(SResBase *retobj) {
       
        if (retobj.msuccess) {
            [self timeCount];
        }else{
//            [self timeCount];
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (void)timeCount{//倒计时函数
    
    [_mCodeBt setTitle:nil forState:UIControlStateNormal];//把按钮原先的名字消掉
    
    timer_show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _mCodeBt.frame.size.width, _mCodeBt.frame.size.height)];//UILabel设置成和UIButton一样的尺寸和位置
    
    [_mCodeBt addSubview:timer_show];//把timer_show添加到_dynamicCode_btn按钮上
    MZTimerLabel *timer_cutDown = [[MZTimerLabel alloc] initWithLabel:timer_show andTimerType:MZTimerLabelTypeTimer];//创建MZTimerLabel类的对象timer_cutDown
    [timer_cutDown setCountDownTime:60];//倒计时时间60s
    timer_cutDown.timeFormat = @"ss秒";//倒计时格式,也可以是@"HH:mm:ss SS"，时，分，秒，毫秒；想用哪个就写哪个
    timer_cutDown.timeLabel.textColor = M_TCO;//倒计时字体颜色
    timer_cutDown.timeLabel.font = [UIFont systemFontOfSize:17.0];//倒计时字体大小
    timer_cutDown.timeLabel.textAlignment = NSTextAlignmentCenter;//剧中
    timer_cutDown.delegate = self;//设置代理，以便后面倒计时结束时调用代理
    _mCodeBt.userInteractionEnabled = NO;//按钮禁止点击
    [timer_cutDown start];//开始计时
}
//倒计时结束后的代理方法
- (void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    [timer_show removeFromSuperview];//移除倒计时模块
    [_mCodeBt setTitle:@"获取验证码" forState:UIControlStateNormal];//倒计时结束后按钮名称改为"发送验证码"
    _mCodeBt.userInteractionEnabled = YES;//按钮可以点击
    
}


- (IBAction)mNextClick:(id)sender {
    
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

    if (_mCode.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"验证码不能为空！"];
        [_mCode becomeFirstResponder];
        return;
    }
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeClear];
    [SUser registers:_mPhone.text code:_mCode.text block:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            RegisterVC *reg = [[RegisterVC alloc] initWithNibName:@"RegisterTwoVC" bundle:nil];
            reg.mPhonenum = _mPhone.text;
            
            [self presentViewController:reg animated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
}

- (IBAction)mGoXieyiClick:(id)sender {
    
    WebVC *web = [[WebVC alloc] init];
    web.mName = @"用户协议";
    web.isMode = YES;
    web.mUrl = [NSString stringWithFormat:@"%@ra.html",[APIClient getDomain]];
    [self presentViewController:web animated:YES completion:nil];
}

- (IBAction)mRegisterClick:(id)sender {
    
    if(_mName.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"昵称不能为空！"];
        [_mName becomeFirstResponder];
        return;
    }
    if((_mName.text.length > 0 && _mName.text.length<2) || _mName.text.length > 10 ){
        [SVProgressHUD showErrorWithStatus:@"昵称为2～8个字！"];
        [_mName becomeFirstResponder];
        return;
    }
    if((_mPwd.text.length > 0 && _mPwd.text.length<4) || _mPwd.text.length > 16 ){
        [SVProgressHUD showErrorWithStatus:@"密码为4～16个字母或数字！"];
        [_mPwd becomeFirstResponder];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"注册中" maskType:SVProgressHUDMaskTypeClear];
    [SUser regist:_mName.text pwd:_mPwd.text phone:_mPhonenum block:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            
            [SUser login:_mPhonenum code:_mPwd.text block:^(SResBase *retobj) {
                
                if (retobj.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                    NSString *uid = [NSString stringWithFormat:@"%@",[SUser currentUser].mId];
                    [MobClick profileSignInWithPUID:uid];
                    [self.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                }
            }];
//            if ([self respondsToSelector:@selector(presentingViewController)]){
//                
//                [self.presentingViewController.presentingViewController dismissModalViewControllerAnimated:YES];
//                return;
//            }
//            else {
//                [self.parentViewController.parentViewController dismissModalViewControllerAnimated:YES];
//                return;
//            }

        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (IBAction)mBackClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
