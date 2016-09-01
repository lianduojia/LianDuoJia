//
//  AddressCity.h
//  FeiYong
//
//  Created by 周大钦 on 16/9/1.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCity : BaseVC
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (nonatomic,strong) void (^itblock)(NSString *city);

@end
