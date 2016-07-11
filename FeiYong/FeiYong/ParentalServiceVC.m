//
//  ParentalServiceVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/6.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "ParentalServiceVC.h"
#import "ParentalCell.h"
#import "BombBoxVC.h"
#import "ChoseAddressVC.h"
#import "ReAuntVC.h"
#import "Util.h"
#import "ChosePlaceVC.h"
#import "HourWorkPayVC.h"

@interface ParentalServiceVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>{

    BombBoxVC *_mbombbox;
    BombBoxVC *_mbombbox2;
    NSString *_myctime; //预产期时间/服务时间
    NSString *_maddress;//服务地点
    NSString *_mdetailaddress;
    NSString *_mfwsd;//服务时段
    NSString *_mfwsc;//服务时长
    NSString *_mfwnum;//服务人数
    NSString *_mplace;//户籍
    
    NSString *_province;
    NSString *_city;
    NSString *_area;
    
    NSMutableArray *_fwscarray;  //服务时长数组
    NSMutableArray *_fwrsarray;  //服务人数
    NSMutableArray *_fwsdarray;  //服务时段
    
    UIButton *_mitembt1;  //年龄
    UIButton *_mitembt2;
    UIButton *_mitembt3;
    UIButton *_mitembt4;
    
    int       _selectindex;
    int       _backindex1;
    int       _backindex2;
    int       _backindex3;
    
    
    int  _minage;
    int  _maxage;
    
    NSArray *_auntarr;
    
    

}

@end

@implementation ParentalServiceVC


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.hiddenTabBar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    _minage = 0;
    _maxage = 100;
    _backindex1 = 100;
    _backindex2 = 100;
    _backindex3 = 100;
    
    _mitembt1 = _mBuxian;
    _mitembt2 = _mHome;
    _mitembt3 = _mItem2;
    _mitembt4 = _mOld;
    
    _mbombbox = [[BombBoxVC alloc] initWithNibName:@"BombBoxVC" bundle:nil];
    _mbombbox.view.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
    
    _mbombbox2 = [[BombBoxVC alloc] initWithNibName:@"BombBoxTwoVC" bundle:nil];
    _mbombbox2.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"ParentalCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _mTableView.scrollEnabled = NO;
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    _mRemark.layer.masksToBounds = YES;
    _mRemark.layer.cornerRadius = 5;
    
    switch (_mType) {
        case YUESAO:
            [self loadYuesao];
            break;
        case YUERSAO:
            [self loadYuersao];
            break;
        case BUZHUJIABAOMU:case ZHUJIABAOMU:
            
            [self loadBaomu];
            break;

        case LAORENPEIHU:
            [self loadPeihu];
            break;
        case XIAOSHIGONG:
            [self loadXiaoshigong];
            break;

        case FEIYONG:
            [self loadFeiyong];
            break;
            
        default:
            break;
    }
    _mRemark.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _mRemarkHolder.text = @"如做菜口味等";
    }else{
        _mRemarkHolder.text = @"";
    }
}

//月嫂
- (void)loadYuesao{

     self.navTitle = @"找月嫂";
    _myctime = @"";
    _maddress = @"";
    _mTableViewHeight.constant = 60*2+1;
    _mAgeHeight.constant = 0;
    
    _mTimelb.text = @"请选择证书要求";
    [_mHome setTitle:@"有证书" forState:UIControlStateNormal];
    [_mDay setTitle:@"没有证书" forState:UIControlStateNormal];
    
    _mItemTwoHeight.constant = 0;
    _mItemThreeHeight.constant = 0;
    
    _mHeadImg.image = [UIImage imageNamed:@"banner_yuesao"];
    
}

//育儿嫂
- (void)loadYuersao{

     self.navTitle = @"找育儿嫂";
    _mTableViewHeight.constant = 60*2+1;
    
    _mTimelb.text = @"请选择服务类型";
    [_mHome setTitle:@"住家" forState:UIControlStateNormal];
    [_mDay setTitle:@"白班" forState:UIControlStateNormal];
    
    _mItemTwoHeight.constant = 0;
    _mItemThreeHeight.constant = 0;
    
    _mHeadImg.image = [UIImage imageNamed:@"banner_yuersao"];
    
}

//保姆
- (void)loadBaomu{
    
    
    if (_mType == ZHUJIABAOMU)
        self.navTitle = @"找住家保姆";
    else
        self.navTitle = @"找不住家保姆";
    _mTableViewHeight.constant = 60*2+1;
    
    _mAgelb.text = @"请选择保姆年龄";
    
    _mTimeHeight.constant = 0;
    [_mHome setTitle:@"住家" forState:UIControlStateNormal];
    [_mDay setTitle:@"白班" forState:UIControlStateNormal];
    
    _mItemTwoHeight.constant = 0;
    _mItemThreeHeight.constant = 0;
    
    _mRemarklb.text = @"您对保姆的其他要求";
    
    _mHeadImg.image = [UIImage imageNamed:@"banner_baomu"];
}

//陪护
- (void)loadPeihu{
    
    self.navTitle = @"找陪护";
    _mTableViewHeight.constant = 60+1;
    
    _mAgeHeight.constant = 0;
    _mAgelb.text = @"请选择护工年龄";
    
    _mTimelb.text = @"请选择护工性别";
    [_mHome setTitle:@"男" forState:UIControlStateNormal];
    [_mDay setTitle:@"女" forState:UIControlStateNormal];
    
    _mRemarklb.text = @"您对护工的其他要求";
    
    _mHeadImg.image = [UIImage imageNamed:@"banner_peihu"];
    
}

//小时工
- (void)loadXiaoshigong{
    
    //服务人数数组
    _fwsdarray = [NSMutableArray new];
    
    for (int i = 7; i<23; i++) {
        [_fwsdarray addObject:[NSString stringWithFormat:@"%.2d:00",i]];
    }
    
    //服务人数数组
    _fwrsarray = [NSMutableArray new];
    
    for (int i = 0; i<10; i++) {
        [_fwrsarray addObject:[NSString stringWithFormat:@"%d人",i+1]];
    }
    
    //服务时长数组
    _fwscarray = [NSMutableArray new];
    for (int i = 0; i<12; i++) {
        [_fwscarray addObject:[NSString stringWithFormat:@"%d小时",i+1]];
    }
    

    if(_mType == XIAOSHIGONG){
        self.navTitle = @"找小时工";
        _mTableViewHeight.constant = 60*6+1;
        
    }else{
        self.navTitle = @"找长期小时工";
        _mTableViewHeight.constant = 60*6+1;
    }
    
    _mProcessHeight.constant = 115;
    _mImg2.image = [UIImage imageNamed:@"s_zfzjf"];
    _mLab2.text = @"支付工时费";
    _mImg3.image = [UIImage imageNamed:@"s_pjay"];
    _mLab3.text = @"评价阿姨";
    
    _mAgeHeight.constant = 0;
    _mTimeHeight.constant = 0;
    _mItemTwoHeight.constant = 0;
    _mItemThreeHeight.constant = 0;
    _mRemarklb.text = @"您对小时工的其他要求";
    
    _mHeadImg.image = [UIImage imageNamed:@"banner_xsg"];

    
}

- (void)loadFeiyong{
    
        
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (_mType) {
        case YUESAO:case YUERSAO:case BUZHUJIABAOMU: case ZHUJIABAOMU:
            return 2;
            break;
        case LAORENPEIHU:
            return 1;
            break;

        case XIAOSHIGONG:
            return 6;
            
            break;
        case YANGLAO:
            return 0;
            break;
        case FEIYONG:
            
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ParentalCell* cell = (ParentalCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            
            if (_mType == YUESAO || _mType == XIAOSHIGONG){
                
                cell.mImg.image = [UIImage imageNamed:@"s_time"];
                if (_myctime.length == 0) {
                    if (_mType == YUESAO) {
                        cell.mName.text = @"请选择预产时间";
                    }else{
                        cell.mName.text = @"请选择服务时间";
                    }
                    
                    cell.mName.textColor = M_TCO2;
                }else{
                    cell.mName.text = _myctime;
                    cell.mName.textColor = M_TCO;
                }
                
            }else{
            
                cell.mImg.image = [UIImage imageNamed:@"s_address"];
                if (_maddress.length == 0) {
                    cell.mName.text = @"请选择服务地点";
                    cell.mName.textColor = M_TCO2;
                }else{
                    cell.mName.text = _maddress;
                    cell.mName.textColor = M_TCO;
                }
            }
            
            break;
        case 1:
            if(_mType == YUESAO){
            
                cell.mImg.image = [UIImage imageNamed:@"s_address"];
                if (_maddress.length == 0) {
                    cell.mName.text = @"请选择服务地点";
                    cell.mName.textColor = M_TCO2;
                }else{
                    cell.mName.text = _maddress;
                    cell.mName.textColor = M_TCO;
                }

            }else if (_mType == XIAOSHIGONG){
                
                cell.mImg.image = [UIImage imageNamed:@"s_address"];
                if (_maddress.length == 0) {
                    cell.mName.text = @"请选择服务地点";
                    cell.mName.textColor = M_TCO2;
                }else{
                    cell.mName.text = _maddress;
                    cell.mName.textColor = M_TCO;
                }
                
            }else{
            
                cell.mImg.image = [UIImage imageNamed:@"s_huji"];
                if (_mplace.length == 0) {
                    cell.mName.text = @"请选择户籍要求";
                    cell.mName.textColor = M_TCO2;
                }else{
                    cell.mName.text = _mplace;
                    cell.mName.textColor = M_TCO;
                }
            }
            
            break;
        case 2:
            
            cell.mImg.image = [UIImage imageNamed:@"s_fwsd"];
            if (_mfwsd.length == 0) {
                cell.mName.text = @"请选择服务时段";
                cell.mName.textColor = M_TCO2;
            }else{
                cell.mName.text = _mfwsd;
                cell.mName.textColor = M_TCO;
            }
            
            
            break;
        case 3:
            
            cell.mImg.image = [UIImage imageNamed:@"s_fwsc"];
            if (_mfwsc.length == 0) {
                cell.mName.text = @"请选择服务时长";
                cell.mName.textColor = M_TCO2;
            }else{
                cell.mName.text = _mfwsc;
                cell.mName.textColor = M_TCO;
            }
            
            
            
            break;
        case 4:
            
            cell.mImg.image = [UIImage imageNamed:@"s_fwrs"];
            if (_mfwnum.length == 0) {
                cell.mName.text = @"请选择服务人数";
                cell.mName.textColor = M_TCO2;
            }else{
                cell.mName.text = _mfwnum;
                cell.mName.textColor = M_TCO;
            }
            
            break;
        case 5:
            cell.mImg.image = [UIImage imageNamed:@"s_huji"];
            if (_mplace.length == 0) {
                cell.mName.text = @"请选择户籍要求";
                cell.mName.textColor = M_TCO2;
            }else{
                cell.mName.text = _mplace;
                cell.mName.textColor = M_TCO;
            }
            
            break;
        
        default:
            break;
    }

       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    _selectindex = (int)indexPath.row;
    
    switch (indexPath.row) {
        case 0:
        {
            if (_mType == YUESAO || _mType == XIAOSHIGONG) {
                [self.view addSubview:_mbombbox.view];
                
                [_mbombbox initCalendarPickView:^(NSInteger day, NSInteger month, NSInteger year) {
                    
                    _myctime = [NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
                    
                    [_mbombbox closeCalendarPickView];
                    
                    [_mTableView reloadData];
                }];

            }else{
            
                ChoseAddressVC *ca = [[ChoseAddressVC alloc] initWithNibName:@"ChoseAddressVC" bundle:nil];
                ca.itblock = ^(NSString *address,NSString *provice,NSString *city,NSString *area){
                    
                    _province = provice;
                    _city = city;
                    _area = area;
                    _mdetailaddress = address;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",provice,city,area,address];
                    
                    [_mTableView reloadData];
                };
                [self.navigationController pushViewController:ca animated:YES];
            }
            
        }
            
            break;
        case 1:
        {
            if (_mType == YUESAO) {
                ChoseAddressVC *ca = [[ChoseAddressVC alloc] initWithNibName:@"ChoseAddressVC" bundle:nil];
                ca.itblock = ^(NSString *address,NSString *provice,NSString *city,NSString *area){
                    
                    _province = provice;
                    _city = city;
                    _area = area;
                    _mdetailaddress = address;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",provice,city,area,address];
                    
                    [_mTableView reloadData];
                };
                [self.navigationController pushViewController:ca animated:YES];
            }else if(_mType == XIAOSHIGONG){
                ChoseAddressVC *ca = [[ChoseAddressVC alloc] initWithNibName:@"ChoseAddressVC" bundle:nil];
                ca.itblock = ^(NSString *address,NSString *provice,NSString *city,NSString *area){
                    
                    _province = provice;
                    _city = city;
                    _area = area;
                    _mdetailaddress = address;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",provice,city,area,address];
                    
                    [_mTableView reloadData];
                };
                [self.navigationController pushViewController:ca animated:YES];
                
            }else{
            
                ChosePlaceVC *cp = [[ChosePlaceVC alloc] initWithNibName:@"ChosePlaceVC" bundle:nil];
                cp.itblock = ^(NSString *string){
                   
                    _mplace = [string substringToIndex:([string length]-1)];
                    [_mTableView reloadData];
                };
                [self pushViewController:cp];
            }
        }
            break;
        case 2:
        {
            [_mbombbox2 initTimeIntervalView:self.view title:@"请选择服务时段" index:_backindex1 Array:_fwsdarray];
           
        }
            break;
            
        case 3:
        {
            [_mbombbox2 initTimeIntervalView:self.view title:@"请选择服务时长" index:_backindex2 Array:_fwscarray];
            
            
        }
            break;
        case 4:
        {
            [_mbombbox2 initTimeIntervalView:self.view title:@"请选择服务人数" index:_backindex3 Array:_fwrsarray];
            
        }
            break;
        case 5:
        {
            ChosePlaceVC *cp = [[ChosePlaceVC alloc] initWithNibName:@"ChosePlaceVC" bundle:nil];
            cp.itblock = ^(NSString *string){
                
                _mplace = _mplace = [string substringToIndex:([string length]-1)];
                [_mTableView reloadData];
            };
            [self pushViewController:cp];
        }
            break;
        default:
            break;
    }
}

#pragma ParentalServiceDelegate
- (void)selectString:(NSString *)string index:(int)index{

    
    NSLog(@"=====%@",string);
    
    switch (_selectindex) {
        case 2:
            _mfwsd = string;
            _backindex1 = index;
            break;
        case 3:
            _mfwsc = string;
            _backindex2 = index;
            break;
        case 4:
            _mfwnum = string;
            _backindex3 = index;
            break;
            
        default:
            break;
    }
    
    [_mTableView reloadData];
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

//选择年龄
- (IBAction)mAgeClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;
    if (_mitembt1) {
        [_mitembt1 setBackgroundImage:[UIImage imageNamed:@"s_bt"] forState:UIControlStateNormal];
    }
    [bt setBackgroundImage:[UIImage imageNamed:@"s_bt_select"] forState:UIControlStateNormal];
    _mitembt1 = bt;
}

//提交
- (IBAction)mSumitClick:(id)sender {
    
    
    if ([SUser isNeedLogin]) {
        
        [self gotoLogin];
        
        return;
    }
    
    
    ReAuntVC *rea = [[ReAuntVC alloc] initWithNibName:@"ReAuntVC" bundle:nil];
    rea.mDate = [Util getTimeString:[Util getDataString:_myctime bfull:YES] bfull:YES];
    rea.mDetailAddress = _mdetailaddress;
    rea.mRemark = _mRemark.text;
    
    switch (_mType) {
            
        case YUESAO:
            rea.mType = @"月嫂";
            break;
        case YUERSAO:
            rea.mType = @"育儿嫂";
            break;
        case BUZHUJIABAOMU:
            rea.mType = @"不住家保姆";
            break;
        case ZHUJIABAOMU:
            rea.mType = @"住家保姆";
            break;
        case LAORENPEIHU:
            rea.mType = @"陪护";
            break;
        case XIAOSHIGONG:
            rea.mType = @"小时工";
            break;
            
        default:
            break;
    }


    if (_mitembt1) {
        switch ((int)_mitembt1.tag) {
            case 10:
                _minage = 0;
                _maxage = 100;
                break;
            case 11:
                _minage = 0;
                _maxage = 35;
                break;
            case 12:
                _minage = 35;
                _maxage = 48;
                break;
            case 13:
                _minage = 48;
                _maxage = 100;
                break;
                
            default:
                break;
        }
    }
    
    if (_maddress.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务地点"];
        return;
    }
    
    switch (_mType) {
            
        case YUESAO:{
        
            if (_myctime.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务时间"];
                return;
            }
            
            if (!_mitembt2) {
                [SVProgressHUD showErrorWithStatus:@"请选择证书要求"];
                
                return;
            }
            
            NSString *iszhengshu = @"";
            switch ((int)_mitembt2.tag) {
                case 10:
                    iszhengshu = @"有";
                    break;
                case 11:
                    iszhengshu = @"无";
                    break;
                    
                default:
                    break;
            }
            
            [self showStatu:@"操作中.."];
            [SAuntInfo findMatron:0 work_province:_province work_city:_city work_area:_area have_auth:iszhengshu block:^(SResBase *retobj, NSArray *arr) {
                
                if (retobj.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    _auntarr = arr;
        
                    rea.mTempArray = (NSMutableArray *)_auntarr;
                    
                    
                    [self.navigationController pushViewController:rea animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                }
            }];

        }
            
            break;
        case YUERSAO:{
            
            if (!_mitembt1) {
                [SVProgressHUD showErrorWithStatus:@"请选择育儿嫂年龄"];
                
                return;
            }
            
            if (!_mitembt2) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务类型"];
                
                return;
            }
            
            NSString *type = @"";
            switch ((int)_mitembt2.tag) {
                case 10:
                    type = @"住家";
                    break;
                case 11:
                    type = @"白班";
                    break;
                    
                default:
                    break;
            }
            
            [self showStatu:@"操作中.."];
            [SAuntInfo findChildCare:0 work_province:_province work_city:_city work_area:_area min_age:_minage max_age:_maxage over_night:type prio_province:_mplace block:^(SResBase *retobj, NSArray *arr) {
               
                if (retobj.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    _auntarr = arr;
                    
                    rea.mTempArray = (NSMutableArray *)_auntarr;
                    [self.navigationController pushViewController:rea animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                    return;
                }
            }];

            
        }
            
            break;
        case BUZHUJIABAOMU:case ZHUJIABAOMU:
        {
        
            if (!_mitembt1) {
                [SVProgressHUD showErrorWithStatus:@"请选择保姆年龄"];
                
                return;
            }
            
            NSString *iszhujia = @"白班";
            if(_mType == ZHUJIABAOMU)
                iszhujia = @"住家";
            [self showStatu:@"操作中.."];
            [SAuntInfo findNurse:0 work_province:_province work_city:_city work_area:_area min_age:_minage max_age:_maxage over_night:iszhujia prio_province:_mplace block:^(SResBase *retobj, NSArray *arr) {
                
                if (retobj.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    _auntarr = arr;

                    rea.mTempArray = (NSMutableArray *)_auntarr;
                    [self.navigationController pushViewController:rea animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                    return;
                }
            }];
            
            
        }
            break;
            
        case LAORENPEIHU:
        {
            if (!_mitembt1) {
                [SVProgressHUD showErrorWithStatus:@"请选择护工年龄"];
                
                return;
            }
            if (!_mitembt2) {
                [SVProgressHUD showErrorWithStatus:@"请选择护工性别"];
                
                return;
            }
            if (!_mitembt3) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务类型"];
                
                return;
            }
            if (!_mitembt4) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务对象"];
                
                return;
            }
            
            NSString *sex = @"";
            NSString *time = @"";
            NSString *object = @"";
            if((int)_mitembt2.tag == 10){
                sex = @"男";
            }else{
                sex = @"女";
            }
            
            if((int)_mitembt3.tag == 10){
                time = @"住家";
            }else{
                time = @"白班";
            }

            
            if((int)_mitembt4.tag == 10){
                object = @"老人";
            }else{
                object = @"病人";
            }

            [self showStatu:@"操作中.."];
            [SAuntInfo findAccompany:0 work_province:_province work_city:_city work_area:_area min_age:_minage max_age:_maxage over_night:time sex:sex care_type:object block:^(SResBase *retobj, NSArray *arr) {
                
                if (retobj.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    _auntarr = arr;

                    rea.mTempArray = (NSMutableArray *)_auntarr;
                    [self.navigationController pushViewController:rea animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                    return;
                }

            }];
            
        }
            break;
        case XIAOSHIGONG:{
        
            
            if (_mfwsd.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务时段"];
                return;
            }
            
            if (_mfwsc.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务时长"];
                return;
            }
            
            if (_mfwnum.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务人数"];
                return;
            }
            
            int num = [[_mfwnum stringByReplacingOccurrencesOfString:@"人" withString:@""] intValue];
            
            
            [self showStatu:@"操作中.."];

            [SAuntInfo findHourWorker:0 work_province:_province work_city:_city work_area:_area count:num service_address:_mdetailaddress additional:_mRemark.text service_time:_mfwsd service_duration:_mfwsc prio_province:_mplace block:^(SResBase *retobj, SOrder *order) {
                
                if (retobj.msuccess) {
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
    
                    HourWorkPayVC *hpay = [[HourWorkPayVC alloc] initWithNibName:@"HourWorkPayVC" bundle:nil];
                    hpay.mAddr = _maddress;

                    hpay.mServiceTime = [NSString stringWithFormat:@"%@ %@",_myctime,_mfwsd];
                    hpay.mOrder = order;
                    [self pushViewController:hpay];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                    return;
                }
            }];
            
        }
            
            break;
            
        case FEIYONG:
            
            break;
            
        default:
            break;
    }
    
}


- (IBAction)mItemClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;
    
    if (_mitembt2) {
        [_mitembt2 setBackgroundImage:[UIImage imageNamed:@"s_bt"] forState:UIControlStateNormal];
    }
    [bt setBackgroundImage:[UIImage imageNamed:@"s_bt_select"] forState:UIControlStateNormal];
    _mitembt2 = bt;


}

- (IBAction)mItemTwoClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;
    
    if (_mitembt3) {
        [_mitembt3 setBackgroundImage:[UIImage imageNamed:@"s_bt"] forState:UIControlStateNormal];
    }
    [bt setBackgroundImage:[UIImage imageNamed:@"s_bt_select"] forState:UIControlStateNormal];
    _mitembt3 = bt;
    
    
}

- (IBAction)mItemThreeClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;
    
    if (_mitembt4) {
        [_mitembt4 setBackgroundImage:[UIImage imageNamed:@"s_bt"] forState:UIControlStateNormal];
    }
    [bt setBackgroundImage:[UIImage imageNamed:@"s_bt_select"] forState:UIControlStateNormal];
    _mitembt4 = bt;
}
@end
