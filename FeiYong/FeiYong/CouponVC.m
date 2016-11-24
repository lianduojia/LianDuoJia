//
//  CouponVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/18.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "CouponVC.h"
#import "CouponCell.h"

@interface CouponVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"优惠券";
    
    _mBt.layer.masksToBounds = YES;
    _mBt.layer.cornerRadius = 5;
    [self setTextFieldLeftPadding:_mCode forWidth:8];
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    self.tableView = _mTableView;
    self.haveHeader = YES;

    UINib *nib = [UINib nibWithNibName:@"CouponCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self headerBeganRefresh];

}

-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

- (void)headerBeganRefresh{

    [self showStatu:@"加载中.."];
    NSString *status = @"已生效";
    if (_type) {
        status = @"已过期";
    }
    [SCoupon getCoupon:nil status:status block:^(SResBase *retobj, NSArray *arr) {
        
        if (retobj.msuccess) {
            
            [SVProgressHUD dismiss];
            
            self.tempArray = (NSMutableArray *)arr;
            [self headerEndRefresh];
            
            [self.tableView reloadData];
            
            if (arr.count==0) {
                
                [self addEmpty:CGRectMake(0, 0, DEVICE_Width, _mTableView.frame.size.height) image:nil];
            }else{
                [self removeEmpty];
            }
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
            [self headerEndRefresh];
        }
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    SCoupon *coupon = [self.tempArray objectAtIndex:indexPath.row];
    
    cell.mName.text = coupon.mUse_bill_type;
    cell.mDate.text = [NSString stringWithFormat:@"仅限%@至%@使用",coupon.mBegin_time,coupon.mEnd_time];
    cell.mPrice.text = [NSString stringWithFormat:@"¥%g",coupon.mFace_value];
    if (coupon.mEnough_money>0) {
        cell.mRemark.hidden = NO;
        cell.mRemark.text = [NSString stringWithFormat:@"(满%g元可用)",coupon.mEnough_money];
    }else{
        cell.mRemark.hidden = YES;
    }
    
    if (_type) {
        cell.mName.textColor = [UIColor colorWithRed:148/255.f green:148/255.f blue:148/255.f alpha:1];
        cell.mPrice.textColor = [UIColor colorWithRed:148/255.f green:148/255.f blue:148/255.f alpha:1];
        cell.mRemark.textColor = [UIColor colorWithRed:148/255.f green:148/255.f blue:148/255.f alpha:1];
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

- (IBAction)btnClick:(id)sender {
    if (_mCode.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入兑换码"];
        return;
    }
    
    [SCoupon exangeCode:_mCode.text block:^(SResBase *retobj) {
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            [self headerBeganRefresh];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (IBAction)guoqiClick:(id)sender {
    
    if (_type) {
        [self popViewController];
        
        return;
    }
    CouponVC *cp = [[CouponVC alloc] initWithNibName:@"CouponOverVC" bundle:nil];
    cp.type = 1;
    [self pushViewController:cp];
    
    
}
@end
