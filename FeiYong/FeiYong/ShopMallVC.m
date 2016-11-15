//
//  ShopMallVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/9/1.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ShopMallVC.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "WebVC.h"
#import "GoodsListVC.h"
#import "SDCycleScrollView.h"
#import "GoodsCell.h"
#import "GoodsDetailVC.h"

#define Width [UIScreen mainScreen].bounds.size.width
//NewPagedFlowViewDelegate, NewPagedFlowViewDataSource

@interface ShopMallVC ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    
    SDCycleScrollView *_cycleScrollView;
    
    NSArray *_banners;
    
    
}

@end

@implementation ShopMallVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.hiddenTabBar = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hiddenBackBtn = YES;
    self.navTitle = @"商城";
    self.navBar.hidden = YES;
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    _mSearchBar.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"GoodsTwoCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [_mTableView setTableFooterView:[UIView new]];
    
    [self showStatu:@"加载中.."];
    
    [SShops getShopData:^(SResBase *retobj, SShops *shops) {
       
        if (retobj.msuccess) {
            [SVProgressHUD dismiss];
            
            [self loadData:shops];
            
            self.tempArray = (NSMutableArray *)shops.mGoods_recommend;
            
            [_mTableView reloadData];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
    
}

- (void)loadData:(SShops *)shops{

    NSMutableArray *bannerAry = [[NSMutableArray alloc] initWithCapacity:0];
    
    _banners = shops.mGoods_banner;
    
    for (SBanner *banner in shops.mGoods_banner) {
        [bannerAry addObject:banner.mBanner_img_path];
    }
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Width/75*22) imagesGroup:bannerAry];
    _cycleScrollView.delegate = self;
    [_mBannerView addSubview:_cycleScrollView];
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
//    NSLog(@"---点击了第%ld张图片", (long)index);
//    WebVC *web = [[WebVC alloc] init];
//    web.isMode = YES;
//    web.mUrl = ((SBanner *)[_banners objectAtIndex:index]).mBanner_url;
//    [self presentViewController:web animated:YES completion:nil];
    
    
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
    return 132;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
     SGoods *goods = [self.tempArray objectAtIndex:indexPath.row];
    
    cell.mName.text = goods.mGoods_name;
    cell.mIntroduction.text = goods.mIntroduction;
    cell.mImg.backgroundColor = randomColor;
    [cell.mImg sd_setImageWithURL:[NSURL URLWithString:goods.mPreview_img_path] placeholderImage:[UIImage imageNamed:@"default"]];
    cell.mRemark.text = @"";
    cell.mButton.layer.masksToBounds = YES;
    cell.mButton.layer.cornerRadius = 5;
    cell.mButton.tag = indexPath.row;
    [cell.mButton addTarget:self action:@selector(AddCarClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SGoods *goods = [self.tempArray objectAtIndex:indexPath.row];
    
    GoodsDetailVC *gd = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
    gd.mGoods = goods;
    [self pushViewController:gd];
}

- (void)AddCarClick:(UIButton *)btn{
    
    if ([SUser isNeedLogin]) {
        [self gotoLogin];
        return;
    }
    
    int index = (int)btn.tag;
    
    SGoods *goods = [self.tempArray objectAtIndex:index];
    
    [self showStatu:@"操作中.."];
    [goods addGoods:1 block:^(SResBase *retobj) {
        
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    
    GoodsListVC *goods = [[GoodsListVC alloc] initWithNibName:@"GoodsListVC" bundle:nil];
    goods.mKey = searchBar.text;
    [self pushViewController:goods];
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

//全部、洗涤用品、养生保健、清洁工具
- (IBAction)mMenuClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    GoodsListVC *goods = [[GoodsListVC alloc] initWithNibName:@"GoodsListVC" bundle:nil];
    
    
    switch (btn.tag) {
        case 10:
            goods.mType = @"全部";
            break;
        case 11:
            goods.mType = @"洗涤用品";
            break;
        case 12:
            goods.mType = @"养生保健";
            break;
        case 13:
            goods.mType = @"母婴用品";
            break;
            
        default:
            break;
    }
    
    [self pushViewController:goods];
}
@end
