//
//  OpinionVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "OpinionVC.h"

@interface OpinionVC ()

@end

@implementation OpinionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"意见反馈";
    
    [self.navBar.mRightButton setTitle:@"完成" forState:UIControlStateNormal];
}

- (void)rightBtnTouched:(id)sender{

    if (_mOpinion.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请填写意见和建议"];
        return;
    }
    
    if (_mName.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请填写您的称呼"];
        return;
    }
    
    [self showStatu:@"提交中.."];
    [SUser feedBack:_mName.text content:_mOpinion.text block:^(SResBase *retobj) {
       
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

@end
