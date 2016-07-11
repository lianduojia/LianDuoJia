//
//  ChosePlaceVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/23.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChosePlaceVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *mContentView;
@property (weak, nonatomic) IBOutlet UIButton *mOther;
@property (nonatomic,strong) void (^itblock)(NSString *place);
@property (weak, nonatomic) IBOutlet UIButton *mButton;
- (IBAction)mClick:(id)sender;
- (IBAction)mSubmitClick:(id)sender;

@end
