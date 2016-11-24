//
//  HourView.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/16.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "HourView.h"

@implementation HourView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (HourView *)shareView{
    
    HourView *view = [[[NSBundle mainBundle]loadNibNamed:@"HourView" owner:self options:nil]objectAtIndex:0];
    
    return view;
}

@end
