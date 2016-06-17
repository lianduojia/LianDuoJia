//
//  OrderCell.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mHeadImg;

@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UILabel *mDetail;
@property (weak, nonatomic) IBOutlet UILabel *mOrderNo;
@property (weak, nonatomic) IBOutlet UIButton *mButton;
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
@property (weak, nonatomic) IBOutlet UILabel *mMoneylabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *mButtonTwo;

-(void)initCell:(SOrder *)order index:(int)index;
-(void)initPjCell:(SOrder *)order;

@end
