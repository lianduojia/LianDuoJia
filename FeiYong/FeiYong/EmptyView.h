//
//  EmptyView.h
//  FeiYong
//
//  Created by 连多家 on 16/6/10.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyView : UIViewController

@property (nonatomic,strong) void(^itblock)(BOOL close);

-(void)showInView:(UIView *)view rect:(CGRect)rect block:(void(^)(BOOL close))block;

-(void)closeView;

- (IBAction)buttonClick:(id)sender;

@end
