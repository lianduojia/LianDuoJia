//
//  ChoseAddressVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ChoseAddressVC.h"
#import "YLPickerView.h"
#import "AddressVC.h"
#import "ChoseAddress.h"

@interface ChoseAddressVC (){

    YLPickerView *_picker;
    
    NSString *_province;
    NSString *_city;
    NSString *_area;
}

@end

@implementation ChoseAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"选择地址";
    
    [self.navBar.mRightButton setImage:[UIImage imageNamed:@"s_address1"] forState:UIControlStateNormal];
    
    _picker = [[YLPickerView alloc] initWithNibName:@"YLPickerView" bundle:nil];
}

- (void)rightBtnTouched:(id)sender{

    AddressVC *addressVC = [[AddressVC alloc] initWithNibName:@"AddressVC" bundle:nil];
    
    addressVC.itblock = ^(SAddress *address){
    
        _province = address.mAddress_province;
        _city = address.mAddress_city;
        _area = address.mAddress_area;
        
        _mAdd.text = [NSString stringWithFormat:@"%@%@%@",_province,_city,_area];
        _mDetailAdd.text = address.mAddress_detail;
    };
    
    [self pushViewController:addressVC];
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

- (IBAction)mSubmitClick:(id)sender {
    
    if (_province.length == 0 || _city.length == 0 || _area.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择地区"];
        
        return;
    }
    
    if (_mDetailAdd.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请填写详细地址"];
        
        return;
    }
    
    if (_itblock) {
        _itblock(_mDetailAdd.text,_province,_city,_area);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mChoseClick:(id)sender {

    
    ChoseAddress *ca = [[ChoseAddress alloc] initWithNibName:@"ChoseAddress" bundle:nil];
    ca.mVC = self;
    ca.itblock = ^(NSString *province,NSString *city,NSString *area){
        _province = province;
        _city = city;
        _area = area;
        _mAdd.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
 
    };
    [self pushViewController:ca];
}
@end
