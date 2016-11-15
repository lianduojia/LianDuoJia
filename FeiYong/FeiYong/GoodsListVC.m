//
//  GoodsListVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/4.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "GoodsListVC.h"
#import "GoodsCell.h"
#import "GoodsDetailVC.h"

@interface GoodsListVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GoodsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_mType.length >0) {
        self.navTitle = _mType;
    }else{
        self.navTitle = _mKey;
    }
    
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    self.tableView = _mTableView;
    self.haveHeader = YES;
    
    UINib *nib = [UINib nibWithNibName:@"GoodsCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self headerBeganRefresh];
}

- (void)headerBeganRefresh{
    
    if (_mType.length > 0) {
        
        [self showStatu:@"加载中.."];
        
        [SGoods getGoodsByCategory:_mType block:^(SResBase *retobj, NSArray *arr) {
            
            if (retobj.msuccess) {
                
                [SVProgressHUD dismiss];
                
                self.tempArray = (NSMutableArray *)arr;
                [self headerEndRefresh];
                
                [self.tableView reloadData];
                
                if (arr.count==0) {
                    
                    [self addEmpty:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavTabBar_Height) image:nil];
                }else{
                    [self removeEmpty];
                }
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                [self headerEndRefresh];
            }
        }];
    }else{
    
        [self showStatu:@"加载中.."];
        
        [SGoods searchByKey:_mKey block:^(SResBase *retobj, NSArray *arr) {
            
            if (retobj.msuccess) {
                
                [SVProgressHUD dismiss];
                
                self.tempArray = (NSMutableArray *)arr;
                [self headerEndRefresh];
                
                [self.tableView reloadData];
                
                if (arr.count==0) {
                    
                    [self addEmpty:CGRectMake(0, 0, DEVICE_Width, DEVICE_InNavTabBar_Height) image:nil];
                }else{
                    [self removeEmpty];
                }

                
            }else{
                
                [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                [self headerEndRefresh];
            }
        }];
    }
    
    

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArray.count;
}



-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    SGoods *goods = [self.tempArray objectAtIndex:indexPath.row];
    
    cell.mName.text = goods.mGoods_name;
    cell.mPrice.text = [NSString stringWithFormat:@"¥%g",goods.mPrice];
    cell.mImg.backgroundColor = randomColor;
    [cell.mImg sd_setImageWithURL:[NSURL URLWithString:goods.mPreview_img_path] placeholderImage:[UIImage imageNamed:@"banner_default"]];
   
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

     SGoods *goods = [self.tempArray objectAtIndex:indexPath.row];
    
    GoodsDetailVC *gd = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
    gd.mGoods = goods;
    [self pushViewController:gd];
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
