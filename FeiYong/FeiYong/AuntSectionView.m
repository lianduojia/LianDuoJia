//
//  AuntSectionView.m
//  FeiYong
//
//  Created by 周大钦 on 16/8/23.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AuntSectionView.h"

@implementation AuntSectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (AuntSectionView *)shareView{
    
    AuntSectionView *view = [[[NSBundle mainBundle]loadNibNamed:@"AuntSectionView" owner:self options:nil]objectAtIndex:0];
    
    
    return view;
}

@end
