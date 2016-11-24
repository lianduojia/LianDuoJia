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
#import "ShopCartVC.h"
#import "OrderDetailVC.h"


@interface PayVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>{

    float _with;
    float _height;
    
    BOOL _isgoods;
    
    float _goodsprice;
    NSArray *_goodsarray;
    NSString *_ids;
    NSString *_counts;
    
    BOOL _back;
}

@end

@implementation PayVC

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
    if (!_back) {
        [self showStatu:@"加载中.."];
        [SGoods getCartData:^(SResBase *retobj, NSArray *arr) {
            
            if (retobj.msuccess) {
                
                [SVProgressHUD dismiss];
                
                _goodsarray = arr;
                int count = 0;
                _ids = @"";
                _counts = @"";
                _goodsprice = 0;
                for (SGoods *g in arr) {
                    
                    g.mCheck = YES;
                    
                    _goodsprice += g.mPrice*g.mCount;
                    count+= g.mCount;
                    
                    _ids = [_ids stringByAppendingString:[NSString stringWithFormat:@"%d,",g.mGoods_id]];
                    _counts = [_counts stringByAppendingString:[NSString stringWithFormat:@"%d,",g.mCount]];
                }
                
                if (_ids.length>1) {
                    _ids = [_ids substringWithRange:NSMakeRange(0, [_ids length] - 1)];
                    _counts = [_counts substringWithRange:NSMakeRange(0, [_counts length] - 1)];
                }
                _mGoodsDetail.text = [NSString stringWithFormat:@"共%d件 ¥%g",count,_goodsprice];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:retobj.mmsg];
            }
        }];

    }
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"支付月薪";
    _isgoods = NO;
    
    _ids = @"";
    _counts = @"";
    
    _mCollectionView.dataSource = self;
    _mCollectionView.delegate = self;
    
    //初始化cell
    UINib *nib = [UINib nibWithNibName:@"payCell" bundle:nil];
    
    [self.mCollectionView registerNib:nib forCellWithReuseIdentifier:@"pCell"];
    

    _with = (float)(DEVICE_Width-60)/3.0;
    
    _height = _with/102*164;
    
    if (DEVICE_Width == 320) {
        _height = 150;
    }
    
    if (_mTempArray.count/3<=1) {
        _mCollectionHeight.constant = DEVICE_Width/2;
    }else{
        _mCollectionHeight.constant = DEVICE_Width;
    }
    _mMoney.text = [NSString stringWithFormat:@"¥%d",_mOrder.mAmount];
    
}


-(void)leftBtnTouched:(id)sender{
    [self popViewController_2];
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


    if (_isgoods && _goodsprice>0) {
        
        float price = _mOrder.mAmount+_goodsprice;
        
        [self showStatu:@"操作中.."];
        [_mOrder recalculateAmount:_ids goods_count:_counts app_trancation_amount:price block:^(SResBase *retobj, float trancation_amount) {
            if (retobj.msuccess) {
                
                [SVProgressHUD dismiss];
                [self goPay:trancation_amount];
                
            }else{
                [SVProgressHUD showErrorWithStatus:retobj.mmsg];
            }
        }];
        
    }else{
    
        [self goPay:_mOrder.mAmount];
    }
    
    
    
}

-(void)goPay:(float)price{

    [Order aliPay:_mTitle orderNo:_mOrder.mNo price:price detail:@"月薪" block:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            
            AppointmentVC *appoint = [[AppointmentVC alloc] initWithNibName:@"AppointmentVC" bundle:nil];
            appoint.mTempArray = _mTempArray;
            appoint.mOrder = _mOrder;
            [self pushViewController:appoint];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
            
            OrderDetailVC *od = [[OrderDetailVC alloc] initWithNibName:@"OrderDetailVC" bundle:nil];
            od.mBill_id = _mOrder.mId;
            od.mOrder = _mOrder;
            [self pushViewController:od];
        }
    }];
}

- (IBAction)CheckClick:(id)sender {
    
    _isgoods = !_isgoods;
    
    if (_isgoods) {
        
        _mMoney.text = [NSString stringWithFormat:@"¥%g",_mOrder.mAmount+_goodsprice];
        
        [_mCheck setImage:[UIImage imageNamed:@"a_quan_select"] forState:UIControlStateNormal];
    }else{
        [_mCheck setImage:[UIImage imageNamed:@"a_quan"] forState:UIControlStateNormal];
        
        _mMoney.text = [NSString stringWithFormat:@"¥%d",_mOrder.mAmount];
    }
}

- (IBAction)GoShopCarClick:(id)sender {
    
    
    ShopCartVC *sc = [[ShopCartVC alloc] initWithNibName:@"ShopCartVC" bundle:nil];
    sc.mGoodsAry = _goodsarray;
    sc.itblock = ^(NSString *content,NSString *ids,NSString *counts,float price){
        _mGoodsDetail.text = content;
        
        _back = YES;
        
        if (content.length>0) {
            
            _counts = counts;
            _goodsprice = price;
            _mMoney.text = [NSString stringWithFormat:@"¥%g",_mOrder.mAmount+price];
            _isgoods = YES;
            
            [_mCheck setImage:[UIImage imageNamed:@"a_quan_select"] forState:UIControlStateNormal];
        }
        _ids = ids;
        
    };
    [self pushViewController:sc];
    
}




@end
