//
//  HealthCareVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/9/18.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "HealthCareVC.h"
#import "InformationVC.h"

@interface HealthCareVC ()

@end

@implementation HealthCareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    switch (_mType) {
        case YANGSHENGYANGLAO:
            self.navTitle = @"养生养老";
            break;
        case GAOJIBAOMU:
            self.navTitle = @"特级保姆";
            break;
        case JUJIAYANFLAO:
            self.navTitle = @"居家养老";
            break;
            
        default:
            break;
    }
    
    [self.navBar.mRightButton setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
    
    
    _mJjyl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(YanglaoClick)];
    [_mJjyl addGestureRecognizer:tap1];
    
    _mYdyl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(YanglaoClick)];
    [_mYdyl addGestureRecognizer:tap2];
    
    _mKfyl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(YanglaoClick)];
    [_mKfyl addGestureRecognizer:tap3];
    
    
    _mJkyl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JujiaClick)];
    [_mJkyl addGestureRecognizer:tap4];
    
    _mAyyl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(JujiaClick)];
    [_mAyyl addGestureRecognizer:tap5];
    
    
    _mFlb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GaojiBaomuClick)];
    [_mFlb addGestureRecognizer:tap6];
    
    _mHg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GaojiBaomuClick)];
    [_mHg addGestureRecognizer:tap7];
    
    _mRb.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GaojiBaomuClick)];
    [_mRb addGestureRecognizer:tap8];
}

- (void)YanglaoClick{
    
    InformationVC *info = [[InformationVC alloc] initWithNibName:@"InformationVC" bundle:nil];
    info.mType = @"养生养老";
    [self pushViewController:info];
}

- (void)JujiaClick{
    
    InformationVC *info = [[InformationVC alloc] initWithNibName:@"InformationVC" bundle:nil];
    info.mType = @"居家养老";
    [self pushViewController:info];
}

- (void)GaojiBaomuClick{
    
    InformationVC *info = [[InformationVC alloc] initWithNibName:@"InformationVC" bundle:nil];
    info.mType = @"特级保姆";
    [self pushViewController:info];
}

- (void)rightBtnTouched:(id)sender{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",TEL];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
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

@end
