//
//  GoodsView.h
//  FeiYong
//
//  Created by 周大钦 on 2016/11/10.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mNum;
@property (weak, nonatomic) IBOutlet UILabel *mPrice;

+ (GoodsView *)shareView;

@end
