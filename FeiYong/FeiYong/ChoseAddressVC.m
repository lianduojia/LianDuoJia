//
//  ChoseAddressVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ChoseAddressVC.h"
#import "YLPickerView.h"

@interface ChoseAddressVC (){

    YLPickerView *_picker;
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
    
    if (_itblock) {
        _itblock(@"开阳桥",@"北京市",@"北京市",@"朝阳区");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mChoseClick:(id)sender {
    
    [_picker initView:self.view block:^(BOOL flag,NSString *province,NSString *city,NSString *area) {
        
        if (flag) {
            
            _mAdd.text = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        }
    }];
}
@end
