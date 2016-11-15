//
//  GoodsCell.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/3.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UILabel *mIntroduction;
@property (weak, nonatomic) IBOutlet UILabel *mRemark;
@property (weak, nonatomic) IBOutlet UIButton *mButton;

@end
