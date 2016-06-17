//
//  MyInfoVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "MyInfoVC.h"
#import "YLPickerView.h"

@interface MyInfoVC (){

    YLPickerView *_picker;
}

@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"个人信息";
    
    _picker = [[YLPickerView alloc] initWithNibName:@"YLPickerView" bundle:nil];
    
    [self.navBar.mRightButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self showStatu:@"加载中.."];
    [SUser getDetail:^(SResBase *retobj) {
        if (retobj.msuccess) {
            [SVProgressHUD dismiss];
            [self loadMyInfo];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

-(void)loadMyInfo{

    _mName.text = [SUser currentUser].mName;
    _mSex.text = [SUser currentUser].mSex;
    
}

- (void)rightBtnTouched:(id)sender{

    if (_mName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        
        return;
    }
    if ([_mSex.text isEqualToString:@"选择"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        
        return;
    }
    
    [self showStatu:@"保存中.."];
    [SUser updateInfo:_mName.text sex:_mSex.text photo_url:@"" block:^(SResBase *retobj) {
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
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

- (IBAction)ChoseAgeClick:(id)sender {
    
    [_picker initView:self.view block:^(NSString *sex) {
       
        _mSex.text = sex;
    }];
}

- (IBAction)ChosePhotoClick:(id)sender {
}
@end
