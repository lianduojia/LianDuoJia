//
//  PayVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayVC : BaseVC

@property (nonatomic,strong) SOrder *mOrder;
@property (nonatomic,strong) NSString *mTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@property (nonatomic,strong) NSArray *mTempArray;
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
- (IBAction)PayClick:(id)sender;

@end
