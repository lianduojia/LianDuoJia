//
//  OrderSectionView.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSectionView : UIView
@property (weak, nonatomic) IBOutlet UIView *mBg;
@property (weak, nonatomic) IBOutlet UILabel *mLabel;

+ (OrderSectionView *)shareView;

@end
