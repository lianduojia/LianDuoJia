//
//  EditAddressVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddressVC : BaseVC

@property(nonatomic,strong) void (^itblcok)(BOOL flag);
@property (nonatomic,strong) SAddress *mTempAddress;
@property (weak, nonatomic) IBOutlet UITextField *mName;
@property (weak, nonatomic) IBOutlet UITextField *mPhone;
@property (weak, nonatomic) IBOutlet UITextField *mAddress;
@property (weak, nonatomic) IBOutlet UITextField *mAddressDetail;
- (IBAction)mChoseAddress:(id)sender;
@end
