//
//  EditAddressVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "EditAddressVC.h"
#import "ChoseAddress.h"

@interface EditAddressVC (){

    NSString *_province;
    NSString *_city;
    NSString *_area;
}

@end

@implementation EditAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_mTempAddress) {
        self.navTitle = @"编辑地址";
        
        _mName.text = _mTempAddress.mLink_man;
        _mPhone.text = _mTempAddress.mLink_phone;
        _mAddress.text = [NSString stringWithFormat:@"%@%@%@",_mTempAddress.mAddress_province,_mTempAddress.mAddress_city,_mTempAddress.mAddress_area];
        _province = _mTempAddress.mAddress_province;
        _city = _mTempAddress.mAddress_city;
        _area = _mTempAddress.mAddress_area;
        _mAddressDetail.text = _mTempAddress.mAddress_detail;
        
    }else{
        self.navTitle = @"编辑地址";
    }
    
    [self.navBar.mRightButton setTitle:@"完成" forState:UIControlStateNormal];
}

- (void)rightBtnTouched:(id)sender{

    if (_mName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写姓名"];
        [_mName becomeFirstResponder];
        return;
    }
    if (_mPhone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写手机号码"];
        [_mPhone becomeFirstResponder];
        return;
    }
    if (_mAddress.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"选择地区"];
        return;
    }
    if (_mAddressDetail.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写详细地址"];
        [_mAddressDetail becomeFirstResponder];
        return;
    }
    [self showStatu:@"操作中.."];
    [SUser editAddress:_mTempAddress.mAddress_id address_province:_province address_city:_city address_area:_area address_detail:_mAddressDetail.text link_man:_mName.text link_phone:_mPhone.text block:^(SResBase *retobj) {
       
        if (retobj.msuccess) {
            
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            _itblcok(YES);
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
