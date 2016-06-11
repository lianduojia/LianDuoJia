//
//  EmptyView.m
//  FeiYong
//
//  Created by 连多家 on 16/6/10.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "EmptyView.h"

@interface EmptyView ()

@end

@implementation EmptyView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)showInView:(UIView *)view rect:(CGRect)rect block:(void(^)(BOOL close))block{

    self.view.frame = rect;
    [view addSubview:self.view];
    
    self.itblock = ^(BOOL close){
    
        block(close);
    };
    
}

-(void)closeView{
    
    [self.view removeFromSuperview];
}

- (IBAction)buttonClick:(id)sender {
    
    _itblock(YES);
    
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
