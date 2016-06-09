//
//  OrderVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCell.h"
#import "OrderSectionView.h"

#define SECTION_HEIGHT 42

@interface OrderVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    
    UIButton *_tempbt;
    
    OrderSectionView *_sectionview;
    
    NSArray *_items;
    
    UITableView *_nowtableview;
    NSMutableArray *_tablearry;
    
    int _nowindex;
}

@end

@implementation OrderVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.hiddenTabBar = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hiddenBackBtn = YES;
    self.navTitle = @"订单";
    
    _tempbt = _mItem1;
    
    
    _mScrollView.pagingEnabled = YES;
    _mScrollView.contentSize = CGSizeMake(DEVICE_Width*4, _mScrollView.frame.size.height);
    
    _mScrollView.delegate = self;
    
    _items = [[NSArray alloc] initWithObjects:_mItem1,_mItem2,_mItem3,_mItem4, nil];
    _tablearry = [NSMutableArray new];
    
    [self loadMyView];
  
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    
    if ([scrollView isKindOfClass:[UITableView class]]) {

        if (scrollView.contentOffset.y<=SECTION_HEIGHT&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=SECTION_HEIGHT) {
            scrollView.contentInset = UIEdgeInsetsMake(-SECTION_HEIGHT, 0, 0, 0);
        }

        
        return;
    }

    CGFloat x = scrollView.contentOffset.x;
    
    int index = x/DEVICE_Width;
    
    _nowtableview = [_tablearry objectAtIndex:index];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        UIButton *bt = [_items objectAtIndex:index];
        _mLine.center = bt.center;
        CGRect rect = _mLine.frame;
        
        rect.origin.y = 37;
        _mLine.frame = rect;
    }];
    
    [_tempbt setTitleColor:M_TCO2 forState:UIControlStateNormal];
    UIButton *bt = [_items objectAtIndex:index];
    [bt setTitleColor:M_CO forState:UIControlStateNormal];
    
    _tempbt = bt;
    
    _nowindex = index;
    
    NSLog(@"_______%.2f",x);
}

- (void)loadMyView{

    for (int i = 0; i < 4; i++) {
        
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(i*DEVICE_Width, 0, DEVICE_Width, DEVICE_InNavTabBar_Height-40)];
        contentView.backgroundColor = M_BGCO;
        
        UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(8, 0, DEVICE_Width-16, contentView.frame.size.height)];
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.tag = 10+i;
        
        tableview.backgroundColor = [UIColor clearColor];
//        if (i == 0 || i == 3) {
            UINib *nib = [UINib nibWithNibName:@"OrderCell" bundle:nil];
            [tableview registerNib:nib forCellReuseIdentifier:@"cell"];
//        }else if (i == 1){
            UINib *nib2 = [UINib nibWithNibName:@"OrderYyCell" bundle:nil];
            [tableview registerNib:nib2 forCellReuseIdentifier:@"yycell"];
//        }else{
            UINib *nib3 = [UINib nibWithNibName:@"OrderPjCell" bundle:nil];
            [tableview registerNib:nib3 forCellReuseIdentifier:@"pjcell"];
//        }
        tableview.delegate = self;
        tableview.dataSource = self;
        
        [_tablearry addObject:tableview];
    
        __block OrderVC *vc = self;
        [tableview addHeaderWithCallback:^{
            [vc headerBeganRefresh];
        }];
        
        [tableview addFooterWithCallback:^{
            [vc footetBeganRefresh];
        }];
        
        
        [contentView addSubview:tableview];
        
        [_mScrollView addSubview:contentView];
        
        
    }
    
    _nowtableview = [_tablearry objectAtIndex:0];
}

- (void)headerBeganRefresh{

    [_nowtableview headerEndRefreshing];
}

- (void)footetBeganRefresh{
    [_nowtableview footerEndRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return SECTION_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    _sectionview = [OrderSectionView shareView];
    return _sectionview;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderCell* cell;
    
    switch ((int)tableView.tag) {
        case 10:
            cell= (OrderCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
            break;
        case 11:
            cell= (OrderCell *)[tableView dequeueReusableCellWithIdentifier:@"yycell"];
            break;
        case 12:
            cell= (OrderCell *)[tableView dequeueReusableCellWithIdentifier:@"pjcell"];
            break;
        case 13:
            cell= (OrderCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
            cell.mButton.hidden = YES;
            break;
            
        default:
            break;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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

- (IBAction)mChoseClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;
    
    int index = (int)bt.tag-10;
    
    _nowtableview = [_tablearry objectAtIndex:index];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _mScrollView.contentOffset = CGPointMake(DEVICE_Width*index, 0);
    }];
}
@end
