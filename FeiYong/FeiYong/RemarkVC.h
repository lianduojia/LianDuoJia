//
//  RemarkVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/8/15.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemarkVC : BaseVC

@property (nonatomic,strong) NSString *mString;
@property (nonatomic,strong) void (^itblock)(NSString *remark);
@property (nonatomic,strong) NSArray *mItemsArray;
@property (weak, nonatomic) IBOutlet UITextView *mRemark;
@property (weak, nonatomic) IBOutlet UILabel *mploder;
@property (weak, nonatomic) IBOutlet UIView *mLabelView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mHeight;
- (IBAction)mSubmitClick:(id)sender;
@end
