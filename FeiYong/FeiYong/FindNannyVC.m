//
//  FindNannyVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/8/12.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "FindNannyVC.h"
#import "ChoseAddressVC.h"
#import "BombBoxVC.h"
#import "ChosePlaceVC.h"
#import "YLPickerView.h"
#import "YLDatePickerView.h"
#import "ReAuntVC.h"
#import "Util.h"
#import "RemarkVC.h"
#import "OhterNeedCell.h"
#import "HourWorkPayVC.h"

@interface FindNannyVC ()<UITableViewDelegate,UITableViewDataSource>{
    
    YLPickerView *_picker;
    YLDatePickerView *_datepicker;
    BOOL _show;

    NSString *_maddress;//服务地点
    NSString *_mdetailaddress;//详细地址（门牌号）
   
    NSString *_mfwsc;//服务时长
    NSString *_mfwnum;//服务人数
    
    NSString *_mplace;//户籍
    int _mstar; //星级
    
    NSString *_province;
    NSString *_city;
    NSString *_area;

    //最大 最小年龄
    int  _minage;
    int  _maxage;
    
    NSArray *_auntarr;
    
    UIButton *_item1;  //性别
    UIButton *_item2;   //白班夜班
    UIButton *_item3;   //照顾类型
    
    int _indexage;
    int _indexstar;
    int _indextimelength;
    int _indexhour;
    int _indexnum;
    
    NSMutableArray *_selectothers;
}

@end

@implementation FindNannyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _minage = 0;
    _maxage = 100;
    
    [self loadMyView];
    
    [self loadMyData];
    
    [self.navBar.mRightButton setImage:[UIImage imageNamed:@"kefu"] forState:UIControlStateNormal];
    
    UINib *nib = [UINib nibWithNibName:@"OhterNeedCell" bundle:nil];
    [_mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    _mTableView.tableFooterView = UIView.new;
}

- (void)rightBtnTouched:(id)sender{
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"057912312"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
    
}


- (void)loadMyView{
    
    _mGroupHeight.constant = 0;
    
    _mRemark.layer.masksToBounds = YES;
    _mRemark.layer.cornerRadius = 3;
    
    _mAddress.layer.masksToBounds = YES;
    _mAddress.layer.cornerRadius = 2;
    _mAddress.layer.borderWidth = 1;
    _mAddress.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    _mHuji.layer.masksToBounds = YES;
    _mHuji.layer.cornerRadius = 2;
    _mHuji.layer.borderWidth = 1;
    _mHuji.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    _mAge.layer.masksToBounds = YES;
    _mAge.layer.cornerRadius = 2;
    _mAge.layer.borderWidth = 1;
    _mAge.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    _mTime.layer.masksToBounds = YES;
    _mTime.layer.cornerRadius = 2;
    _mTime.layer.borderWidth = 1;
    _mTime.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    _mTimeLength.layer.masksToBounds = YES;
    _mTimeLength.layer.cornerRadius = 2;
    _mTimeLength.layer.borderWidth = 1;
    _mTimeLength.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    [self setTextFieldLeftPadding:_mAddress forWidth:16];
    [self setTextFieldLeftPadding:_mHuji forWidth:16];
    [self setTextFieldLeftPadding:_mAge forWidth:16];
    
    [self setTextFieldLeftPadding:_mTime forWidth:16];
    [self setTextFieldLeftPadding:_mTimeLength forWidth:16];
    
    
    _item1 = _mItem1;
    _item2 = _mItem2;
    _item3 = _mItem3;
    
    
    _mHourBT.layer.masksToBounds = YES;
    _mHourBT.layer.cornerRadius = 2;
    _mHourBT.layer.borderWidth = 1;
    _mHourBT.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    _mNumBT.layer.masksToBounds = YES;
    _mNumBT.layer.cornerRadius = 2;
    _mNumBT.layer.borderWidth = 1;
    _mNumBT.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    
    UIImage * img= [UIImage imageNamed:@"a_qipao1"];
    img = [img resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3) resizingMode:UIImageResizingModeStretch];
    _mQipao.image = img;
    [_mSlider setMaximumTrackImage:[UIImage imageNamed:@"f_slider_right"] forState:UIControlStateNormal];
    [_mSlider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];

}


- (void)sliderChange:(id) sender {
    if ([sender isKindOfClass:[UISlider class]]) {
        UISlider * slider = sender;
        CGFloat value = slider.value;
        
        switch (_mType) {
                
            case BUZHUJIABAOMU:
            case ZHUJIABAOMU:
                if (value < 1) {
                    _mStar.text = @"不限";
                    _mStarDetail.text = @"在所有阿姨中为您挑选推荐";
                    _mstar = 0;
                    return;
                }
                
                if (value >= 1 && value < 2) {
                    _mStar.text = @"1星保姆";
                    _mStarDetail.text = @"具备基础家庭工作技能";
                    _mstar = 1;
                    return;
                }
                
                if (value >= 2 && value < 3) {
                    _mStar.text = @"2星保姆";
                    _mStarDetail.text = @"有多个家庭工作经验，具备烹饪、熨烫等家政技能";
                    _mstar = 2;
                    return;
                }
                
                if (value >= 3 && value < 4) {
                    _mStar.text = @"3星保姆";
                    _mStarDetail.text = @"工作经验丰富，懂得各种菜系基本制法，具备所有家政技能";
                    _mstar = 3;
                    return;
                }
                
                if (value >= 4 && value < 5) {
                    _mStar.text = @"4星保姆";
                    _mStarDetail.text = @"工作经验丰富，可适应特殊环境家庭";
                    _mstar = 4;
                    return;
                }
                
                if (value == 5) {
                    _mStar.text = @"5星保姆";
                    _mStarDetail.text = @"技能全面，家政方面独当一面";
                    _mstar = 5;
                    return;
                }
                
                break;
                
            case YUESAO:
                if (value < 1) {
                    _mStar.text = @"不限";
                    _mStarDetail.text = @"在所有阿姨中为您挑选推荐";
                    _mstar = 0;
                    return;
                }
                
                if (value >= 1 && value < 2) {
                    _mStar.text = @"1星月嫂";
                    _mStarDetail.text = @"看管过至少6名以上婴儿，无差错";
                    _mstar = 1;
                    return;
                }
                
                if (value >= 2 && value < 3) {
                    _mStar.text = @"2星月嫂";
                    _mStarDetail.text = @"具备中级育婴师资格，拥有专业的护理技能拥";
                    _mstar = 2;
                    return;
                }
                
                if (value >= 3 && value < 4) {
                    _mStar.text = @"3星月嫂";
                    _mStarDetail.text = @"有专业的护理技能，会按摩，掌握营养知识";
                    _mstar = 3;
                    return;
                }
                
                if (value >= 4 && value < 5) {
                    _mStar.text = @"4星月嫂";
                    _mStarDetail.text = @"拥有专业的护理技能，可照顾特殊情况孕妇";
                    _mstar = 4;
                    return;
                }
                
                if (value == 5) {
                    _mStar.text = @"5星月嫂";
                    _mStarDetail.text = @"带过三十个以上婴儿，技能全面";
                    _mstar = 5;
                    return;
                }
                
                break;
                //一星	具备基础护理工作技能
                //二星	有多个护理工作经验，善于把握被照顾人特点
                //三星	具备护理学知识，工作经验丰富
                //四星	懂得专业的护理技能，工作经验丰富
                //五星	技能全面，工作经验丰富
            case PEIHU:
                if (value < 1) {
                    _mStar.text = @"不限";
                    _mStarDetail.text = @"在所有阿姨中为您挑选推荐";
                    _mstar = 0;
                    return;
                }
                
                if (value >= 1 && value < 2) {
                    _mStar.text = @"1星护工";
                    _mStarDetail.text = @"具备基础护理工作技能";
                    _mstar = 1;
                    return;
                }
                
                if (value >= 2 && value < 3) {
                    _mStar.text = @"2星护工";
                    _mStarDetail.text = @"有多个护理工作经验，善于把握被照顾人特点";
                    _mstar = 2;
                    return;
                }
                
                if (value >= 3 && value < 4) {
                    _mStar.text = @"3星护工";
                    _mStarDetail.text = @"具备护理学知识，工作经验丰富";
                    _mstar = 3;
                    return;
                }
                
                if (value >= 4 && value < 5) {
                    _mStar.text = @"4星护工";
                    _mStarDetail.text = @"懂得专业的护理技能，工作经验丰富";
                    _mstar = 4;
                    return;
                }
                
                if (value == 5) {
                    _mStar.text = @"5星护工";
                    _mStarDetail.text = @"技能全面，工作经验丰富";
                    _mstar = 5;
                    return;
                }
                break;
                
            case XIAOSHIGONG:
                
                break;
            case JUJIAYANFLAO:
                
                break;
            case YANGSHENGYANGLAO:
                
                break;
                
            case FEIYONG:
                
                break;
                
            default:
                break;
        }

    }
}


//- (CGRect)maximumValueImageRectForBounds:(CGRect)bounds
//- (CGRect)minimumValueImageRectForBounds:(CGRect)bounds{
//    - (CGRect)trackRectForBounds:(CGRect)bounds
//    - (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rectvalue:(float)value

- (void)loadMyData{
    
    switch (_mType) {
            
            
        case BUZHUJIABAOMU:{
        
            self.navTitle = @"找不住家保姆";
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            NSDictionary *dic = [def objectForKey:@"bminfo"];
            if (dic) {
                _maddress = [dic objectForKey:@"address"];
                _province = [dic objectForKey:@"province"];
                _city = [dic objectForKey:@"city"];
                _area = [dic objectForKey:@"area"];
                _mAddress.text = _maddress;
                _mdetailaddress = [dic objectForKey:@"detailaddress"];
                _mplace = [dic objectForKey:@"place"];
                _mHuji.text = _mplace;
                _mAge.text = [dic objectForKey:@"age"];
                
                if ([dic objectForKey:@"remark"]) {
                    _mRemark.text = [dic objectForKey:@"remark"];
                    _mPholder.text = @"";
                }
                
                _mstar = [[dic objectForKey:@"star"] intValue];
                
            }else{
                
                if([SAppInfo shareClient].mAddress.length>0){
                    
                    _province = [SAppInfo shareClient].mProvince;
                    _city = [SAppInfo shareClient].mCity;
                    _area = [SAppInfo shareClient].mArea;
                    _mdetailaddress = [SAppInfo shareClient].mAddress;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",_province,_city,_area,_mdetailaddress];
                    
                    _mAddress.text = _maddress;
                    _mstar = 0;
                    
                }
                //        _mHuji.text = @"不限";
                //        _mAge.text = @"不限";
            }
            
        }
            
            break;
        case ZHUJIABAOMU:{
            self.navTitle = @"找住家保姆";
            
            _mBanner.image = [UIImage imageNamed:@"banner_baomu_ye"];
            
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            NSDictionary *dic = [def objectForKey:@"bminfo"];
            if (dic) {
                _maddress = [dic objectForKey:@"address"];
                _province = [dic objectForKey:@"province"];
                _city = [dic objectForKey:@"city"];
                _area = [dic objectForKey:@"area"];
                _mAddress.text = _maddress;
                _mdetailaddress = [dic objectForKey:@"detailaddress"];
                _mplace = [dic objectForKey:@"place"];
                _mHuji.text = _mplace;
                _mAge.text = [dic objectForKey:@"age"];
                if ([dic objectForKey:@"remark"]) {
                    _mRemark.text = [dic objectForKey:@"remark"];
                    _mPholder.text = @"";
                }
                _mstar = [[dic objectForKey:@"star"] intValue];
                
            }else{
                if([SAppInfo shareClient].mAddress.length>0){
                    
                    _province = [SAppInfo shareClient].mProvince;
                    _city = [SAppInfo shareClient].mCity;
                    _area = [SAppInfo shareClient].mArea;
                    _mdetailaddress = [SAppInfo shareClient].mAddress;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",_province,_city,_area,_mdetailaddress];
                    
                    _mAddress.text = _maddress;
                    _mstar = 0;
                    
                }
                //        _mHuji.text = @"不限";
                //        _mAge.text = @"不限";
            }

            
        }
            break;
            
        case YUESAO:{
            self.navTitle = @"找月嫂";
            
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            NSDictionary *dic = [def objectForKey:@"ysinfo"];
            if (dic) {
                _maddress = [dic objectForKey:@"address"];
                _province = [dic objectForKey:@"province"];
                _city = [dic objectForKey:@"city"];
                _area = [dic objectForKey:@"area"];
                _mAddress.text = _maddress;
                _mdetailaddress = [dic objectForKey:@"detailaddress"];
                _mTime.text = [dic objectForKey:@"time"];
                _mTimeLength.text = [dic objectForKey:@"timelength"];
                if ([dic objectForKey:@"remark"]) {
                    _mRemark.text = [dic objectForKey:@"remark"];
                    _mPholder.text = @"";
                }
                _mstar = [[dic objectForKey:@"star"] intValue];
                
            }else{
                if([SAppInfo shareClient].mAddress.length>0){
                    
                    _province = [SAppInfo shareClient].mProvince;
                    _city = [SAppInfo shareClient].mCity;
                    _area = [SAppInfo shareClient].mArea;
                    _mdetailaddress = [SAppInfo shareClient].mAddress;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",_province,_city,_area,_mdetailaddress];
                    
                    _mAddress.text = _maddress;
                     _mstar = 0;
                    
                }
            }

        }
            break;
        case PEIHU:
        {
            self.navTitle = @"找陪护";
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            NSDictionary *dic = [def objectForKey:@"hginfo"];
            if (dic) {
                _maddress = [dic objectForKey:@"address"];
                _province = [dic objectForKey:@"province"];
                _city = [dic objectForKey:@"city"];
                _area = [dic objectForKey:@"area"];
                _mAddress.text = _maddress;
                _mdetailaddress = [dic objectForKey:@"detailaddress"];
                
                if ([dic objectForKey:@"remark"]) {
                    _mRemark.text = [dic objectForKey:@"remark"];
                    _mPholder.text = @"";
                }
                _mstar = [[dic objectForKey:@"star"] intValue];
                
            }else{
                if([SAppInfo shareClient].mAddress.length>0){
                    
                    _province = [SAppInfo shareClient].mProvince;
                    _city = [SAppInfo shareClient].mCity;
                    _area = [SAppInfo shareClient].mArea;
                    _mdetailaddress = [SAppInfo shareClient].mAddress;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",_province,_city,_area,_mdetailaddress];
                    
                    _mAddress.text = _maddress;
                    _mstar = 0;
                    
                }
            }

        }
            break;
            
        case XIAOSHIGONG:
        {
            self.navTitle = @"找小时工";
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            NSDictionary *dic = [def objectForKey:@"hourinfo"];
            if (dic) {
                _maddress = [dic objectForKey:@"address"];
                _province = [dic objectForKey:@"province"];
                _city = [dic objectForKey:@"city"];
                _area = [dic objectForKey:@"area"];
                _mAddress.text = _maddress;
                _mdetailaddress = [dic objectForKey:@"detailaddress"];
                
                if ([dic objectForKey:@"remark"]) {
                    _mRemark.text = [dic objectForKey:@"remark"];
                    _mPholder.text = @"";
                }
                
                _indexnum = [[dic objectForKey:@"num"] intValue];
                _indexhour = [[dic objectForKey:@"hour"] intValue];
                
                _mfwsc = [NSString stringWithFormat:@"%d小时",_indexhour+1];
                _mfwnum = [NSString stringWithFormat:@"%d人",_indexnum+1];
                
                _mTime.text = [dic objectForKey:@"time"];
                
                [_mHourBT setTitle:_mfwsc forState:UIControlStateNormal];
                [_mNumBT setTitle:_mfwnum forState:UIControlStateNormal];
                
            }else{
                if([SAppInfo shareClient].mAddress.length>0){
                    
                    _province = [SAppInfo shareClient].mProvince;
                    _city = [SAppInfo shareClient].mCity;
                    _area = [SAppInfo shareClient].mArea;
                    _mdetailaddress = [SAppInfo shareClient].mAddress;
                    _maddress = [NSString stringWithFormat:@"%@%@%@%@",_province,_city,_area,_mdetailaddress];
                    
                    _mAddress.text = _maddress;
                }
                _mfwsc = @"1小时";
                _mfwnum = @"1人";
            }

            _mOtherHeight.constant = 0;
            
            
            self.tempArray = [NSMutableArray arrayWithObjects:@"开荒",@"擦玻璃",@"做饭",@"家电清洗",@"皮具护理",nil];
            _selectothers = [NSMutableArray arrayWithObjects:@(0),@(0),@(0),@(0),@(0),nil];
            _mTableView.delegate = self;
            _mTableView.dataSource = self;
            
            _mContentView.layer.masksToBounds = YES;
            _mContentView.layer.cornerRadius = 4;
            
            
        }
            
            break;
        case JUJIAYANFLAO:
            self.navTitle = @"找居家养老";
            break;
        case YANGSHENGYANGLAO:
            self.navTitle = @"找养生养老";
            break;
            
        case FEIYONG:
            self.navTitle = @"找菲佣";
            break;
            
        default:
            break;
    }

    
    _datepicker =  [[[NSBundle mainBundle]loadNibNamed:@"YLDatePickerView" owner:self options:nil]objectAtIndex:0];
    
    [_datepicker SetTextFieldDate:_mTime];
    
    [_datepicker setDatePickerType:UIDatePickerModeDateAndTime dateFormat:@"yyyy-MM-dd HH:mm"];
    
    _picker = [[YLPickerView alloc] initWithNibName:@"YLPickerView" bundle:nil];
    
    [_mSlider setValue:_mstar];
    [self sliderChange:_mSlider];
}

-(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tempArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OhterNeedCell *cell = (OhterNeedCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mLabel.text = [self.tempArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    OhterNeedCell *cell = (OhterNeedCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    int flag = [[_selectothers objectAtIndex:indexPath.row] intValue];
    flag = !flag;
    [_selectothers setObject:@(flag) atIndexedSubscript:indexPath.row];
    if (flag) {
        cell.mQuan.image = [UIImage imageNamed:@"f_quan_huan"];
    }else{
        cell.mQuan.image = [UIImage imageNamed:@"f_quan"];
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

//地址选择
- (IBAction)mAddressClick:(id)sender {
    
    ChoseAddressVC *ca = [[ChoseAddressVC alloc] initWithNibName:@"ChoseAddressVC" bundle:nil];
    ca.mProvince = _province;
    ca.mCity = _city;
    ca.mArea = _area;
    ca.mDetailAddress = _mdetailaddress;
    ca.itblock = ^(NSString *address,NSString *provice,NSString *city,NSString *area){
        
        _province = provice;
        _city = city;
        _area = area;
        _mdetailaddress = address;
        _maddress = [NSString stringWithFormat:@"%@%@%@%@",provice,city,area,address];
        
        _mAddress.text = _maddress;

    };
    [self.navigationController pushViewController:ca animated:YES];
}

//户籍选择
- (IBAction)mHujiClick:(id)sender {
    
    ChosePlaceVC *cp = [[ChosePlaceVC alloc] initWithNibName:@"ChosePlaceVC" bundle:nil];
    cp.itblock = ^(NSString *string){
        
        _mplace = [string substringToIndex:([string length]-1)];
        
        _mHuji.text = _mplace;
    };
    [self pushViewController:cp];
    
}

- (IBAction)mAgeClick:(id)sender {
    
    if (_show) {
        [_picker mCancelClick:nil];
        _show = NO;
    }else{
        //    年龄筛选更改为 不限，35岁以下，35-45,45-55岁，55岁以上
        _picker.mSelectRow = _indexage;
        _picker.mArray = [NSMutableArray arrayWithObjects:@"不限",@"35岁以下",@"35-45岁",@"45-55岁",@"55岁以上", nil];
        [_picker initView:self.view block:^(NSString *age,int row) {
            
            _mAge.text = age;
            _indexage = row;
        }];
        _show = YES;
    }
}

//对阿姨的其它要求
- (IBAction)mRemarkClick:(id)sender {
    
    RemarkVC *remark = [[RemarkVC alloc] initWithNibName:@"RemarkVC" bundle:nil];
    switch (_mType) {
            
        case BUZHUJIABAOMU:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"做饭好",@"做面食",@"会煲汤",@"会带小孩",@"会辅食",nil];
            break;
        case ZHUJIABAOMU:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"做饭好",@"做面食",@"会煲汤",@"会带小孩",@"会辅食",nil];
            break;
            
        case YUESAO:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"会通乳",@"会煲汤",@"会按摩",@"带双胞胎",@"带早产儿",nil];
            break;
        case PEIHU:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"会喂食喂药",@"会处理污物",@"会按摩推拿",nil];
            break;
            
        case XIAOSHIGONG:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"需做饭",@"做面食",@"需煲汤",@"接送小孩",nil];
            break;
        case JUJIAYANFLAO:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"做饭好",@"做面食",@"会煲汤",@"会带小孩",@"会辅食",nil];
            break;
        case YANGSHENGYANGLAO:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"做饭好",@"做面食",@"会煲汤",@"会带小孩",@"会辅食",nil];
            break;
            
        case FEIYONG:
            remark.mItemsArray = [NSArray arrayWithObjects:	@"老实",@"勤快",@"诚实",@"学历高",@"做饭好",@"做面食",@"会煲汤",@"会带小孩",@"会辅食",nil];
            break;
            
        default:
            break;
    }

    remark.mString = _mRemark.text;
    remark.itblock = ^(NSString *string){
    
        if (string.length>0) {
            _mPholder.text = @"";
        }else{
            _mPholder.text = @"您对阿姨的其它要求";
        }
        _mRemark.text = string;
    };
    
    [self pushViewController:remark];
    
}


//时间选择
- (IBAction)mTimeClick:(id)sender {
    
     [_datepicker showInView:self.view];
}

//时长选择
- (IBAction)mTimeLengthClick:(id)sender {
    
    if (_show) {
        [_picker mCancelClick:nil];
        _show = NO;
    }else{
        _picker.mSelectRow = _indextimelength;
        _picker.mArray = [NSMutableArray arrayWithObjects:@"26天",@"42天", nil];
        [_picker initView:self.view block:^(NSString *length,int row) {
            _indextimelength = row;
            _mTimeLength.text = length;
        }];
        _show = YES;
    }
}

//性别选择
- (IBAction)mSexClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    [_item1 setBackgroundImage:[UIImage imageNamed:@"f_kuan_hui"] forState:UIControlStateNormal];
    [_item1 setTitleColor:M_TCO3 forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"f_kuan_huan"] forState:UIControlStateNormal];
    [btn setTitleColor:M_TCO forState:UIControlStateNormal];
    _item1 = btn;
    
}

//白班 夜班选择
- (IBAction)mDayClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    [_item2 setBackgroundImage:[UIImage imageNamed:@"f_kuan_hui"] forState:UIControlStateNormal];
    [_item2 setTitleColor:M_TCO3 forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"f_kuan_huan"] forState:UIControlStateNormal];
    [btn setTitleColor:M_TCO forState:UIControlStateNormal];
    _item2 = btn;
}

//病人 老人选择
- (IBAction)mManClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    [_item3 setBackgroundImage:[UIImage imageNamed:@"f_kuan_hui"] forState:UIControlStateNormal];
    [_item3 setTitleColor:M_TCO3 forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"f_kuan_huan"] forState:UIControlStateNormal];
    [btn setTitleColor:M_TCO forState:UIControlStateNormal];
    _item3 = btn;
}

//小时工 时长选择
- (IBAction)mHourClick:(id)sender {
    
    if (_show) {
        [_picker mCancelClick:nil];
        _show = NO;
    }else{
        
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 12; i++) {
            [array addObject:[NSString stringWithFormat:@"%d小时",i+1]];
        }
        _picker.mSelectRow = _indexhour;
        _picker.mArray = array;
        [_picker initView:self.view block:^(NSString *hour,int row) {
            _indexhour = row;
            _mfwsc = hour;
            [_mHourBT setTitle:[NSString stringWithFormat:@"服务%@",hour] forState:UIControlStateNormal];
        }];
        _show = YES;
    }

}


//小时工服务人数选择
- (IBAction)mNumClick:(id)sender {
    if (_show) {
        [_picker mCancelClick:nil];
        _show = NO;
    }else{
        
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            [array addObject:[NSString stringWithFormat:@"%d人",i+1]];
        }
        _picker.mSelectRow = _indexnum;
        _picker.mArray = array;
        [_picker initView:self.view block:^(NSString *num,int row) {
            _indexnum = row;
            _mfwnum = num;
            [_mNumBT setTitle:[NSString stringWithFormat:@"需要%@",num] forState:UIControlStateNormal];
        }];
        _show = YES;
    }
}

- (IBAction)mCheckClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"f_quan_huan"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"f_quan"] forState:UIControlStateNormal];
    }
}


//提交需求
- (IBAction)mSubmitClick:(id)sender {
    
    
    
    if (_mAddress.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择服务地点"];
        
        return;
    }


    if([_mAge.text isEqualToString:@"不限"]){
        _minage = 0;
        _maxage = 100;
    }
    
    if([_mAge.text isEqualToString:@"35岁以下"]){
        _minage = 0;
        _maxage = 35;
    }
    
    
    if([_mAge.text isEqualToString:@"35-45岁"]){
        _minage = 35;
        _maxage = 45;
    }
    
    if([_mAge.text isEqualToString:@"45-55岁"]){
        _minage = 45;
        _maxage = 55;
    }
    
    if([_mAge.text isEqualToString:@"55岁以上"]){
        _minage = 55;
        _maxage = 100;
    }
    
    ReAuntVC *rea = [[ReAuntVC alloc] initWithNibName:@"ReAuntVC" bundle:nil];
    
    rea.mAddress = _maddress;
    rea.mRemark = _mRemark.text;
    switch (_mType) {
            
        case BUZHUJIABAOMU:
        case ZHUJIABAOMU:
            rea.mType = @"保姆";
            break;
            
        case YUESAO:
            rea.mType = @"月嫂";
            break;
        case PEIHU:
            rea.mType = @"陪护";
            break;
            
        case XIAOSHIGONG:
            rea.mType = @"小时工";
            break;
        case JUJIAYANFLAO:
            rea.mType = @"居家养老";
            break;
        case YANGSHENGYANGLAO:
            rea.mType = @"养生养老";
            break;
            
        case FEIYONG:
            rea.mType = @"菲佣";
            break;
            
        default:
            break;
    }

    switch (_mType) {
            
        case BUZHUJIABAOMU:
        case ZHUJIABAOMU:
        {
            if (_mStar.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择保姆星级"];
                
                return;
            }
            
            
            if (_mHuji.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择户籍要求"];
                
                return;
            }
            if (_mAge.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择保姆年龄"];
                
                return;
            }
            
            NSString *iszhujia = @"白班";
            if(_mType == ZHUJIABAOMU)
                iszhujia = @"住家";
            
            [self showStatu:@"操作中.."];
            [SAuntInfo findNurse:0 work_province:_province work_city:_city work_area:_area min_age:_minage max_age:_maxage over_night:iszhujia prio_province:_mplace star:_mstar block:^(SResBase *retobj, NSArray *arr) {
                
                if (retobj.msuccess) {
                    
                    [self saveInfo];
                    
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    _auntarr = arr;
                    
                    rea.mOverNight = iszhujia;
                    rea.mTempArray = (NSMutableArray *)_auntarr;
                    [self.navigationController pushViewController:rea animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                    return;
                }
            }];
            
        }
            
            
            break;
            
        case YUESAO:{
            
            if (_mStar.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择保姆星级"];
                
                return;
            }
            
            
            if (_mTime.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择预产期时间"];
                
                return;
            }
            if (_mTimeLength.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择服务时长"];
                
                return;
            }
            
            [self showStatu:@"操作中.."];
            [SAuntInfo findMatron:0 work_province:_province work_city:_city work_area:_area have_auth:@"" star:_mstar block:^(SResBase *retobj, NSArray *arr) {
                
                if (retobj.msuccess) {
                    
                    [self saveYueSaoInfo];
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    _auntarr = arr;
                    
                    rea.mTempArray = (NSMutableArray *)_auntarr;
                    rea.mServiceTime = _mTime.text;
                    rea.mServiceDuration = _mTimeLength.text;
                    
                    
                    [self.navigationController pushViewController:rea animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                }
            }];

        }
            
            break;
        case PEIHU:
        {
            if (_mStar.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请选择保姆星级"];
                
                return;
            }
            
            NSString *sex = @"";
            NSString *day = @"";
            NSString *type = @"";
            
            if (_item1.tag == 10) {
                sex = @"不限";
            }else if (_item1.tag == 11){
                sex = @"男";
            }else{
                sex = @"女";
            }
            
            if(_item2.tag == 10){
                day = @"白班";
            }else{
                day = @"住家";
            }
            
            if (_item3.tag == 10) {
                type = @"老人";
            }else{
                type = @"病人";
            }
            
            [self showStatu:@"操作中.."];
            [SAuntInfo findAccompany:0 work_province:_province work_city:_city work_area:_area over_night:day sex:sex care_type:type star:_mstar block:^(SResBase *retobj, NSArray *arr) {
               
                if (retobj.msuccess) {
                    
                    [self saveHuGongInfo];
                    
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    _auntarr = arr;
                    
                    rea.mTempArray = (NSMutableArray *)_auntarr;
                    rea.mOverNight = day;
                    rea.mCareType = type;
                    [self.navigationController pushViewController:rea animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                    return;
                }

            }];

        }
            
        break;
            
        case XIAOSHIGONG:
        {
            if (_mTime.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择服务时间"];
            return;
            }
            
            int hour = [[_mfwsc stringByReplacingOccurrencesOfString:@"小时" withString:@""] intValue];
            int num = [[_mfwnum stringByReplacingOccurrencesOfString:@"人" withString:@""] intValue];
            
            NSString *other = @"";
            
            if (_mCheck1.selected) {
                other = [other stringByAppendingString:@"抹布,"];
            }
            
            if (_mCheck2.selected) {
                other = [other stringByAppendingString:@"清洁剂,"];
            }
            
            if (_mCheck3.selected) {
                other = [other stringByAppendingString:@"杀虫剂,"];
            }
            
            for (int i = 0; i < _selectothers.count; i++) {
                
                int flag = [[_selectothers objectAtIndex:i] intValue];
                if (flag) {
                    other = [other stringByAppendingString:[NSString stringWithFormat:@"%@,",[self.tempArray objectAtIndex:i]]];
                }
            }
            
            if (other.length>0) {
                
                other = [other substringToIndex:([other length]-1)];
            }
            
            [self showStatu:@"操作中.."];
            
            [SAuntInfo findHourWorker:0 work_province:_province work_city:_city work_area:_area service_address:_mdetailaddress additional:_mRemark.text service_items:other service_time:_mTime.text service_duration:hour service_count:num block:^(SResBase *retobj, SOrder *order) {
                
                if (retobj.msuccess) {
                    
                    [self saveHourInfo];
                    
                    [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                    
                    HourWorkPayVC *hpay = [[HourWorkPayVC alloc] initWithNibName:@"HourWorkPayVC" bundle:nil];
                    hpay.mAddr = _maddress;
                    
                    hpay.mServiceTime = _mTime.text;
                    hpay.mOrder = order;
                    [self pushViewController:hpay];
                    
                }else{
                    [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                    return;
                }

            }];
            
        }

            
            break;
        case JUJIAYANFLAO:
            rea.mType = @"居家养老";
            break;
        case YANGSHENGYANGLAO:
            rea.mType = @"养生养老";
            break;
            
        case FEIYONG:
            rea.mType = @"菲佣";
            break;
            
        default:
            break;
    }


}

//保存保姆所填需求 以便下次使用
- (void)saveInfo{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:_province forKey:@"province"];
    [dic setObject:_city forKey:@"city"];
    [dic setObject:_area forKey:@"area"];
    [dic setObject:_mdetailaddress forKey:@"detailaddress"];
    [dic setObject:_maddress forKey:@"address"];
    [dic setObject:_mAge.text forKey:@"age"];
    [dic setObject:_mplace forKey:@"place"];
    [dic setObject:@(_mstar) forKey:@"star"];
    if (_mRemark.text.length>0) {
        [dic setObject:_mRemark.text forKey:@"remark"];
    }
    
    [def setObject:dic forKey:@"bminfo"];
    [def synchronize];
}

//保存月嫂所填需求 以便下次使用
- (void)saveYueSaoInfo{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:_province forKey:@"province"];
    [dic setObject:_city forKey:@"city"];
    [dic setObject:_area forKey:@"area"];
    [dic setObject:_mdetailaddress forKey:@"detailaddress"];
    [dic setObject:_maddress forKey:@"address"];
    [dic setObject:_mTime.text forKey:@"time"];
    [dic setObject:_mTimeLength.text forKey:@"timelength"];
    [dic setObject:@(_mstar) forKey:@"star"];
    if (_mRemark.text.length>0) {
        [dic setObject:_mRemark.text forKey:@"remark"];
    }
    
    [def setObject:dic forKey:@"ysinfo"];
    [def synchronize];
}

//保存护工所填需求 以便下次使用
- (void)saveHuGongInfo{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:_province forKey:@"province"];
    [dic setObject:_city forKey:@"city"];
    [dic setObject:_area forKey:@"area"];
    [dic setObject:_mdetailaddress forKey:@"detailaddress"];
    [dic setObject:_maddress forKey:@"address"];
    [dic setObject:@(_mstar) forKey:@"star"];
    if (_mRemark.text.length>0) {
        [dic setObject:_mRemark.text forKey:@"remark"];
    }
    
    [def setObject:dic forKey:@"hginfo"];
    [def synchronize];
}

//保存小时工所填需求 以便下次使用
- (void)saveHourInfo{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:_province forKey:@"province"];
    [dic setObject:_city forKey:@"city"];
    [dic setObject:_area forKey:@"area"];
    [dic setObject:_mdetailaddress forKey:@"detailaddress"];
    [dic setObject:_maddress forKey:@"address"];
    [dic setObject:_mTime.text forKey:@"time"];
    
    [dic setObject:@(_indexhour) forKey:@"hour"];
    [dic setObject:@(_indexnum) forKey:@"num"];
    
    if (_mRemark.text.length>0) {
        [dic setObject:_mRemark.text forKey:@"remark"];
    }
    
    [def setObject:dic forKey:@"hourinfo"];
    [def synchronize];
}

- (IBAction)mOpenClick:(id)sender {
    
    if (_mGroupHeight.constant == 0) {
        
        if (_mType == XIAOSHIGONG) {
            _mGroupHeight.constant = DEVICE_Width/4.3;
        }else{
            _mGroupHeight.constant = DEVICE_Width/2.2;
        }
        _mJiantou.image = [UIImage imageNamed:@"jiantou_top"];
    }else{
        _mGroupHeight.constant = 0;
        _mJiantou.image = [UIImage imageNamed:@"jiantou_down"];
    }
}

- (IBAction)mOpenOtherClick:(id)sender {
    
    if (_mOtherHeight.constant == 0) {
        
        _mOtherHeight.constant = 1000;
        _mOtherJiantou.image = [UIImage imageNamed:@"jiantou_top"];
    }else{
        _mOtherHeight.constant = 0;
        _mOtherJiantou.image = [UIImage imageNamed:@"jiantou_down"];
    }
}
@end
