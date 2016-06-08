//
//  SettingVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"

@interface SettingVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"设置";
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.tableFooterView = UIView.new;
    UINib *nib = [UINib nibWithNibName:@"SettingCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingCell* cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.mName.text = @"清空缓存";
            break;
        case 1:
            cell.mName.text = @"关于飞佣";
            cell.mDetail.hidden = NO;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
        }
            break;
        case 1:
        {
        
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
