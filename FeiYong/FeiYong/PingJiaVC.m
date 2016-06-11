//
//  PingJiaVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "PingJiaVC.h"

@interface PingJiaVC ()<UITextViewDelegate>{

    NSArray *_stararray;
    int _index;
}

@end

@implementation PingJiaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"评价";
    
    _mStar1.userInteractionEnabled = YES;
    _mStar2.userInteractionEnabled = YES;
    _mStar3.userInteractionEnabled = YES;
    _mStar4.userInteractionEnabled = YES;
    _mStar5.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoseClick:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoseClick:)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoseClick:)];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoseClick:)];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ChoseClick:)];
    [_mStar1 addGestureRecognizer:tap1];
    [_mStar2 addGestureRecognizer:tap2];
    [_mStar3 addGestureRecognizer:tap3];
    [_mStar4 addGestureRecognizer:tap4];
    [_mStar5 addGestureRecognizer:tap5];
    
    _stararray = [[NSArray alloc] initWithObjects:_mStar1,_mStar2,_mStar3,_mStar4,_mStar5, nil];
    
    
    _mPingjia.delegate = self;
    
    _index = 4;
}

- (void)ChoseClick:(UITapGestureRecognizer *)tap{
    
    _index = (int)tap.view.tag-10;
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *imgV = [_stararray objectAtIndex:i];
        
        if (i<=_index) {
            imgV.image = [UIImage imageNamed:@"a_star_big"];
        }else{
            imgV.image = [UIImage imageNamed:@"a_star_bighui"];
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _mLable.text = @"请输入您的评价";
    }else{
        _mLable.text = @"";
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

- (IBAction)mSubmitClick:(id)sender {
    
    if (_mPingjia.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评价内容！"];
        
        return;
    }
    
    [self showStatu:@"提交中.."];
    
    [_mAunt submitComment:_mPjType comment:_mPingjia.text star_count:_index+1 block:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            [self popViewController];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}
@end
