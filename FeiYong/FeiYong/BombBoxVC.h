//
//  BombBoxVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentalServiceVC.h"

@interface BombBoxVC : UIViewController

@property (nonatomic,strong) id<ParentalServiceDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *mBoxView;
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *mBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mSubmitHeight;

- (IBAction)mSubmitClick:(id)sender;
//弹出日历框
-(void)initCalendarPickView:(void(^)(NSInteger day, NSInteger month, NSInteger year))block;


-(void)initTimeIntervalView:(UIView *)view title:(NSString *)title index:(int)index Array:(NSArray *)arry;

-(void)closeCalendarPickView;


@end
