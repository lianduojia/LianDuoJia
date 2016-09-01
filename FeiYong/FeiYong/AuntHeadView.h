//
//  AuntHeadView.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuntHeadView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mHeadImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mAge;
@property (weak, nonatomic) IBOutlet UILabel *mConstellation;
@property (weak, nonatomic) IBOutlet UILabel *mAddress;


+ (AuntHeadView *)shareView;

@end
