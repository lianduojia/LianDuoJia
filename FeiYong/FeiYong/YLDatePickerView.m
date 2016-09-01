//
//  YLDatePickerView.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/13.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "YLDatePickerView.h"
#import "Util.h"

@implementation YLDatePickerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //        中文显示
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CH"];
    _mPicker.locale = locale;
    
    //最小时间延后15分钟
    NSDate *date = [NSDate date];
    
    int time = [date timeIntervalSince1970];
    time = time-3600*8+3600;
//    time = time-3600*8;
    
    NSDate *miniDate = [Util dateWithInt:time];
    _mPicker.minimumDate = miniDate;
    
    [self.mSubmit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.mCancel addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}
-(void)SetLabelDate:(UILabel *)textLabel{
    self.m_pTextDate = textLabel;
}

-(void)SetTextFieldDate:(UITextField *)textLabel
{
    self.m_pTextDate = textLabel;
}

- (void)showInView:(UIView *) view
{
    self.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, 266);
    
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
       
        self.frame = CGRectMake(0, DEVICE_Height-266, DEVICE_Width, 266);
        
    }];
    
    
    
}

//设置显示类型和时间格式
- (void) setDatePickerType:(UIDatePickerMode)datePickerType dateFormat:(NSString *)dateFormat
{
    _mPicker.datePickerMode = datePickerType;
    //    显示格式
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:dateFormat];
    
}

-(void)submit
{
    NSDate *selectTime = [_mPicker date];
    
    NSString *date = [_dateFormatter stringFromDate:selectTime];
    NSArray *array = [date componentsSeparatedByString:@":"];
    
    if (_mPicker.datePickerMode == UIDatePickerModeTime) {
        int h = [[array objectAtIndex:0] intValue];
        int m = [[array objectAtIndex:1] intValue];
        
        if (m <= 15) {
            m = 0;
        }else if(m>15 && m<45){
            m = 30;
        }else{
            m = 0;
            if (h<24) {
                h++;
            }
        }
        
        if ([self.m_pTextDate isKindOfClass:[UILabel class]]) {
            ((UILabel *)self.m_pTextDate).text = [NSString stringWithFormat:@"%.2d:%.2d",h,m];
        }
        
        if ([self.m_pTextDate isKindOfClass:[UITextField class]]) {
            ((UITextField *)self.m_pTextDate).text = [NSString stringWithFormat:@"%.2d:%.2d",h,m];
        }
        
    }else{
        
        NSString *one = [array objectAtIndex:0];
        NSArray *array2 = [one componentsSeparatedByString:@" "];
        
        NSString *day = [array2 objectAtIndex:0];
        int h = [[array2 objectAtIndex:1] intValue];
        int m = [[array objectAtIndex:1] intValue];
        
        if (m <= 15) {
            m = 0;
        }else if(m>15 && m<45){
            m = 30;
        }else{
            m = 0;
            if (h<24) {
                h++;
            }
        }
        
        if ([self.m_pTextDate isKindOfClass:[UILabel class]]) {
            ((UILabel *)self.m_pTextDate).text = [NSString stringWithFormat:@"%@ %.2d:%.2d",day,h,m];
        }
        if ([self.m_pTextDate isKindOfClass:[UITextField class]]) {
             ((UITextField *)self.m_pTextDate).text = [NSString stringWithFormat:@"%@ %.2d:%.2d",day,h,m];
        }
    }
    
    
    
    [self close];
    
}

-(void)close{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, 266);
        
    }];
    
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.3];

}

-(void)remove{

    [self removeFromSuperview];
}


@end
