//
//  OrderSectionView.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "OrderSectionView.h"

@implementation OrderSectionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _mBg.layer.masksToBounds = YES;
    _mBg.layer.cornerRadius = 3;
}
+ (OrderSectionView *)shareView{
    
    OrderSectionView *view = [[[NSBundle mainBundle]loadNibNamed:@"OrderSectionView" owner:self options:nil]objectAtIndex:0];
    
    
    return view;
}

@end
