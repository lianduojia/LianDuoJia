//
//  HourWorkPayVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/24.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "HourWorkPayVC.h"
#import "ShopCartVC.h"
#import "OrderDetailVC.h"

@interface HourWorkPayVC (){

    BOOL _isgoods;
    
    float _goodsprice;
    
    NSString *_ids;
    NSString *_counts;
    
    NSArray *_goodsarray;
}

@end

@implementation HourWorkPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"订单支付";
    _mAddress.text = _mAddr;
    _mTime.text = _mServiceTime;
    _mPhone.text = [SUser currentUser].mPhone;
    
    _mMoney.text = [NSString stringWithFormat:@"¥%d",_mOrder.mAmount];
    
    
    _isgoods = NO;
    
    _ids = @"";
    _counts = @"";
    
    [self showStatu:@"加载中.."];
    [SGoods getCartData:^(SResBase *retobj, NSArray *arr) {
        
        if (retobj.msuccess) {
            
            [SVProgressHUD dismiss];
            
            _goodsarray = arr;
            
            int count = 0;
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
            _mGoodsText.text = [NSString stringWithFormat:@"共%d件 ¥%g",count,_goodsprice];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];

}

- (void)leftBtnTouched:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

- (IBAction)mPayClick:(id)sender {
    
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

- (void)goPay:(float)price{

    [Order aliPay:@"小时工" orderNo:_mOrder.mNo price:price detail:@"工时费" block:^(SResBase *retobj) {
        if (retobj.msuccess) {
            
            //            [_mOrder payOK:^(SResBase *retobj) {
            
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.tabBarController.selectedIndex = 1;
            //            }];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
            OrderDetailVC *od = [[OrderDetailVC alloc] initWithNibName:@"OrderDetailVC" bundle:nil];
            od.mBill_id = _mOrder.mId;
            od.mOrder = _mOrder;
            [self pushViewController:od];
        }
    }];
}

- (IBAction)mCheckClick:(id)sender {
    
    _isgoods = !_isgoods;
    
    if (_isgoods) {
        
        _mMoney.text = [NSString stringWithFormat:@"¥%g",_mOrder.mAmount+_goodsprice];
        
        [_mCheck setImage:[UIImage imageNamed:@"a_quan_select"] forState:UIControlStateNormal];
    }else{
        [_mCheck setImage:[UIImage imageNamed:@"a_quan"] forState:UIControlStateNormal];
        
        _mMoney.text = [NSString stringWithFormat:@"¥%d",_mOrder.mAmount];
    }
}

- (IBAction)mGoodsClick:(id)sender {
    
    ShopCartVC *sc = [[ShopCartVC alloc] initWithNibName:@"ShopCartVC" bundle:nil];
    sc.mGoodsAry = _goodsarray;
    sc.itblock = ^(NSString *content,NSString *ids,NSString *counts,float price){
        _mGoodsText.text = content;
        
        if(content.length>0)
        {
            _counts = counts;
            _goodsprice = price;
            _mMoney.text = [NSString stringWithFormat:@"¥%g",_mOrder.mAmount+price];
            
            _isgoods = YES;
            [_mCheck setImage:[UIImage imageNamed:@"a_quan_select"] forState:UIControlStateNormal];
        }
    };
    [self pushViewController:sc];
}
@end
