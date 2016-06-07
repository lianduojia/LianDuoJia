//
//  BombBoxVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BombBoxVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *mBoxView;

//弹出日历框
-(void)initCalendarPickView:(void(^)(NSInteger day, NSInteger month, NSInteger year))block;

-(void)closeCalendarPickView;

@end
