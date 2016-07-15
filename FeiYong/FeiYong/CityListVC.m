//
//  CityListVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/7/12.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "CityListVC.h"
#import "CityCell.h"
#import "ShopListVC.h"

@interface CityListVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{

    NSMutableArray *_mTempArray;
    
    float _with;
    float _height;
}

@end

@implementation CityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"选择城市";
    
    _mTempArray = [NSMutableArray new];
    
    
    _mCollectionView.dataSource = self;
    _mCollectionView.delegate = self;
    
    
    _with = (float)(DEVICE_Width-60)/3.0;
    
    _height = _with/103*122;

    
    //初始化cell
    UINib *nib = [UINib nibWithNibName:@"CityCell" bundle:nil];
    
    [self.mCollectionView registerNib:nib forCellWithReuseIdentifier:@"cCell"];
    
    [self showStatu:@"加载中.."];
    [SUser getShopCity:^(SResBase *retobj, NSArray *arr) {
       
        if (retobj.msuccess) {
            
            [SVProgressHUD dismiss];
            _mTempArray = (NSMutableArray *)arr;
            
            [_mCollectionView reloadData];
            
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
        
    }];
}

-(void)leftBtnTouched:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _mTempArray.count%3==0?_mTempArray.count/3:_mTempArray.count/3+1;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cCell" forIndexPath:indexPath];
    cell.mImg.layer.masksToBounds = YES;
    cell.mImg.layer.cornerRadius = 10;
    int index = (int)indexPath.section*3+(int)indexPath.row;
    
    if(index<_mTempArray.count){
        SCity *city = [_mTempArray objectAtIndex:index];
        
        cell.mCity.text = city.mCity;
        [cell.mImg sd_setImageWithURL:[NSURL URLWithString:city.mIcon] placeholderImage:[UIImage imageNamed:@"s_default"]];
        
    }else{
        
        cell.mImg.hidden = YES;
        cell.mCity.hidden = YES;
    }
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_with, _height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 15, 8, 15);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int index = (int)indexPath.section*3+(int)indexPath.row;
    
    if(index<_mTempArray.count){
        SCity *city = [_mTempArray objectAtIndex:index];
    
        ShopListVC *shopVC = [[ShopListVC alloc] initWithNibName:@"ShopListVC" bundle:nil];
        shopVC.mCity = city;
        [self pushViewController:shopVC];
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
