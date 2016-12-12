//
//  CustomizedVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/12/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "CustomizedVC.h"
#import "FindNannyVC.h"

@interface CustomizedVC ()

@end

@implementation CustomizedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"专享定制阿姨";
    _mView.layer.masksToBounds = YES;
    _mView.layer.cornerRadius = 5;
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

- (IBAction)mItemClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;
    
    if (bt.tag == ZHUJIABAOMU || bt.tag == BUZHUJIABAOMU) {
        FindNannyVC *find = [[FindNannyVC alloc] initWithNibName:@"FindNannyVC" bundle:nil];
        find.mType = (int)bt.tag;;
        [self pushViewController:find];
        
        return;
    }
    
    if (bt.tag == YUESAO) {
        FindNannyVC *find = [[FindNannyVC alloc] initWithNibName:@"FindYueSaoVC" bundle:nil];
        find.mType = (int)bt.tag;;
        [self pushViewController:find];
        
        return;
    }
    
    if (bt.tag == PEIHU) {
        FindNannyVC *find = [[FindNannyVC alloc] initWithNibName:@"FindHuGongVC" bundle:nil];
        find.mType = (int)bt.tag;;
        [self pushViewController:find];
        
        return;
    }

}
@end
