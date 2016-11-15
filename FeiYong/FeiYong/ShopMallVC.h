//
//  ShopMallVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/9/1.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopMallVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *mBannerView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIView *mHeadView;
@property (weak, nonatomic) IBOutlet UISearchBar *mSearchBar;

- (IBAction)mMenuClick:(id)sender;
@end
