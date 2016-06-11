//
//  ChoseAddressVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h> 

@interface ChoseAddressVC : BaseVC

@property (nonatomic,strong) void (^itblock)(NSString *address,NSString *provice,NSString *city,NSString *area);
@property (weak, nonatomic) IBOutlet UITextField *mDetailAdd;
@property (weak, nonatomic) IBOutlet UILabel *mAdd;
- (IBAction)mSubmitClick:(id)sender;
- (IBAction)mChoseClick:(id)sender;

@end
