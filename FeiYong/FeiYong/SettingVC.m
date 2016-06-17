//
//  SettingVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "CalculateFileSize.h"
#import "WebVC.h"
#import "APIClient.h"

@interface SettingVC ()<UITableViewDataSource,UITableViewDelegate>{

    NSString *_sizestring;
    
    CalculateFileSize *calculatefileSize;
    
    NSString *documentsDirectory;
}

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navTitle = @"设置";
    
    _sizestring = @"";
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.tableFooterView = UIView.new;
    UINib *nib = [UINib nibWithNibName:@"SettingCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    NSString *path = NSHomeDirectory();//主目录
    NSLog(@"NSHomeDirectory:%@",path);
    NSString *userName = NSUserName();//与上面相同
    NSString *rootPath = NSHomeDirectoryForUser(userName);
    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    documentsDirectory=[paths objectAtIndex:0];//Documents目录
    

    
    [self getHuancun];
    
}

- (void)getHuancun{

    calculatefileSize = [CalculateFileSize defaultCalculateFileSize];
    
    float filSize  =   [calculatefileSize fileSizeAtPath:documentsDirectory];
    _sizestring = [NSString stringWithFormat:@"%.2fk",filSize];
    NSLog(@"文件大小为%fM" ,filSize);
    [_mTableView reloadData];
}

-(void)closeHuancun{
    
    [calculatefileSize clearCache:documentsDirectory];
    
    [self getHuancun];
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
            cell.mDetail.hidden = NO;
            cell.mDetail.text = _sizestring;
            break;
        case 1:
            cell.mName.text = @"关于飞佣";
            
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
            [self closeHuancun];
        }
            break;
        case 1:
        {
            WebVC *web = [[WebVC alloc] init];
            web.mName = @"关于飞佣";
            web.isMode = YES;
            web.mUrl = [NSString stringWithFormat:@"%@introduce.html",[APIClient getDomain]];
            [self presentViewController:web animated:YES completion:nil];
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
