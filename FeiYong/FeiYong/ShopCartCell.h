//
//  ShopCartCell.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mCheckBt;
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UILabel *mNum;
@property (weak, nonatomic) IBOutlet UIButton *mNumBt;
@property (weak, nonatomic) IBOutlet UIButton *mDelBt;
@property (weak, nonatomic) IBOutlet UIButton *mAddBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mCheckWidth;

@end
