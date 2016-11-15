//
//  PayVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayVC : BaseVC

@property (weak, nonatomic) IBOutlet UIView *mContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCollectionHeight;
@property (nonatomic,strong) SOrder *mOrder;
@property (nonatomic,strong) NSString *mTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *mGoodsDetail;
@property (weak, nonatomic) IBOutlet UIButton *mCheck;
@property (nonatomic,strong) NSArray *mTempArray;
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
- (IBAction)PayClick:(id)sender;
- (IBAction)CheckClick:(id)sender;

- (IBAction)GoShopCarClick:(id)sender;
@end
