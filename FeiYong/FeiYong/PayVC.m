//
//  PayVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "PayVC.h"
#import "payCell.h"
#import "AppointmentVC.h"


@interface PayVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{

    float _with;
    float _height;
}

@end

@implementation PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"支付中介费";
    
    _mCollectionView.dataSource = self;
    _mCollectionView.delegate = self;
    
    //初始化cell
    UINib *nib = [UINib nibWithNibName:@"payCell" bundle:nil];
    
    [self.mCollectionView registerNib:nib forCellWithReuseIdentifier:@"pCell"];
    

    _with = (float)(DEVICE_Width-60)/3.0;
    
    _height = _with/102*172;
    
    if (DEVICE_Width == 320) {
        _height = 150;
    }
    
    _mMoney.text = [NSString stringWithFormat:@"¥%d",_mOrder.mAmount];
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
     payCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pCell" forIndexPath:indexPath];
    int index = (int)indexPath.section*3+(int)indexPath.row;
    
    if(index<_mTempArray.count){
        SAuntInfo *aunt = [_mTempArray objectAtIndex:index];
        [cell initCell:aunt];
    }else{
    
        cell.mImg.hidden = YES;
        cell.mMoney.hidden = YES;
        cell.mPayMoney.hidden = YES;
        cell.mName.hidden = YES;
        cell.mLabel.hidden = YES;
        cell.backgroundColor = M_BGCO;
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

- (IBAction)PayClick:(id)sender {

    //支付
    [self showStatu:@"支付中"];
    [_mOrder getOrderNo:^(SResBase *retobj, NSString *orderNo) {
        if (retobj.msuccess) {
            
            _mOrder.mNo = orderNo;
            
            [Order aliPay:_mTitle orderNo:orderNo price:_mOrder.mAmount detail:@"中介费" block:^(SResBase *retobj) {
                if (retobj.msuccess) {
                    
//                    [_mOrder payOK:^(SResBase *retobj) {
                    
                        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                        
                        AppointmentVC *appoint = [[AppointmentVC alloc] initWithNibName:@"AppointmentVC" bundle:nil];
                        appoint.mTempArray = _mTempArray;
                        appoint.mOrder = _mOrder;
                        [self pushViewController:appoint];
//                    }];
                    
                }else{
                    
                    [SVProgressHUD showErrorWithStatus:@"支付失败"];
                    
                }
            }];
        }
    }];
}




@end
