//
//  GoodsListVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/4.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListVC : BaseVC

@property (nonatomic,strong) NSString *mType;
@property (nonatomic,strong) NSString *mKey;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
