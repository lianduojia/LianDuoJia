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

@interface ParentalServiceVC ()<UITableViewDataSource,UITableViewDelegate>{

    BombBoxVC *_mbombbox;
    BombBoxVC *_mbombbox2;
    NSString *_myctime; //预产期时间/服务时间
    NSString *_maddress;//服务地点
    NSString *_mfwsd;//服务时段
    NSString *_mfwsc;//服务时长
    NSString *_mfwnum;//服务人数
    NSString *_mfwpl;//服务频率
    
    UIButton *_mitembt1;
    UIButton *_mitembt2;
    UIButton *_mitembt3;
    UIButton *_mitembt4;
    
    int       _selectindex;
    int       _backindex1;
    int       _backindex2;
    int       _backindex3;
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
    _backindex1 = 100;
    _backindex2 = 100;
    _backindex3 = 100;
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
    
    _mRemarklb.text = @"您对保姆籍贯 做菜口味等方面的要求";
    
    _mHeadImg.image = [UIImage imageNamed:@"banner_baomu"];
}

//陪护
- (void)loadPeihu{
    
    self.navTitle = @"找陪护";
    _mTableViewHeight.constant = 60*2+1;
    
    _mAgelb.text = @"请选择护工年龄";
    
    _mTimelb.text = @"请选择护工性别";
    [_mHome setTitle:@"男" forState:UIControlStateNormal];
    [_mDay setTitle:@"女" forState:UIControlStateNormal];
    
    _mRemarklb.text = @"您对护工籍贯 做菜口味等方面的要求";
    
    _mHeadImg.image = [UIImage imageNamed:@"banner_peihu"];
    
}

//小时工
- (void)loadXiaoshigong{

    if(_mType == XIAOSHIGONG){
        self.navTitle = @"找小时工";
        _mTableViewHeight.constant = 60*5+1;
        
    }else{
        self.navTitle = @"找长期小时工";
        _mTableViewHeight.constant = 60*6+1;
    }
    
    _mProcessHeight.constant = 115;
    _mImg2.image = [UIImage imageNamed:@"s_zfzjf"];
    _mLab2.text = @"支付中介费";
    _mImg3.image = [UIImage imageNamed:@"s_pjay"];
    _mLab3.text = @"评价阿姨";
    
    _mAgeHeight.constant = 0;
    _mTimeHeight.constant = 0;
    _mItemTwoHeight.constant = 0;
    _mItemThreeHeight.constant = 0;
    _mRemarklb.text = @"您对小时工籍贯 做菜口味等方面的要求";
    
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
        case YUESAO:case YUERSAO:case BUZHUJIABAOMU: case ZHUJIABAOMU:case LAORENPEIHU:
            return 2;
            break;

        case XIAOSHIGONG:
            return 5;
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
            cell.mImg.image = [UIImage imageNamed:@"s_time"];
            if (_myctime.length == 0) {
                
                if (_mType == YUESAO)
                     cell.mName.text = @"请选择预产期时间";
                else
                    cell.mName.text = @"请选择服务时间";
            }else{
                cell.mName.text = _myctime;
            }
            
            break;
        case 1:
            cell.mImg.image = [UIImage imageNamed:@"s_address"];
            if (_maddress.length == 0) {
                cell.mName.text = @"请选择服务地点";
            }else{
                cell.mName.text = _maddress;
            }
            
            break;
        case 2:
            cell.mImg.image = [UIImage imageNamed:@"s_fwsd"];
            if (_mfwsd.length == 0) {
                cell.mName.text = @"请选择服务时段";
            }else{
                cell.mName.text = _mfwsd;
            }
            
            break;
        case 3:
            cell.mImg.image = [UIImage imageNamed:@"s_fwsc"];
            if (_mfwsc.length == 0) {
                cell.mName.text = @"请选择服务时长";
            }else{
                cell.mName.text = _mfwsc;
            }
            
            break;
        case 4:
            cell.mImg.image = [UIImage imageNamed:@"s_fwrs"];
            if (_mfwnum.length == 0) {
                cell.mName.text = @"请选择服务人数";
            }else{
                cell.mName.text = _mfwnum;
            }
            
            break;
        case 5:
            cell.mImg.image = [UIImage imageNamed:@"s_fwpl"];
            if (_mfwpl.length == 0) {
                cell.mName.text = @"请选择服务频率";
            }else{
                cell.mName.text = _mfwpl;
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
            [self.view addSubview:_mbombbox.view];
            
            [_mbombbox initCalendarPickView:^(NSInteger day, NSInteger month, NSInteger year) {
                
                _myctime = [NSString stringWithFormat:@"%ld年%ld月%ld日",year,month,day];
                
                [_mbombbox closeCalendarPickView];
                
                [_mTableView reloadData];
            }];
        }
            
            break;
        case 1:
        {
            ChoseAddressVC *ca = [[ChoseAddressVC alloc] initWithNibName:@"ChoseAddressVC" bundle:nil];
            ca.itblock = ^(NSString *address){
                
                _maddress = address;
                
                [_mTableView reloadData];
            };
            [self.navigationController pushViewController:ca animated:YES];
        }
            break;
        case 2:
        {
            [_mbombbox2 initTimeIntervalView:self.view title:@"请选择服务时段" index:_backindex1 Array:[[NSArray alloc] initWithObjects:@"上午", @"下午",nil]];
        }
            break;
            
        case 3:
        {
            
            [_mbombbox2 initTimeIntervalView:self.view title:@"请选择服务时长" index:_backindex2 Array:[[NSArray alloc] initWithObjects:@"1小时", @"2小时",@"3小时",@"4小时",@"5小时",@"6小时",@"7小时",@"8小时",nil]];
        }
            break;
        case 4:
        {
            
            [_mbombbox2 initTimeIntervalView:self.view title:@"请选择服务人数" index:_backindex3 Array:[[NSArray alloc] initWithObjects:@"1人", @"2人",@"3人",@"4人",@"5人",@"6人",@"7人",@"8人",@"9人",@"10人",nil]];
        }
            break;
        case 5:
        {
            
            [_mbombbox2 initTimeIntervalView:self.view title:@"请选择服务频率" index:0 Array:[[NSArray alloc] initWithObjects:@"周一", @"周二",@"周三",@"周四",@"周五",@"周六",@"周日",nil]];
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
        case 5:
            _mfwpl = string;
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
    
    ReAuntVC *rea = [[ReAuntVC alloc] initWithNibName:@"ReAuntVC" bundle:nil];
    [self.navigationController pushViewController:rea animated:YES];
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
