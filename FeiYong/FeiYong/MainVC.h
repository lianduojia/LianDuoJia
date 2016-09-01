//
//  MainVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVC : BaseVC

@property (weak, nonatomic) IBOutlet UIButton *mCityBt;
@property (weak, nonatomic) IBOutlet UIView *mHeadView;

@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (weak, nonatomic) IBOutlet UIView *mBannerView;
@property (weak, nonatomic) IBOutlet UIView *mMenuView;
@property (weak, nonatomic) IBOutlet UIView *mAdvView;
@property (weak, nonatomic) IBOutlet UIImageView *mBannerImg;
- (IBAction)extendClick:(id)sender;

- (IBAction)menuClick:(id)sender;
- (IBAction)explainClick:(id)sender;
- (IBAction)ChoseCityClick:(id)sender;
@end
