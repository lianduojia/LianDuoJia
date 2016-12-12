//
//  AddressCity.m
//  FeiYong
//
//  Created by 周大钦 on 16/9/1.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AddressCity.h"
#import "AddressCitySectionView.h"
#import "AddressCityCell.h"

@interface AddressCity ()<UITableViewDelegate,UITableViewDataSource>{

    AddressCitySectionView *_sectionview;
}

@end

@implementation AddressCity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"选择城市";
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    _mTableView.tableFooterView = UIView.new;
    
    UINib *nib = [UINib nibWithNibName:@"AddressCityCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"AddressCityCellTwo" bundle:nil];
    [_mTableView registerNib:nib2 forCellReuseIdentifier:@"cell2"];
    
    [[SAppInfo shareClient] getLocation];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    _sectionview = [AddressCitySectionView shareView];
    
    if (section == 0) {
        _sectionview.mLabel.text = @"GPS定位城市";
    }
    
    if (section == 1) {
        _sectionview.mLabel.text = @"热门城市";
    }
    
    if (section == 2) {
        _sectionview.mLabel.text = @"城市列表";
    }
    
    return _sectionview;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressCityCell* cell;
    
    if (indexPath.section == 1) {
        cell = (AddressCityCell *)[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        [cell.mJhBt addTarget:self action:@selector(CityClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell = (AddressCityCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.tintColor = M_CO;
        if (indexPath.section == 0) {
            
            if([SAppInfo shareClient].mAddress.length>0){
            
                cell.mLabel.text = [SAppInfo shareClient].mCity;
            }else{
                
                [self performSelector:@selector(reload) withObject:nil afterDelay:2];
            }
        }else{
            
            cell.mLabel.text = @"金华市";
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)reload{
    
    [_mTableView reloadData];
}

- (void)CityClick:(UIButton *)button{

    if (_itblock) {
        _itblock(@"金华市");
    }
    
    [self popViewController];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
    }else{
        
         AddressCityCell *cell = (AddressCityCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (_itblock) {
            _itblock(cell.mLabel.text);
        }
        
        [self popViewController];
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
