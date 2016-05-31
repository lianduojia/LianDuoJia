//
//  NavBar.m
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "NavBar.h"

@implementation NavBar

+ (NavBar *)shareView{
    
    NavBar *view = [[[NSBundle mainBundle]loadNibNamed:@"NavBar" owner:self options:nil]objectAtIndex:0];
    
    return view;
}

@end
