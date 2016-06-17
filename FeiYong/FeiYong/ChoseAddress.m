//
//  ChoseAddress.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/14.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ChoseAddress.h"

@interface ChoseAddress ()<UITableViewDataSource,UITableViewDelegate>{

    NSArray *_province;
}

@end

@implementation ChoseAddress

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"选择地区";
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    _province = [def objectForKey:@"Province"];
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    _mTableView.tableFooterView = [UIView new];
    
    if (_mTempArray.count == 0) {
        _mTempArray = _province;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mTempArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSDictionary *dic = [_mTempArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [_mTempArray objectAtIndex:indexPath.row];
    
    NSArray *array = [dic objectForKey:@"child"];
    if(array.count > 0){
    
        ChoseAddress *ca = [[ChoseAddress alloc] initWithNibName:@"ChoseAddress" bundle:nil];
        ca.mTempArray = array;
        
        if (_mProvince.length == 0) {
            ca.mProvince = [dic objectForKey:@"name"];
        }else if(_mCity.length == 0){
            ca.mCity = [dic objectForKey:@"name"];
            ca.mProvince = _mProvince;
        }
        
        ca.itblock = _itblock;
           
        [self pushViewController:ca];
        
    }else{
    
        _mArea = [dic objectForKey:@"name"];
        
        if (_itblock) {
            _itblock(_mProvince,_mCity,_mArea);
        }
        [self popViewController_3];
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
