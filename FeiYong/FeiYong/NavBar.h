//
//  NavBar.h
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavBar : UIView
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UIButton *mLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *mRightButton;
@property (weak, nonatomic) IBOutlet UIButton *mRightButton2;

+ (NavBar *)shareView;

@end
