//
//  BombBoxVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "BombBoxVC.h"
#import "JFCalendarPickerView.h"

@interface BombBoxVC ()

@end

@implementation BombBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
//    
//    [self.view addGestureRecognizer:tap];
    
}

- (void)close{
    [self closeCalendarPickView];
}

-(void)initCalendarPickView:(void(^)(NSInteger day, NSInteger month, NSInteger year))block{

    self.mBoxView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.mBoxView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.mBoxView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.mBoxView.layer.shadowRadius = 10;//阴影半径，默认3
    JFCalendarPickerView *calendarPicker = [JFCalendarPickerView showOnView:self.mBoxView];
    calendarPicker.layer.masksToBounds = YES;
    calendarPicker.layer.cornerRadius = 8;
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    calendarPicker.frame = self.mBoxView.bounds;
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        block(day,month,year);
    };
    
}

-(void)closeCalendarPickView{
    
    [UIView animateWithDuration:0.3 animations:^(void) {
        
        self.mBoxView.frame = CGRectMake(self.mBoxView.frame.origin.x, DEVICE_Height, self.mBoxView.frame.size.width, self.mBoxView.frame.size.height);
        
    } completion:^(BOOL isFinished) {
        
        [self.view removeFromSuperview];
        for (UIView *view in self.mBoxView.subviews) {
            [view removeFromSuperview];
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

@end
