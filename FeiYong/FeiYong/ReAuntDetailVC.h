//
//  ReAuntDetailVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReAuntDetailVC : BaseVC
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mButtonHeight;

@property (weak, nonatomic) IBOutlet UIView *mLine;
- (IBAction)mbackClick:(id)sender;
- (IBAction)GoPingjiaClick:(id)sender;

@end
