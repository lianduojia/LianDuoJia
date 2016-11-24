//
//  HourView.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/16.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HourView : UIView

@property (weak, nonatomic) IBOutlet UILabel *mLabel;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

+ (HourView *)shareView;

@end
