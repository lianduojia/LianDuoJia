//
//  InformationVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/2.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformationVC : BaseVC
@property (nonatomic,strong) NSString *mType;
@property (weak, nonatomic) IBOutlet UITextField *mName;
@property (weak, nonatomic) IBOutlet UITextField *mPhone;
@property (weak, nonatomic) IBOutlet UITextField *mAddress;
@property (weak, nonatomic) IBOutlet UITextView *mRemark;
@property (weak, nonatomic) IBOutlet UILabel *mHolder;

- (IBAction)mAddressClick:(id)sender;
- (IBAction)mSubmitClick:(id)sender;
@end
