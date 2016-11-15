//
//  ComplaintVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/11.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ComplaintVC.h"

@interface ComplaintVC (){

    BOOL _istuikuan;
}

@end

@implementation ComplaintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"投诉";
    
    self.navRightText = @"提交";
    
}

- (void)rightBtnTouched:(id)sender{

    if (_mContent.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入投诉内容"];
        return;
    }
    
    [self showStatu:@"操作中.."];
    
    [_mOrder submitSuggest:_mContent.text refund:_istuikuan block:^(SResBase *retobj) {
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
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

- (IBAction)mCheckClick:(id)sender {
    
    _istuikuan = !_istuikuan;
    if (_istuikuan) {
        [_mButton setImage:[UIImage imageNamed:@"f_quan_huan"] forState:UIControlStateNormal];
    }else{
        [_mButton setImage:[UIImage imageNamed:@"f_quan"] forState:UIControlStateNormal];
    }
}
@end
