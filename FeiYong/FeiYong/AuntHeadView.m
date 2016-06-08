//
//  AuntHeadView.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AuntHeadView.h"

@implementation AuntHeadView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.mHeadImg.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.mHeadImg.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.mHeadImg.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.mHeadImg.layer.shadowRadius = 10;//阴影半径，默认3
}


+ (AuntHeadView *)shareView{

    AuntHeadView *view = [[[NSBundle mainBundle]loadNibNamed:@"AuntHeadView" owner:self options:nil]objectAtIndex:0];
    
    
    return view;
}

@end
