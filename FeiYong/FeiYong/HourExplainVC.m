//
//  HourExplainVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/2.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "HourExplainVC.h"
#import "ChoseAddress.h"
#import "HourView.h"

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

    float yy = 0;
    
    for (UIView *view in _mContentView.subviews) {
        
        if (![view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0;i < arr.count;i++) {
        
        SHour *hour = [arr objectAtIndex:i];
        
        HourView *hv = [HourView shareView];
//        hv.backgroundColor = [UIColor redColor];

        hv.layer.masksToBounds = YES;
        hv.layer.cornerRadius = 5;
        hv.layer.borderColor = M_CO.CGColor;
        hv.layer.borderWidth = 1;
        
        hv.mLabel.text = hour.mLabel;
        hv.mContent.text = hour.mContent;
        
        if (i == 0) {
            hv.frame = CGRectMake(15, yy, DEVICE_Width-30, 65);
            yy +=65+8;
        }else{
        
            if (i%2==0) {
                hv.frame = CGRectMake(DEVICE_Width/2+4, yy, (DEVICE_Width-30)/2-4, 65);
            }else{
                hv.frame = CGRectMake(15, yy, (DEVICE_Width-30)/2-4, 65);
            }

            yy+=((i+1)%2)*(65+8);
        }
        
        [_mContentView addSubview:hv];
    }
    
    if (arr.count == 0) {
        _mEmpty.hidden = NO;
        _mContentHeight.constant = 300;
    }else{
        _mEmpty.hidden = YES;
        _mContentHeight.constant = yy;
    }
    
    
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
