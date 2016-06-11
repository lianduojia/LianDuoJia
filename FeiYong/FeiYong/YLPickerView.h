//
//  YLPickerView.h
//  FeiYong
//
//  Created by 连多家 on 16/6/11.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface YLPickerView : UIViewController

// 当前标签的名字 ,currentTagName 用于存储正在解析的元素名
@property (strong ,nonatomic) NSString * currentTagName ;

//开始解析
- (void) start ;

@property (weak, nonatomic) IBOutlet UIButton *mCancel;
@property (weak, nonatomic) IBOutlet UIButton *mSubmit;
@property (weak, nonatomic) IBOutlet UIPickerView *mPicker;
@property (nonatomic,strong) void (^itblock)(BOOL flag,NSString *provice,NSString *city,NSString *area);

- (IBAction)mCancelClick:(id)sender;
- (IBAction)mSubmittClick:(id)sender;
- (void)initView:(UIView *)view block:(void(^)(BOOL flag,NSString *provice,NSString *city,NSString *area))block;

@end
