//
//  BalanceVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "BalanceVC.h"

@interface BalanceVC ()

@end

@implementation BalanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"余额";
    
    _mBack.layer.masksToBounds = YES;
    _mBack.layer.cornerRadius = 5;
    _mMoney.text = [NSString stringWithFormat:@"%g",_mBalance];
    
    
    if(_mBalance>0){
        _mTixian.backgroundColor = M_CO;
        _mTixian.userInteractionEnabled = YES;
    }else{
        _mTixian.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
        _mTixian.userInteractionEnabled = NO;
    }
    
    [SUser getBalance:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            
            float money = [[retobj.mdata objectForKey:@"balance"] floatValue];
            
            _mMoney.text = [NSString stringWithFormat:@"%g",money];
            
            if(money>0){
                _mTixian.backgroundColor = M_CO;
                _mTixian.userInteractionEnabled = YES;
            }else{
                _mTixian.backgroundColor = [UIColor colorWithRed:216/255.0 green:216/255.0 blue:216/255.0 alpha:1];
                _mTixian.userInteractionEnabled = NO;
            }
            
            [SVProgressHUD dismiss];
            
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

- (IBAction)mBackClick:(id)sender {
    
    [self leftBtnTouched:sender];
}
@end
