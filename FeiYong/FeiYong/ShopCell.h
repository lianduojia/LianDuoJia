//
//  ShopCell.h
//  FeiYong
//
//  Created by 周大钦 on 16/7/14.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mAddress;
@property (weak, nonatomic) IBOutlet UIButton *mTelBt;
@property (weak, nonatomic) IBOutlet UILabel *mDistances;
@property (weak, nonatomic) IBOutlet UIView *mBgView;
@property (weak, nonatomic) IBOutlet UIImageView *mImg;


@end
