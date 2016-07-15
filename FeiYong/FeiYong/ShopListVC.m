//
//  ShopListVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/7/14.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ShopListVC.h"
#import "ShopCell.h"
#import <CoreLocation/CoreLocation.h>

@interface ShopListVC ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *_mTempArray;
    
    BOOL _flag;
}

@end

@implementation ShopListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"门店地址";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nogps:) name:@"nogps" object:nil];
    [[SAppInfo shareClient] getLocation];
    
    _mTempArray = [NSMutableArray new];
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nib = [UINib nibWithNibName:@"ShopCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self headerBeganRefresh];
}

- (void)nogps:(id)sender{
    
    _flag = YES;
    
    [_mTableView reloadData];
    
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请开启定位功能" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}

- (void)headerBeganRefresh{
    
    [self showStatu:@"加载中.."];
    
    [_mCity getShopByCity:^(SResBase *retobj, NSArray *arr) {
       
        if (retobj.msuccess) {
            [SVProgressHUD dismiss];
            _mTempArray = (NSMutableArray *)arr;
            [_mTableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
        
        if (arr.count==0) {
            
            [self addEmpty];
        }else{
            [self removeEmpty];
        }
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mTempArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCell* cell = (ShopCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SShop *shop = [_mTempArray objectAtIndex:indexPath.section];

    cell.mName.text = shop.mName;
    cell.mAddress.text = [NSString stringWithFormat:@"%@%@%@",shop.mP_province,shop.mP_city,shop.mP_area];
    
    if (_flag) {
        cell.mDistances.hidden = YES;
        cell.mImg.hidden = YES;
    }
    cell.mDistances.text = shop.mDistance;
    cell.mTelBt.tag = indexPath.row;
    [cell.mTelBt addTarget:self action:@selector(TelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)TelClick:(UIButton *)sender{
    
    int index =(int)sender.tag;
    
    SShop *shop = [_mTempArray objectAtIndex:index];
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",shop.mPhone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
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
