//
//  AppointmentVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AppointmentVC.h"
#import "BombBoxVC.h"
#import "YLDatePickerView.h"
#import "Util.h"

@interface AppointmentVC (){
    
    YLDatePickerView *_datepicker;
    BombBoxVC *_mbombbox;
    
}

@end

@implementation AppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"预约见面";
    
    
    
    _datepicker =  [[[NSBundle mainBundle]loadNibNamed:@"YLDatePickerView" owner:self options:nil]objectAtIndex:0];
    
    [_datepicker SetTextFieldDate:_mTime];
    
    [_datepicker setDatePickerType:UIDatePickerModeDateAndTime dateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *string = @"";
    
    if (_mTempArray) {
        for (SAuntInfo *aunt in _mTempArray) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@ ",aunt.mName]];
        }

    }else{
    
        for (NSDictionary *s in _mOrder.mMaids) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@ ",[s objectForKey:@"maid_name"]]];
        }
    }
    
    _mName.text = string;
    
    _mDefaultHeight.constant = 0;
    _mDefaultBottomHeight.constant = 0;
    
    [_mOrder getDefaultAddress:^(SResBase *retobj, NSString *address) {
       
        if (retobj.msuccess) {
            
            if (address.length>0) {
                _mDefaultBottomHeight.constant = 10;
                _mDefaultHeight.constant = 500;
                _mDefaultAddress.text = address;
            }
        }
    }];

}

-(void)leftBtnTouched:(id)sender{

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

- (IBAction)mCheckClick:(id)sender {
    
    _mCheck.selected = !_mCheck.selected;
    
    if (_mCheck.selected) {
        [_mCheck setImage:[UIImage imageNamed:@"a_quan_select"] forState:UIControlStateNormal];
        
        _mAddress.text = _mDefaultAddress.text;
    }else{
        [_mCheck setImage:[UIImage imageNamed:@"a_quan"] forState:UIControlStateNormal];
        _mAddress.text = @"";
    }
}

- (IBAction)ChoseDayClick:(id)sender {
    
    [_datepicker showInView:self.view];

}



- (IBAction)SubmitClick:(id)sender {
    
    
    if (_mTime.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择见面时间"];
        
        return;
    }
    
    if (_mAddress.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择见面地点"];
        return;
    }
    
    [self showStatu:@"提交中.."];
    [_mOrder makeAppointment:_mTime.text meet_location:_mAddress.text block:^(SResBase *retobj) {
       
        if (retobj.msuccess) {
            [SVProgressHUD dismiss];
            
            [_mOrder payOK:^(SResBase *retobj) {
               
                if (retobj.msuccess) {
                    
                    //初始化提示框；
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜您预约成功 请您准时赴约！" preferredStyle:  UIAlertControllerStyleAlert];
                    
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        //点击按钮的响应事件；
                        
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }]];
                    
                    //弹出提示框；
                    [self presentViewController:alert animated:true completion:nil];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                }
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
}



@end
