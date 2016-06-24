//
//  AboutUsVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/23.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AboutUsVC.h"
#import "SettingCell.h"

@interface AboutUsVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"关于我们";
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.tableFooterView = UIView.new;
    UINib *nib = [UINib nibWithNibName:@"SettingCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _mImg.layer.masksToBounds = YES;
    _mImg.layer.cornerRadius = 15;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    _mName.text = app_Name;
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _mVersion.text = [NSString stringWithFormat:@"V%@",app_Version];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SettingCell* cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            cell.mName.text = @"微信公众号";
            cell.mDetail.hidden = NO;
            cell.mArrow.hidden = YES;
            cell.mDetail.text = @"@飞佣家庭管家";
            break;
        default:
            break;
    }
    
    return cell;
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
