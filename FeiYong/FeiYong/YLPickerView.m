//
//  YLPickerView.m
//  FeiYong
//
//  Created by 连多家 on 16/6/11.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "YLPickerView.h"

@interface YLPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    NSArray *_array;
    
    NSString *_sex;
}

@end

@implementation YLPickerView


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _array = [[NSArray alloc] initWithObjects:@"男",@"女", nil];
 
    _mPicker.delegate = self;
    
    _sex = @"男";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}
#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_array objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _sex = [_array objectAtIndex:row];
}


- (IBAction)mCancelClick:(id)sender {
    
    [self closeView];
    
}

- (IBAction)mSubmittClick:(id)sender {
    
    if (_itblock) {
        _itblock(_sex);
    }
    
    [self closeView];
    
}

-(void)initView:(UIView *)view block:(void(^)(NSString* sex))block{

    CGRect rect = self.view.frame;
    rect.origin.y = DEVICE_Height;
    rect.size.width = DEVICE_Width;
    self.view.frame = rect;
    
    [view addSubview:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect2 = self.view.frame;
        rect2.origin.y = DEVICE_Height-266;
        self.view.frame = rect2;
    }];
    
    self.itblock = ^(NSString *sex){
    
        block(sex);
    };
}


-(void)closeView{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect2 = self.view.frame;
        rect2.origin.y = DEVICE_Height;
        self.view.frame = rect2;
    }];
    
    [self performSelector:@selector(Remove) withObject:nil afterDelay:0.2f];
}

-(void)Remove{
    [self.view removeFromSuperview];
}



@end
