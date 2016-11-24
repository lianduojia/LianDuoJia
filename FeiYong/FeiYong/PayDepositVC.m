//
//  PayDepositVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/23.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "PayDepositVC.h"

@interface PayDepositVC ()

@end

@implementation PayDepositVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"支付定金";
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

- (IBAction)PayClick:(id)sender {
    
    switch (_mType) {
        case ZHUJIABAOMU:
            _type = @"住家保姆";
            break;
        case BUZHUJIABAOMU:
            _type = @"不住家保姆";
            break;
        case YUESAO:
            _type = @"月嫂";
            break;
        case PEIHU:
            _type = @"陪护";
            break;
            
        default:
            break;
    }
    
    [self showStatu:@"操作中.."];
    [SAuntInfo customBill:_sex min_age:_min_age max_age:_max_age star:_star type:_type work_province:_work_province work_city:_work_city work_area:_work_area work_address:_work_address province:_province service_time:_service_time service_duration:_service_duration over_night:_over_night care_type:_care_type additional:_additional block:^(SResBase *retobj, NSString *bid) {
        if (retobj.msuccess) {
            
            [self goPay:bid];
            
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

-(void)goPay:(NSString *)bid{
    
    [Order aliPay:@"私人定制阿姨定金" orderNo:bid price:100 detail:@"私人定制阿姨定金" block:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
        }
    }];
}
@end
