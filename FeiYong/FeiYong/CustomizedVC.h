//
//  CustomizedVC.h
//  FeiYong
//
//  Created by 周大钦 on 2016/12/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomizedVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *mView;

- (IBAction)mItemClick:(id)sender;
@end
