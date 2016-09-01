//
//  AddressCitySectionView.m
//  FeiYong
//
//  Created by 周大钦 on 16/9/1.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AddressCitySectionView.h"

@implementation AddressCitySectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (AddressCitySectionView *)shareView{
    
    AddressCitySectionView *view = [[[NSBundle mainBundle]loadNibNamed:@"AddressCitySectionView" owner:self options:nil]objectAtIndex:0];
    
    
    return view;
}

@end
