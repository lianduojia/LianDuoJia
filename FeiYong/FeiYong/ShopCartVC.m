//
//  ShopCartVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/9.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ShopCartVC.h"
#import "ShopCartCell.h"

@interface ShopCartVC ()<UITableViewDelegate,UITableViewDataSource>{

    BOOL _edit;
    
    float _price;
    int _num;
}

@end

@implementation ShopCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navTitle = @"购物车";
    self.navRightText = @"编辑";
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    self.tableView = _mTableView;
    self.haveHeader = YES;
    
    if (_mOwn) {
        _mBottomHeight.constant = 0;
    }
    
    UINib *nib = [UINib nibWithNibName:@"ShopCartCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (_mGoodsAry.count>0) {
         self.tempArray = (NSMutableArray *)_mGoodsAry;
        
        _price = 0;
        for (SGoods *g in self.tempArray) {
            
            if (g.mCheck) {
                _price += g.mPrice*g.mCount;
            }
        }
        _mPrice.text = [NSString stringWithFormat:@"¥%g",_price];
    }else{
        [self headerBeganRefresh];
    }
   
    

}

- (void)rightBtnTouched:(id)sender{
    
    _edit = !_edit;

    if (_edit) {
        self.navRightText = @"完成";
        
        [_mTableView setEditing:YES animated:YES];
        
    }else{
        self.navRightText = @"编辑";
         [_mTableView setEditing:NO animated:YES];
        
    }
    [_mTableView reloadData];
    
    
}

- (void)headerBeganRefresh{
    
    
    [self showStatu:@"加载中.."];
    [SGoods getCartData:^(SResBase *retobj, NSArray *arr) {
       
        if (retobj.msuccess) {
            
            [SVProgressHUD dismiss];
            self.tempArray = (NSMutableArray *)arr;
            
            [_mTableView reloadData];
            
            if (arr.count==0) {
                
                [self addEmpty:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavTabBar_Height) image:nil];
            }else{
                [self removeEmpty];
            }
            _price = 0;
            for (SGoods *g in arr) {
                
                if (g.mCheck) {
                    _price += g.mPrice*g.mCount;
                }
            }
            _mPrice.text = [NSString stringWithFormat:@"¥%g",_price];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
        
        [self headerEndRefresh];
    }];
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 8;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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
    
    SGoods *goods = [self.tempArray objectAtIndex:indexPath.section];
    
    [self showStatu:@"操作中.."];
    [goods delAllGoods:^(SResBase *retobj) {
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            [self.tempArray removeObjectAtIndex:indexPath.section];
            
            [_mTableView beginUpdates];
            [_mTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            [_mTableView endUpdates];
            
            [_mTableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
    
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.tempArray.count;
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


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(_mOwn){
        cell.mCheckWidth.constant = 0;
    }
    SGoods *goods = [self.tempArray objectAtIndex:indexPath.section];
    
    cell.mName.text = goods.mGoods_name;
    cell.mPrice.text = [NSString stringWithFormat:@"¥%g",goods.mPrice];
    cell.mImg.backgroundColor = randomColor;
    [cell.mImg sd_setImageWithURL:[NSURL URLWithString:goods.mPreview_img_path] placeholderImage:[UIImage imageNamed:@"default"]];
    if (goods.mCheck) {
        [cell.mCheckBt setImage:[UIImage imageNamed:@"a_quan_select"] forState:UIControlStateNormal];
    }else{
        [cell.mCheckBt setImage:[UIImage imageNamed:@"a_quan"] forState:UIControlStateNormal];
    }
    
    cell.mNum.text = [NSString stringWithFormat:@"X %d",goods.mCount];
    cell.mNumBt.hidden = YES;
    cell.mDelBt.hidden = YES;
    cell.mAddBt.hidden = YES;
    cell.mNum.hidden = NO;
    if (_edit) {
        cell.mNum.hidden = YES;
        cell.mNumBt.hidden = NO;
        cell.mDelBt.hidden = NO;
        cell.mAddBt.hidden = NO;
        [cell.mNumBt setTitle:[NSString stringWithFormat:@"%d",goods.mCount] forState:UIControlStateNormal];
        cell.mDelBt.tag = indexPath.section;
        cell.mAddBt.tag = indexPath.section;
        
        [cell.mDelBt addTarget:self action:@selector(DelNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.mAddBt addTarget:self action:@selector(AddNumClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.mCheckBt.tag = indexPath.section;
    [cell.mCheckBt addTarget:self action:@selector(CheckClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)CheckClick:(UIButton *)sender{
    
    int index = (int)((UIButton *)sender).tag;
    SGoods *goods = [self.tempArray objectAtIndex:index];
    goods.mCheck = !goods.mCheck;
    
    
    _price = 0;
    for (SGoods *g in self.tempArray) {
        
        if (g.mCheck) {
            _price += g.mPrice*g.mCount;
        }
    }
    _mPrice.text = [NSString stringWithFormat:@"¥%g",_price];
    
    [self.mTableView reloadData];
}

- (void)AddNumClick:(UIButton *)sender{

    
    int index = (int)((UIButton *)sender).tag;
    SGoods *goods = [self.tempArray objectAtIndex:index];
  
    
    [self showStatu:@"操作中.."];
    
    [goods addGoods:1 block:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            [self headerBeganRefresh];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (void)DelNumClick:(UIButton *)sender{
    
    
    int index = (int)((UIButton *)sender).tag;
    SGoods *goods = [self.tempArray objectAtIndex:index];
    
    [self showStatu:@"操作中.."];
    
    [goods delGoods:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
            
            [self headerBeganRefresh];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

- (IBAction)mGoPayClick:(id)sender {
    
    _price = 0;
    _num = 0;
    
    NSString *ids = @"";
    NSString *counts = @"";
    for (SGoods *g in self.tempArray) {
        
        if (g.mCheck) {
            
            _price += g.mPrice*g.mCount;
            _num+=g.mCount;
            
            ids = [ids stringByAppendingString:[NSString stringWithFormat:@"%d,",g.mGoods_id]];
            counts = [counts stringByAppendingString:[NSString stringWithFormat:@"%d,",g.mCount]];
        }
    }
    NSString *content = @"";
    if (_price>0) {
        content = [NSString stringWithFormat:@"共%d件 ¥%g",_num,_price];
    }
    
    if (ids.length>1) {
        ids = [ids substringWithRange:NSMakeRange(0, [ids length] - 1)];
        counts = [counts substringWithRange:NSMakeRange(0, [counts length] - 1)];
    }
    
    if (_itblock) {
        _itblock(content,ids,counts,_price);
    }
    [self popViewController];
}
@end
