//
//  PingJiaSectionView.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "PingJiaSectionView.h"

@implementation PingJiaSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (PingJiaSectionView *)shareView{
    
    PingJiaSectionView *view = [[[NSBundle mainBundle]loadNibNamed:@"PingJiaSectionView" owner:self options:nil]objectAtIndex:0];
    
    
    CGRect rect = view.frame;
    rect.size.width = DEVICE_Width;
    
    return view;
}

@end
