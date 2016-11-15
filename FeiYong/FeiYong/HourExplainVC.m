//
//  HourExplainVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/2.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "HourExplainVC.h"
#import "ChoseAddress.h"

@interface HourExplainVC (){
    NSString *_province;
    NSString *_city;
    NSString *_area;
}

@end

@implementation HourExplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"资费说明";
    
    _mHourView.layer.masksToBounds = YES;
    _mHourView.layer.cornerRadius = 5;
    _mHourView.layer.borderColor = M_CO.CGColor;
    _mHourView.layer.borderWidth = 1;
    
    _mBlView.layer.masksToBounds = YES;
    _mBlView.layer.cornerRadius = 5;
    _mBlView.layer.borderColor = M_CO.CGColor;
    _mBlView.layer.borderWidth = 1;
    
    _mZfView.layer.masksToBounds = YES;
    _mZfView.layer.cornerRadius = 5;
    _mZfView.layer.borderColor = M_CO.CGColor;
    _mZfView.layer.borderWidth = 1;
    
    _mQjjView.layer.masksToBounds = YES;
    _mQjjView.layer.cornerRadius = 5;
    _mQjjView.layer.borderColor = M_CO.CGColor;
    _mQjjView.layer.borderWidth = 1;
    
    _mMbView.layer.masksToBounds = YES;
    _mMbView.layer.cornerRadius = 5;
    _mMbView.layer.borderColor = M_CO.CGColor;
    _mMbView.layer.borderWidth = 1;
    
    _mKhView.layer.masksToBounds = YES;
    _mKhView.layer.cornerRadius = 5;
    _mKhView.layer.borderColor = M_CO.CGColor;
    _mKhView.layer.borderWidth = 1;
    
    [self loadData];
    
}

- (void)loadData{

    if (_province.length == 0) {
        
        if([SAppInfo shareClient].mCity.length > 0){
            
            _province = [SAppInfo shareClient].mProvince;
            _city = [SAppInfo shareClient].mCity;
            _area = [SAppInfo shareClient].mArea;
            
            NSString *address = @"";
            
            if ([[SAppInfo shareClient].mCity isEqualToString:[SAppInfo shareClient].mProvince]) {
                address = [NSString stringWithFormat:@"%@%@",[SAppInfo shareClient].mCity,[SAppInfo shareClient].mArea];
            }else{
                address = [NSString stringWithFormat:@"%@%@%@",[SAppInfo shareClient].mProvince,[SAppInfo shareClient].mCity,[SAppInfo shareClient].mArea];
            }
            
            [_mAddress setTitle:address forState:UIControlStateNormal];
        }else{
        
            _province = @"浙江省";
            _city = @"金华市";
            _area = @"金东区";
            
            NSString *address = [NSString stringWithFormat:@"%@%@%@",_province,_city,_area];
            [_mAddress setTitle:address forState:UIControlStateNormal];
        }
    }
    
    [self showStatu:@"加载中.."];
    [SAuntInfo hourWorkerByAddress:_province city:_city area:_area block:^(SResBase *retobj, NSArray *hours) {
       
        if (retobj.msuccess) {
            [SVProgressHUD dismiss];
            
            [self loadContent:hours];
            
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}
//{"_no":1000,"_msg":"操作成功","_data":[{ "count":0,"service_item":"小时工最低时长" },{ "count":0,"service_item":"小时工" },{ "count":0,"service_item":"擦玻璃" },{ "count":0,"service_item":"开荒" },{ "count":0,"service_item":"做饭" },{ "count":0,"service_item":"抹布" },{ "count":0,"service_item":"清洁剂" }]}

- (void)loadContent:(NSArray *)arr{

    int min = 0;
    int price = 0;
    for (SHour *hour in arr) {
        if ([hour.mService_item isEqualToString:@"小时工最低时长"]) {
            min = hour.mCount;
        }
        
        if ([hour.mService_item isEqualToString:@"小时工"]) {
            price = hour.mCount;
            
            if (hour.mCount == 0) {
                
                _mCotentView.hidden = YES;
            }else{
                
                _mCotentView.hidden = NO;
            }
        }
        
        if ([hour.mService_item isEqualToString:@"擦玻璃"]) {
            _mContent2.text = [NSString stringWithFormat:@"每小时增加%d元",hour.mCount];
        }
        
        if ([hour.mService_item isEqualToString:@"做饭"]) {
            _mContent3.text = [NSString stringWithFormat:@"每小时增加%d元",hour.mCount];
        }
        
        if ([hour.mService_item isEqualToString:@"清洁剂"]) {
            _mContent4.text = [NSString stringWithFormat:@"收费%d元",hour.mCount];
        }
        
        if ([hour.mService_item isEqualToString:@"抹布"]) {
            _mContent5.text = [NSString stringWithFormat:@"收费%d元",hour.mCount];
        }
        
        if ([hour.mService_item isEqualToString:@"开荒"]) {
            _mContent6.text = [NSString stringWithFormat:@"每小时增加%d元",hour.mCount];
        }
    }
    
    _mContent1.text = [NSString stringWithFormat:@"%d小时起做 每小时%d元",min,price];
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

- (IBAction)mAddressClick:(id)sender {
    
    ChoseAddress *ca = [[ChoseAddress alloc] initWithNibName:@"ChoseAddress" bundle:nil];
    ca.mVC = self;
    ca.itblock = ^(NSString *province,NSString *city,NSString *area){
        _province = province;
        _city = city;
        _area = area;
        
        if ([_province isEqualToString:_city]) {
            [_mAddress setTitle:[NSString stringWithFormat:@"%@%@",city,area] forState:UIControlStateNormal];
        }else{
            [_mAddress setTitle:[NSString stringWithFormat:@"%@%@%@",province,city,area] forState:UIControlStateNormal];
        }

        
        
        [self loadData];
        
    };
    [self pushViewController:ca];
}
@end
