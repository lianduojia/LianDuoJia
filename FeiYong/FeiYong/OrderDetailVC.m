//
//  OrderDetailVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/10.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "OrderDetailVC.h"
#import "AppointmentVC.h"
#import "GoodsView.h"
#import "ComplaintVC.h"

@interface OrderDetailVC (){

    SOrderDetail *_orderdetial;
}

@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"订单详情";
    
    [self showStatu:@"加载中.."];
    [SOrderDetail getOrderDetail:_mBill_id block:^(SResBase *retobj, SOrderDetail *order) {
        
        if (retobj.msuccess) {
            [SVProgressHUD dismiss];
            _orderdetial = order;
            [self loadData:order];
        }else{
            
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
    [self.navBar.mRightButton setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
    [self.navBar.mRightButton2 setImage:[UIImage imageNamed:@"tousu"] forState:UIControlStateNormal];
}

- (void)rightBtnTouched:(id)sender{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",TEL];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}

- (void)rightBtnTouched2:(id)sender{
    
    ComplaintVC *cp = [[ComplaintVC alloc] initWithNibName:@"ComplaintVC" bundle:nil];
    cp.mOrder = _orderdetial;
    [self pushViewController:cp];
}


- (void)leftBtnTouched:(id)sender{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadData:(SOrderDetail *)order{
    
    _mNo.text = [NSString stringWithFormat:@"订单号：%@",order.mNo];
    _mTime.text = [NSString stringWithFormat:@"下单时间：%@",order.mTime];
    _mStatu.text = [NSString stringWithFormat:@"订单状态：%@",order.mStatus];
    _mAunt.text = [NSString stringWithFormat:@"雇佣阿姨：%@",order.mMaid];
    _mPrice.text = [NSString stringWithFormat:@"¥%g",order.mAmount];
    _mPayPrice.text = [NSString stringWithFormat:@"¥%g",order.mAll_amount];
    
    if(order.mBack_amount == 0){
    
        _mCjHeight.constant = 0;
    }else{
        _mCjHeight.constant = 48;
        _mReturnPrice.text = [NSString stringWithFormat:@"¥%g",order.mBack_amount];
    }
    
    if ([order.mStatus isEqualToString:@"待支付"]) {
        _mButton.hidden = NO;
        _mButton.layer.masksToBounds = YES;
        _mButton.layer.cornerRadius = 4;
        _mButton.layer.borderColor = M_CO.CGColor;
        _mButton.layer.borderWidth = 1;
    }else{
        _mButton.hidden = YES;
    }
    
    if (order.mGoods.count>0) {
        
        _mGoodsViewHeight.constant = order.mGoods.count*45+1;
        
        for (int i = 0;i<order.mGoods.count;i++) {
            SGoods *g = [order.mGoods objectAtIndex:i];
            GoodsView *gv = [GoodsView shareView];
            gv.mName.text = g.mGoods_name;
            gv.mNum.text = [NSString stringWithFormat:@"X%d",g.mCount];
            gv.mPrice.text = [NSString stringWithFormat:@"¥%g",g.mPrice*g.mCount];
            
            gv.frame = CGRectMake(75, 45*i, DEVICE_Width-90, 45);
            [_mGoodsView addSubview:gv];
        }
        
    }else{
    
        _mGoodsViewHeight.constant = 0;
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

- (IBAction)PayClick:(id)sender {
    
    NSString *string = @"月薪";
    if (_mOrder.mWork_type.length>0) {
        string = _mOrder.mWork_type;
    }
    //    [self showStatu:@"支付中"];
    [Order aliPay:string orderNo:_mOrder.mNo price:_mOrder.mAll_amount detail:string block:^(SResBase *retobj) {
        if (retobj.msuccess) {
            
            [_mOrder payOK:^(SResBase *retobj) {
                
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                
                if (_mOrder.mFirst) {
                    
                    AppointmentVC *appoint = [[AppointmentVC alloc] initWithNibName:@"AppointmentVC" bundle:nil];
                    appoint.mOrder = _mOrder;
                    [self pushViewController:appoint];
                    
                }else{
                    
                    [self popViewController];
                }
                
            }];
            
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"支付失败"];
            
        }
    }];

}
@end
