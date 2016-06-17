//
//  ChoseAddress.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/14.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoseAddress : BaseVC

@property (nonatomic,strong) NSArray *mTempArray;
@property (nonatomic,strong) UIViewController *mVC;
@property (nonatomic,strong) NSString *mProvince;
@property (nonatomic,strong) NSString *mCity;
@property (nonatomic,strong) NSString *mArea;

@property (nonatomic,strong) void (^itblock)(NSString *province,NSString *city,NSString *area);

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
