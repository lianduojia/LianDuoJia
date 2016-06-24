//
//  AboutUsVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/23.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsVC : BaseVC
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UILabel *mVersion;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end
