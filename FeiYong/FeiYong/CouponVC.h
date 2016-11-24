//
//  CouponVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/18.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponVC : BaseVC
@property (nonatomic,assign)  int type;
@property (weak, nonatomic) IBOutlet UIImageView *mBanner;
@property (weak, nonatomic) IBOutlet UITextField *mCode;
@property (weak, nonatomic) IBOutlet UIButton *mBt;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)btnClick:(id)sender;
- (IBAction)guoqiClick:(id)sender;

@end
