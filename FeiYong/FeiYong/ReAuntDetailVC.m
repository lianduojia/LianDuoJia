//
//  ReAuntDetailVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ReAuntDetailVC.h"
#import "AuntHeadView.h"
#import "AuntDetailCell.h"
#import "PingJiaCell.h"
#import "PingJiaSectionView.h"
#import "PingJiaVC.h"

#define Height 266

@interface ReAuntDetailVC ()<UITableViewDataSource,UITableViewDelegate>{

    AuntHeadView *_mHeadView;
    
    int _mselect;
    
    UIView *_mhead;
    PingJiaSectionView *_msection;
    
    UIButton *_mTempBt;
    
    int _mselectindex;
}

@end

@implementation ReAuntDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.hiddenNavBar = YES;
    
    _mselect = 0;
    
    _mTableView.contentInset = UIEdgeInsetsMake(Height, 0, 0, 0);
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"AuntDetailCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    UINib *nib2 = [UINib nibWithNibName:@"PingJiaCell" bundle:nil];
    [_mTableView registerNib:nib2 forCellReuseIdentifier:@"pjcell"];

    [_mTableView setTableHeaderView:UIView.new];
    
    [self loadHeadView];
    
    [self initSection];
    
    _mButtonHeight.constant = 0;
}

- (void)initSection{

    _mselectindex = 0;
    _msection = [PingJiaSectionView shareView];
    
    NSLog(@"%.f %.f",_msection.frame.size.width,_msection.frame.size.height);
    
    [_msection.mbt1 addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msection.mbt2 addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msection.mbt3 addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [_msection.mbt4 addTarget:self action:@selector(ItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _mTempBt = _msection.mbt1;
}

- (void)ItemClick:(UIButton *)sender{

    [_mTempBt setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    [sender setTitleColor:M_CO forState:UIControlStateNormal];
    
    _mselectindex = (int)sender.tag-10;
    
    [_mTableView reloadData];
    
    _mTempBt = sender;
    
}

- (void)loadHeadView{
    
    _mHeadView = [AuntHeadView shareView];
    CGRect rect = _mHeadView.frame;
    rect.origin.y = -Height;
    rect.size.width = DEVICE_Width;
    _mHeadView.frame = rect;
    [_mTableView addSubview:_mHeadView];
    
    [_mHeadView.mPjBt addTarget:self action:@selector(SwitchClick) forControlEvents:UIControlEventTouchUpInside];
    
    _mhead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, 30)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(61.5, 0, 1, 30)];
    line.backgroundColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    [_mhead addSubview:line];
    
    [_mTableView setTableHeaderView:_mhead];
    [_mTableView setTableHeaderView:UIView.new];
}


- (void)SwitchClick{

    if (_mselect == 0) {
        
        _mselect = 1;
        _mHeadView.mYuanImg.image = [UIImage imageNamed:@"a_js"];
        _mHeadView.mLabel.text = @"查看介绍";
        _mLine.hidden = YES;
        
        [_mTableView setTableHeaderView:_msection];
        _mButtonHeight.constant = 50;
        
    }else{
        _mselect = 0;
        _mHeadView.mYuanImg.image = [UIImage imageNamed:@"a_pj"];
        _mHeadView.mLabel.text = @"查看评价";
        _mLine.hidden = NO;
        [_mTableView setTableHeaderView:_mhead];
        _mButtonHeight.constant = 0;
    }
    [_mTableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
//    NSLog(@"_______%.2f",y);
    
    
    
    if (y<=-Height) {
        CGRect rect = _mHeadView.frame;
        rect.origin.y = y;
        rect.size.height = -y;
        _mHeadView.frame = rect;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_mselect == 0) {
        AuntDetailCell* cell = (AuntDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.mLabel.text = @"测试数据测试数据";
        
        return cell;
    }else{
    
        PingJiaCell* cell = (PingJiaCell *)[tableView dequeueReusableCellWithIdentifier:@"pjcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.mContent.text = @"测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据测试数据";
        
        return cell;
    }
    
    

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


- (IBAction)mbackClick:(id)sender {
    
    [self popViewController];
}

- (IBAction)GoPingjiaClick:(id)sender {
    
    PingJiaVC *pj = [[PingJiaVC alloc] initWithNibName:@"PingJiaVC" bundle:nil];
    
    [self.navigationController pushViewController:pj animated:YES];
}



@end
