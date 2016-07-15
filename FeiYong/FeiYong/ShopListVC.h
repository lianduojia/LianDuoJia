//
//  ShopListVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/7/14.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopListVC : BaseVC
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong) SCity *mCity;

@end
