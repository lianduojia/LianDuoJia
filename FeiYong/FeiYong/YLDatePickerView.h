//
//  YLDatePickerView.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/13.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLDatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIButton *mCancel;
@property (weak, nonatomic) IBOutlet UIButton *mSubmit;
@property (weak, nonatomic) IBOutlet UIDatePicker *mPicker;
@property (strong, nonatomic) UILabel* m_pTextDate;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

-(void)submit;
-(void)close;

-(void)SetTextFieldDate:(UILabel *)textLabel;
- (void)showInView:(UIView *) view;
- (void) setDatePickerType:(UIDatePickerMode)datePickerType dateFormat:(NSString *)dateFormat;

@end
