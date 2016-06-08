
//
//  AddressVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AddressVC.h"
#import "AddressCell.h"
#import "EditAddressVC.h"

@interface AddressVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AddressVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navTitle = @"地址管理";
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"AddressCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
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
    NSLog(@"======删除");
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 8)];
    view.backgroundColor = M_BGCO;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressCell* cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditAddressVC *edit = [[EditAddressVC alloc] initWithNibName:@"EditAddressVC" bundle:nil];
    
    [self.navigationController pushViewController:edit animated:YES];
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

- (IBAction)mAddAddressClick:(id)sender {
    
    EditAddressVC *edit = [[EditAddressVC alloc] initWithNibName:@"EditAddressVC" bundle:nil];
    
    [self.navigationController pushViewController:edit animated:YES];
}
@end