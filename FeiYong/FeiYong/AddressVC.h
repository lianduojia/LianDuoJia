//
//  AddressVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressVC : BaseVC
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (nonatomic,strong) void(^itblock)(SAddress *address);
- (IBAction)mAddAddressClick:(id)sender;

@end
