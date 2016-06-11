//
//  PingJiaCell.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "PingJiaCell.h"
#import "Util.h"

@implementation PingJiaCell

- (void)awakeFromNib {
    // Initialization code
    _mHeadImg.layer.masksToBounds = YES;
    _mHeadImg.layer.cornerRadius = 15;
}

-(void)initCell:(SComment *)comment{

    [_mHeadImg sd_setImageWithURL:[NSURL URLWithString:comment.mEmployer_photo_url] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    _mName.text = comment.mEmployer_name;
    [_mWork setTitle:comment.mComment_type forState:UIControlStateNormal];
    _mContent.text = comment.mComment;
    _mTime.text = [Util getTimeString:[Util getDataString:comment.mDate bfull:NO] bfull:NO];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
