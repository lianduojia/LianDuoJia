//
//  RemarkVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/8/15.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "RemarkVC.h"

@interface RemarkVC ()<UITextViewDelegate>{

    NSMutableArray *_buttonarray;
}

@end

@implementation RemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.""
    
    self.navTitle = @"其它要求";
    
    _mRemark.layer.masksToBounds = YES;
    _mRemark.layer.cornerRadius = 5;
    _mRemark.delegate = self;
    if (_mString.length>0) {
        _mRemark.text = _mString;
        _mploder.text = @"";
    }
    
    
    float xx = 15;
    float yy = 0;
    float height = 0;
    for (int i = 0;i < _mItemsArray.count;i++) {
        
        NSString *str = [_mItemsArray objectAtIndex:i];
        
        
        if (xx+ str.length*15+20 >DEVICE_Width-15) {
            
            xx = 15 ;
            yy +=40;
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(xx, yy, str.length*15+20, 30)];
        button.tag = i;
        [button setTitle:str forState:UIControlStateNormal];
        [button setTitleColor:M_TCO2 forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 4;
        button.layer.borderColor = M_TCO2.CGColor;
        button.layer.borderWidth = 0.5;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        xx += button.frame.size.width+15;
        
        [_mLabelView addSubview:button];
        
    }
    height = yy+30;
    
    _mHeight.constant = height;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _mploder.text = @"您对阿姨的其它要求";
    }else{
        _mploder.text = @"";
    }
}

- (void)itemClick:(UIButton *)sender{
    
    NSString *str = [_mItemsArray objectAtIndex:sender.tag];
    NSMutableString *str2 = [[NSMutableString alloc] initWithString:_mRemark.text];
    
    if (sender.selected) {
        
        sender.layer.borderColor = M_TCO2.CGColor;
        [sender setTitleColor:M_TCO2 forState:UIControlStateNormal];
        NSString *string = [str2 stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@，",str] withString:@""];
        _mRemark.text = string;
    }else{
        sender.layer.borderColor = M_CO.CGColor;
        [sender setTitleColor:M_CO forState:UIControlStateNormal];
        [str2 appendString:[NSString stringWithFormat:@"%@，",str]];
        _mRemark.text = str2;
    }
    if (_mRemark.text.length>0) {
        _mploder.text = @"";
    }else{
        _mploder.text = @"您对阿姨的其它要求";
    }
    
    
    sender.selected = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mSubmitClick:(id)sender {
    
    if (_mRemark.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"要求为空"];
        
        return;
    }
    
    if (_itblock) {
        _itblock(_mRemark.text);
    }
    
    [self popViewController];
}
@end
