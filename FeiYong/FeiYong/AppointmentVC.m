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
    
    YLDatePickerView *_picker;
    BombBoxVC *_mbombbox;
    
    NSString *_date;
    NSString *_time;
}

@end

@implementation AppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"预约见面";
    
    _mbombbox = [[BombBoxVC alloc] initWithNibName:@"BombBoxVC" bundle:nil];
    _mbombbox.view.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    
    _picker =  [[[NSBundle mainBundle]loadNibNamed:@"YLDatePickerView" owner:self options:nil]objectAtIndex:0];
    
    [_picker SetTextFieldDate:_mTime];
    
    [_picker setDatePickerType:UIDatePickerModeTime dateFormat:@"HH:mm"];
    
    NSString *string = @"";
    
    if (_mTempArray) {
        for (SAuntInfo *aunt in _mTempArray) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@ ",aunt.mName]];
        }

    }else{
    
        for (NSString *s in _mOrder.mMaids) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@ ",s]];
        }
    }
    
    _mName.text = string;

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

- (IBAction)ChoseDayClick:(id)sender {
    
    [self.view addSubview:_mbombbox.view];
    
    [_mbombbox initCalendarPickView:^(NSInteger day, NSInteger month, NSInteger year) {
        
        _mDay.text = [NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
        
        _date = [Util getTimeString:[Util getDataString:_mDay.text bfull:YES] bfull:YES];
        
        [_mbombbox closeCalendarPickView];

    }];

}

- (IBAction)ChoseTimeClick:(id)sender {
    
    [_picker showInView:self.view];
}

- (IBAction)SubmitClick:(id)sender {
    
    _time = _mTime.text;
    
    if (_date.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择见面日期"];
        
        return;
    }
    
    if ([_time isEqualToString:@"请选择见面时间"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择见面时间"];
        
        return;
    }
    
    if (_mAddress.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择见面地点"];
        return;
    }
    
    [self showStatu:@"提交中.."];
    [_mOrder makeAppointment:_date meet_time:_time meet_location:_mAddress.text block:^(SResBase *retobj) {
       
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
