//
//  ChosePlaceVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/23.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ChosePlaceVC.h"

@interface ChosePlaceVC (){

    UIButton *_tempbt;
}

@end

@implementation ChosePlaceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"户籍要求";
    
    _mButton.selected = YES;
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

- (IBAction)mClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"s_bt_select"] forState:UIControlStateNormal];
    }else{
        [btn setBackgroundImage:[UIImage imageNamed:@"s_bt"] forState:UIControlStateNormal];
    }

}

- (IBAction)mSubmitClick:(id)sender {
    
    NSString *string = @"";
    
    for (UIButton *bt in _mContentView.subviews) {
        
        if (bt.selected) {
            
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@,",bt.titleLabel.text]];
        }
    }
    
    if (_itblock) {
        _itblock(string);
    }
    
    [self popViewController];
}
@end
