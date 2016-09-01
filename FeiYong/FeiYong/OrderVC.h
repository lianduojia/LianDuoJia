//
//  OrderVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *mHeadView;

@property (weak, nonatomic) IBOutlet UIButton *mItem1;
@property (weak, nonatomic) IBOutlet UIButton *mItem2;
@property (weak, nonatomic) IBOutlet UIButton *mItem3;
@property (weak, nonatomic) IBOutlet UIButton *mItem4;
@property (weak, nonatomic) IBOutlet UIButton *mItem5;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (weak, nonatomic) IBOutlet UIView *mLine;

- (IBAction)mChoseClick:(id)sender;


@end
