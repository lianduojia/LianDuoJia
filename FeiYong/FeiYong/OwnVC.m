//
//  OwnVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "OwnVC.h"
#import "ParentalCell.h"
#import "AddressVC.h"
#import "MyInfoVC.h"
#import "BalanceVC.h"
#import "OpinionVC.h"
#import "SettingVC.h"
#define Height 248

@interface OwnVC ()<UITableViewDataSource,UITableViewDelegate>{

    float _balance;
}

@end

@implementation OwnVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.hiddenTabBar = NO;
    
    if (![SUser isNeedLogin]){
        [self getbalance];
    }
    
    [self loadMyinfo];
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.hiddenNavBar = YES;
    
    _balance = 0;
    
    UINib *nib = [UINib nibWithNibName:@"ParentalCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _mTableView.contentInset = UIEdgeInsetsMake(Height, 0, 0, 0);
    _mTableView.userInteractionEnabled = YES;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    _mHeadImg.layer.masksToBounds = YES;
    _mHeadImg.layer.cornerRadius = 36;
    _mHeadImg.layer.borderColor = [UIColor whiteColor].CGColor;
    _mHeadImg.layer.borderWidth = 2;
    [_mTableView setTableFooterView:UIView.new];
    
    CGRect rect = _mHeadView.frame;
    rect.origin.y = -Height;
    rect.size.width = DEVICE_Width;
    _mHeadView.frame = rect;
    [_mTableView addSubview:_mHeadView];
    
    [_mHeadClick addTarget:self action:@selector(GoLogin) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)getbalance{

    [SUser getBalance:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
           
            _balance = [[retobj.mdata objectForKey:@"balance"] floatValue];
            [SVProgressHUD dismiss];
            
            [_mTableView reloadData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
        
    }];

}

- (void)loadMyinfo{

    SUser *user = [SUser currentUser];
    
    if (user) {
        _mName.text = user.mName;
    }
    else{
        _mName.text = @"请登陆";
    }
    
}

- (void)GoLogin{

    if ([SUser isNeedLogin]) {
        [self gotoLogin];
        
        return;
    }
    
    
    MyInfoVC *info = [[MyInfoVC alloc] initWithNibName:@"MyInfoVC" bundle:nil];
    [self.navigationController pushViewController:info animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    if (y<=-Height) {
        
        CGRect rect = _mHeadView.frame;
        rect.origin.y = y;
        rect.size.height = -y;
        _mHeadView.frame = rect;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 8)];
//    view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:234/255.0 alpha:1];
//    return view;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ParentalCell* cell = (ParentalCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0:
            cell.mName.textColor = M_TCO;
            switch (indexPath.row) {
                case 0:
                    
                    cell.mImg.image = [UIImage imageNamed:@"own_dzgl"];
                    cell.mName.text = @"地址管理";
                    
                    break;
                case 1:
                    
                    cell.mImg.image = [UIImage imageNamed:@"own_wdqb"];
                    cell.mName.text = @"我的钱包";
                    cell.mDetail.hidden = NO;
                    cell.mDetail.text = [NSString stringWithFormat:@"余额：%g",_balance];
                    break;
                default:
                    break;
            }
            
            break;
        case 1:
            cell.mName.textColor = M_TCO2;
            switch (indexPath.row) {
                case 0:
                    
                    cell.mImg.image = [UIImage imageNamed:@"own_yjfk"];
                    cell.mName.text = @"意见反馈";
                    
                    break;
                case 1:
                    
                    cell.mImg.image = [UIImage imageNamed:@"own_xtsz"];
                    cell.mName.text = @"系统设置";
                    
                    break;
                default:
                    break;
            }
            
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            
        case 0:
            
            if ([SUser isNeedLogin]) {
                [self gotoLogin];
                return;
            }
            
            switch (indexPath.row) {
                case 0:
                {
                    AddressVC *address = [[AddressVC alloc] init];
                    
                    [self.navigationController pushViewController:address animated:YES];
                }
                    break;
                case 1:
                {
                    BalanceVC *balance = [[BalanceVC alloc] initWithNibName:@"BalanceVC" bundle:nil];
                    balance.mBalance = _balance;
                    [self.navigationController pushViewController:balance animated:YES];
                }
                   
                    break;
                default:
                    break;
            }
            
            break;
        case 1:
            
            switch (indexPath.row) {
                case 0:
                {
                    OpinionVC *opin = [[OpinionVC alloc] initWithNibName:@"OpinionVC" bundle:nil];
                    
                    [self.navigationController pushViewController:opin animated:YES];
                }
                    
                    break;
                case 1:
                {
                    SettingVC *setting = [[SettingVC alloc] initWithNibName:@"SettingVC" bundle:nil];
                    
                    [self.navigationController pushViewController:setting animated:YES];
                }
                    break;
                default:
                    break;
            }
            
            break;
            
        default:
            break;
    }

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

@end
