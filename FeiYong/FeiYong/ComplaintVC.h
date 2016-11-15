//
//  ComplaintVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/11.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintVC : BaseVC
@property (nonatomic,strong) SOrderDetail *mOrder;
@property (weak, nonatomic) IBOutlet UITextView *mContent;
@property (weak, nonatomic) IBOutlet UIButton *mButton;

- (IBAction)mCheckClick:(id)sender;
@end
