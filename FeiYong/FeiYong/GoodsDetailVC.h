//
//  GoodsDetailVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/4.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailVC : BaseVC

@property (nonatomic,strong) SGoods *mGoods;
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;

@property (weak, nonatomic) IBOutlet UIView *mBannerView;
@property (weak, nonatomic) IBOutlet UILabel *mGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UIButton *mDel;
@property (weak, nonatomic) IBOutlet UIButton *mNum;
@property (weak, nonatomic) IBOutlet UIButton *mAdd;
@property (weak, nonatomic) IBOutlet UIView *mRemarkView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mRemarkHeight;
@property (weak, nonatomic) IBOutlet UIView *mNavView;
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
- (IBAction)mBackClick:(id)sender;
- (IBAction)mKefuClick:(id)sender;

- (IBAction)mChangeNumClick:(id)sender;
- (IBAction)mAddShopCarClick:(id)sender;
- (IBAction)mGuizeClick:(id)sender;
@end
