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

@interface ReAuntVC ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *_marry;
    
    UIView *bgView;
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    BOOL first = [[defaults objectForKey:@"first"] intValue];
    
    if (!first) {
        [self firstLoad];
        [defaults setObject:@(1) forKey:@"first"];
    }
    
    [defaults synchronize];

}

- (void)firstLoad{

    bgView = [[UIView alloc] initWithFrame:self.view.bounds];
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
    
}

- (void)CloseFirst{
    
    [bgView removeFromSuperview];
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
    NSLog(@"======放弃推荐");
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"放弃推荐";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReAuntDetailVC *ad = [[ReAuntDetailVC alloc] initWithNibName:@"ReAuntDetailVC" bundle:nil];
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

@end
