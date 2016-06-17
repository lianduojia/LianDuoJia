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
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"ReAuntCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    if (_mTempArray.count == 0) {
        _emptyview = [[EmptyView alloc] initWithNibName:@"EmptyView" bundle:nil];
        
        [_emptyview showInView:self.view rect:CGRectMake(0, DEVICE_NavBar_Height, DEVICE_Width, DEVICE_InNavBar_Height) block:^(BOOL close) {
            
        }];
        
        
        
    }else{
        
        [self firstLoad];
    }
    
   

}


- (void)firstLoad{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    BOOL first = [[defaults objectForKey:@"first"] intValue];
    
    if (!first) {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.6;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, 269, 90)];
        imgV.image = [UIImage imageNamed:@"a_first"];
        imgV.center = bgView.center;
        imgV.frame = CGRectMake(imgV.frame.origin.x, 120, 269, 90);
        [bgView addSubview:imgV];
        
        [self.view addSubview:bgView];
        
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseFirst)];
        [bgView addGestureRecognizer:tap];
        [defaults setObject:@(1) forKey:@"first"];
    }
    
    [defaults synchronize];
    
}

- (void)CloseFirst{
    
    [bgView removeFromSuperview];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 8;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
    
    SAuntInfo *aunt = [_mTempArray objectAtIndex:indexPath.row];
    
    [self showStatu:@"操作中.."];
    [aunt deleteThis:^(SResBase *retobj) {
        if (retobj.mmsg) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            [_mTempArray removeObjectAtIndex:indexPath.section];
            
            [_mTableView beginUpdates];
            [_mTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [_mTableView endUpdates];
            
            [_mTableView reloadData];
            
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
        
    }];
    NSLog(@"======放弃推荐");
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"放弃推荐";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _mTempArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 8)];
    view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:234/255.0 alpha:1];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReAuntCell* cell = (ReAuntCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SAuntInfo *aunt = [_mTempArray objectAtIndex:indexPath.section];
    
    [cell initCell:aunt];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReAuntDetailVC *ad = [[ReAuntDetailVC alloc] initWithNibName:@"ReAuntDetailVC" bundle:nil];
    
    SAuntInfo *aunt = [_mTempArray objectAtIndex:indexPath.section];
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
    
    [self showStatu:@"提交中.."];
    [SAuntInfo submitOrder:_mTempArray service_date:_mDate service_address:_mDetailAddress additional:_mRemark service_time:_mServiceTime service_duration:_mServiceDuration block:^(SResBase *retobj,SOrder* order) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            PayVC *pay = [[PayVC alloc] initWithNibName:@"PayVC" bundle:nil];
            pay.mTempArray = _mTempArray;
            pay.mOrder = order;
            pay.mTitle = _mType;
            [self.navigationController pushViewController:pay animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
}
@end
