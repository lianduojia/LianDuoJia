//
//  InformationVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/2.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "InformationVC.h"
#import "ChoseAddress.h"

@interface InformationVC ()<UITextViewDelegate>{
    
    NSString *_province;
    NSString *_city;
    NSString *_area;
}


@end

@implementation InformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"提交资料";
    _mName.layer.masksToBounds = YES;
    _mName.layer.cornerRadius = 3;
    
    _mPhone.layer.masksToBounds = YES;
    _mPhone.layer.cornerRadius = 3;
    
    _mAddress.layer.masksToBounds = YES;
    _mAddress.layer.cornerRadius = 3;
    
    _mRemark.layer.masksToBounds = YES;
    _mRemark.layer.cornerRadius = 3;
    
    [self setTextFieldLeftPadding:_mName forWidth:8];
    [self setTextFieldLeftPadding:_mPhone forWidth:8];
    [self setTextFieldLeftPadding:_mAddress forWidth:8];
    
    _mRemark.delegate = self;
}

-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
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

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _mHolder.text = @"请输入留言";
    }else{
        _mHolder.text = @"";
    }
}

- (IBAction)mAddressClick:(id)sender {
    
    ChoseAddress *ca = [[ChoseAddress alloc] initWithNibName:@"ChoseAddress" bundle:nil];
    ca.mVC = self;
    ca.itblock = ^(NSString *province,NSString *city,NSString *area){
        _province = province;
        _city = city;
        _area = area;
        _mAddress.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        
    };
    [self pushViewController:ca];
}

- (IBAction)mSubmitClick:(id)sender {
    
    if(_mPhone.text.length == 0){
        
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        [_mPhone becomeFirstResponder];
        return;
    }
    
    [self showStatu:@"提交中.."];
    
    [SUser uploadAdvancedBill:_province city:_city area:_area name:_mName.text phone:_mPhone.text submit_type:_mType submit_content:_mRemark.text block:^(SResBase *retobj) {
       
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
}
@end