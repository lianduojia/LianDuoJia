//
//  HourWorkPayVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/24.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "HourWorkPayVC.h"

@interface HourWorkPayVC ()

@end

@implementation HourWorkPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"订单支付";
    _mAddress.text = _mAddr;
    _mTime.text = _mServiceTime;
    _mPhone.text = [SUser currentUser].mPhone;
    
    _mMoney.text = [NSString stringWithFormat:@"¥%d",_mOrder.mAmount];
}

- (void)leftBtnTouched:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

- (IBAction)mPayClick:(id)sender {
    
    [self showStatu:@"支付中"];
    [Order aliPay:@"小时工" orderNo:_mOrder.mNo price:_mOrder.mAmount detail:@"薪水" block:^(SResBase *retobj) {
        if (retobj.msuccess) {
            
//            [_mOrder payOK:^(SResBase *retobj) {
            
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                self.tabBarController.selectedIndex = 1;
//            }];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
            
        }
    }];

}
@end
