//
//  MyInfoVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoVC : BaseVC

@property (weak, nonatomic) IBOutlet UIImageView *mHeadImg;
@property (weak, nonatomic) IBOutlet UITextField *mName;
@property (weak, nonatomic) IBOutlet UITextField *mSex;
- (IBAction)ChoseAgeClick:(id)sender;
- (IBAction)ChosePhotoClick:(id)sender;
@end
