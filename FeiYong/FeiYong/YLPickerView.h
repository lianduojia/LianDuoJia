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

@property (nonatomic,strong) NSMutableArray *mArray;
@property (nonatomic,strong) void (^itblock)(NSString *sex,int row);
@property (weak, nonatomic) IBOutlet UIButton *mCancel;
@property (weak, nonatomic) IBOutlet UIButton *mSubmit;
@property (weak, nonatomic) IBOutlet UIPickerView *mPicker;
@property (nonatomic,assign) int mSelectRow;

-(void)initView:(UIView *)view block:(void(^)(NSString* sex,int row))block;

- (IBAction)mCancelClick:(id)sender;
- (IBAction)mSubmittClick:(id)sender;


@end
