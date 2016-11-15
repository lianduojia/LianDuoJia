//
//  ReAuntDetailVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ReAuntDetailVC.h"
#import "AuntHeadView.h"
#import "AuntSectionView.h"
#import "PingJiaCell.h"
#import "PingJiaVC.h"
#import "AuntDetailCell.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

#define Height 222

@interface ReAuntDetailVC ()<UITableViewDataSource,UITableViewDelegate>{

    AuntHeadView *_mHeadView;
    
    int _mselect;
    
    UIView *_mhead;
    
    UIButton *_mTempBt;
}

@end

@implementation ReAuntDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.hiddenNavBar = YES;
    
    _mselect = 0;
    
//    _mTableView.contentInset = UIEdgeInsetsMake(Height, 0, 0, 0);
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    UINib *nib1 = [UINib nibWithNibName:@"AuntDetailCell" bundle:nil];
    [_mTableView registerNib:nib1 forCellReuseIdentifier:@"adcell"];
    
    [_mTableView setTableHeaderView:UIView.new];
    
    UINib *nib2 = [UINib nibWithNibName:@"PingJiaCell" bundle:nil];
    [_mTableView registerNib:nib2 forCellReuseIdentifier:@"pjcell"];

    [_mTableView setTableHeaderView:UIView.new];
    
    self.tableView = _mTableView;
    
    [self loadHeadView];
    
    [self headerBeganRefresh];
}


- (void)headerBeganRefresh{

    self.page = 0;
    
    [self showStatu:@"加载中.."];
    [_mAuntInfo getComment:self.page block:^(SResBase *retobj, NSArray *arr) {
        [self headerEndRefresh];
        
        if (retobj.msuccess) {
            
            [SVProgressHUD dismiss];
            
            if (arr.count == 0) {
                [SVProgressHUD showErrorWithStatus:@"暂无评论"];
                
                [self addEmpty:CGRectMake(0, 0, DEVICE_Width, 200) image:@"empty_pj"];

            }else{
                [self removeEmpty];
            }
            
            self.tempArray = (NSMutableArray *)arr;
            
            [self.tableView reloadData];
        }else{
            
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

-(void)footetBeganRefresh{

    self.page ++;
    
    [self showStatu:@"加载中.."];
    [_mAuntInfo getComment:self.page block:^(SResBase *retobj, NSArray *arr) {
        [self footetEndRefresh];
        if (retobj.msuccess) {
            
            if (self.tempArray.count == 0 ) {
                [SVProgressHUD showErrorWithStatus:@"暂无评论"];
                
                return;
            }
            if (arr.count == 0 ) {
                [SVProgressHUD showErrorWithStatus:@"暂无新评论"];
                return;
            }
            
            [self.tempArray addObjectsFromArray:arr];
            
            [self.tableView reloadData];
        }else{
            
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}


- (void)loadHeadView{
    
    _mHeadView = [AuntHeadView shareView];
    CGRect rect = _mHeadView.frame;
    rect.origin.y = -Height;
    rect.size.width = DEVICE_Width;
    _mHeadView.frame = rect;
    [_mTableView setTableHeaderView:_mHeadView];
    
    _mHeadView.mName.text = _mAuntInfo.mName;
    _mHeadView.mAge.text = [NSString stringWithFormat:@"%d岁",_mAuntInfo.mAge];
    _mHeadView.mConstellation.text = _mAuntInfo.mConstellation;
    _mHeadView.mAddress.text = _mAuntInfo.mProvince;
    [_mHeadView.mHeadImg sd_setImageWithURL:[NSURL URLWithString:_mAuntInfo.mPhoto_url] placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
    
    _mHeadView.mHeadImg.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PhotoClick:)];
    [_mHeadView.mHeadImg addGestureRecognizer:tap];

}

- (void)PhotoClick:(UITapGestureRecognizer *)tap{

    UIImageView* tagv = (UIImageView*)tap.view;
    
    
    NSMutableArray* allimgs = NSMutableArray.new;
    
    MJPhoto* onemj = [[MJPhoto alloc]init];
    onemj.url = [NSURL URLWithString:_mAuntInfo.mPhoto_url];
    onemj.srcImageView = tagv;
    [allimgs addObject: onemj];
    
    MJPhotoBrowser* browser = [[MJPhotoBrowser alloc]init];
    browser.currentPhotoIndex = 0;
    browser.photos  = allimgs;
    [browser show];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat y = scrollView.contentOffset.y;
//    NSLog(@"_______%.2f",y);
    
    
//    
//    if (y<=-Height) {
//        CGRect rect = _mHeadView.frame;
//        rect.origin.y = y;
//        rect.size.height = -y;
//        _mHeadView.frame = rect;
//    }else if(y>-Height && y<=0){
//        _mTableView.contentInset = UIEdgeInsetsMake(-y, 0, 0, 0);
//    }
//
//    CGFloat sectionHeaderHeight = 50;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 3;
    else
        return self.tempArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    AuntSectionView *view = [AuntSectionView shareView];
    
    if (section == 0) {
        view.mLabel.text = @"工作简介";
    }else{
        view.mLabel.text = @"查看评价";
    }
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        AuntDetailCell* cell = (AuntDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"adcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:
                cell.mLabel.text =  [NSString stringWithFormat:@"现居住于%@%@%@",_mAuntInfo.mLiving_province,_mAuntInfo.mLiving_city,_mAuntInfo.mLiving_area];
                break;
            case 1:
                cell.mLabel.text =  [NSString stringWithFormat:@"从事%@工作%d年",_mAuntInfo.mWork_type,_mAuntInfo.mWorking_years];
                break;
            case 2:
                cell.mLabel.text =  [NSString stringWithFormat:@"%@星%@",_mAuntInfo.mStar,_mAuntInfo.mWork_type];
                break;
                
            default:
                break;
        }
        
        return cell;
    }else{
        PingJiaCell* cell = (PingJiaCell *)[tableView dequeueReusableCellWithIdentifier:@"pjcell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        SComment *comment = [self.tempArray objectAtIndex:indexPath.row];
        
        [cell initCell:comment];
        
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
    pj.mPjType = @"线上评价";
    pj.mAunt = _mAuntInfo;
    
    [self.navigationController pushViewController:pj animated:YES];
}



@end
