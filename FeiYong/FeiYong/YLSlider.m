//
//  YLSlider.m
//  FeiYong
//
//  Created by 周大钦 on 16/8/18.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "YLSlider.h"

@implementation YLSlider


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self setThumbImage:[UIImage imageNamed:@"f_slider_kuai"] forState:UIControlStateHighlighted];
    [self setThumbImage:[UIImage imageNamed:@"f_slider_kuai"] forState:UIControlStateNormal];
}


- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, self.bounds.size.width, 20);
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
{
    rect.origin.x = rect.origin.x - 10 ;
    rect.size.width = rect.size.width +20;
    return CGRectInset ([super thumbRectForBounds:bounds trackRect:rect value:value], 10 , 10);
}


@end
