//
//  GoodsView.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/10.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "GoodsView.h"

@implementation GoodsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (GoodsView *)shareView{
    
    GoodsView *view = [[[NSBundle mainBundle]loadNibNamed:@"GoodsView" owner:self options:nil]objectAtIndex:0];
    
    
    return view;
}

@end
