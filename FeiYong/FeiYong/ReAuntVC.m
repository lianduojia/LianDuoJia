//
//  ReAuntVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ReAuntVC.h"
#import "ReAuntCell.h"
#import "ReAuntDetailVC.h"
#import "PayVC.h"

@interface ReAuntVC ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *_marry;
    
    UIView *bgView;
    
    EmptyView *_emptyview;
}

@end

@implementation ReAuntVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"推荐阿姨";
    _marry = [NSMutableArray new];
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    self.tableView = _mTableView;
    
    UINib *nib = [UINib nibWithNibName:@"ReAuntCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    if (_mTempArray.count == 0) {

        [self addEmpty2:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavBar_Height-150)];
        
        
        
        
    }else{
        
//        [self firstLoad];
        _mTableView.tableFooterView = UIView.new;
    }
    
    if(_mIsHour){
    
        [_mPayBt setTitle:@"支付工时费" forState:UIControlStateNormal];
    }

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 123;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mTempArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 37;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 37)];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DEVICE_Width-10, 37)];
    lab.text = @"请选中您想预约见面的阿姨";
    lab.textColor = M_TCO2;
    lab.font = [UIFont systemFontOfSize:13];
    [view addSubview:lab];
    view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:234/255.0 alpha:1];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReAuntCell* cell = (ReAuntCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SAuntInfo *aunt = [_mTempArray objectAtIndex:indexPath.row];
    cell.mCheckBt.tag = indexPath.row;
    [cell.mCheckBt addTarget:self action:@selector(CheckClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell initCell:aunt];
    
    return cell;
}

-(void)CheckClick:(UIButton *)sender{
    
    SAuntInfo *aunt = [_mTempArray objectAtIndex:sender.tag];
    aunt.mCheck = !aunt.mCheck;
    
    [self.mTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReAuntDetailVC *ad = [[ReAuntDetailVC alloc] initWithNibName:@"ReAuntDetailVC" bundle:nil];
    
    SAuntInfo *aunt = [_mTempArray objectAtIndex:indexPath.row];
    ad.mAuntInfo = aunt;
    [self.navigationController pushViewController:ad animated:YES];
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

- (IBAction)mPayClick:(id)sender {
    
    
    if (_mTempArray.count == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"暂无匹配阿姨,无法支付月薪"];
        return;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    NSString *idstring = @"";
    for (SAuntInfo *aunt in _mTempArray) {
        
        if (aunt.mCheck) {
            idstring = [idstring stringByAppendingString:[NSString stringWithFormat:@"%d,",aunt.mId]];
            [array addObject:aunt];
        }
    }
    if (idstring.length>1) {
        idstring = [idstring substringToIndex:([idstring length]-1)];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请选择您想预约见面的阿姨"];
        return;
    }
    
    
    [self showStatu:@"提交中.."];
    [SAuntInfo submitOrder:idstring work_province:_mProvince work_city:_mCity work_area:_mArea  service_date:_mDate service_address:_mAddress additional:_mRemark service_time:_mServiceTime service_duration:_mServiceDuration work_type:_mType over_night:_mOverNight care_type:_mCareType block:^(SResBase *retobj,SOrder* order) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            PayVC *pay = [[PayVC alloc] initWithNibName:@"PayVC" bundle:nil];
            pay.mTempArray = array;
            pay.mOrder = order;
            pay.mTitle = _mType;
            [self.navigationController pushViewController:pay animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
}
@end
