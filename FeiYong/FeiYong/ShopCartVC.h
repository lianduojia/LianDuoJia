//
//  ShopCartVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartVC : BaseVC

@property (nonatomic,strong) NSArray *mGoodsAry;
@property (nonatomic,assign) BOOL mOwn;
@property (nonatomic,strong) void(^itblock)(NSString *content,NSString *ids,NSString *counts,float price);
@property (weak, nonatomic) IBOutlet UILabel *mPrice;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mBottomHeight;
- (IBAction)mGoPayClick:(id)sender;
@end
