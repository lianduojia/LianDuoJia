//
//  OrderDetailVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/10.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailVC : BaseVC

@property (nonatomic,assign) int mBill_id;
@property (nonatomic,strong) SOrder *mOrder;
@property (weak, nonatomic) IBOutlet UILabel *mNo;
@property (weak, nonatomic) IBOutlet UILabel *mTime;
@property (weak, nonatomic) IBOutlet UILabel *mStatu;
@property (weak, nonatomic) IBOutlet UIButton *mButton;
@property (weak, nonatomic) IBOutlet UILabel *mAunt;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UILabel *mPayPrice;
@property (weak, nonatomic) IBOutlet UILabel *mReturnPrice;
@property (weak, nonatomic) IBOutlet UIView *mGoodsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mGoodsViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCjHeight;
- (IBAction)PayClick:(id)sender;

@end
