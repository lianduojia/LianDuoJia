//
//  JoinVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/15.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "JoinVC.h"
#import "ChoseAddress.h"

@interface JoinVC ()<UITextViewDelegate>{

    NSString *_province;
    NSString *_city;
    NSString *_area;
}

@end

@implementation JoinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"商户加盟";
    
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
        _mLabel.text = @"请输入留言";
    }else{
        _mLabel.text = @"";
    }
}

- (IBAction)mSubmitClick:(id)sender {
    
    if (_mPhone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的手机号"];
        
        [_mPhone becomeFirstResponder];
        return;
    }
    
    [self showStatu:@"提交中.."];
    [SUser joinShop:_province address_city:_city address_area:_area link_man:_mName.text link_phone:_mPhone.text block:^(SResBase *retobj) {
       
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (IBAction)mChoseAddress:(id)sender {
    
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
@end
