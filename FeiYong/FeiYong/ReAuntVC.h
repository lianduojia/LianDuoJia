//
//  ReAuntVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReAuntVC : BaseVC
@property (nonatomic,strong) NSMutableArray *mTempArray;
@property (nonatomic,strong) NSString *mDate;
@property (nonatomic,strong) NSString *mDetailAddress;
@property (nonatomic,strong) NSString *mRemark;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
- (IBAction)mPayClick:(id)sender;

@end
