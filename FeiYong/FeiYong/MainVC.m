//
//  MainVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "MainVC.h"
#import "SDCycleScrollView.h"
#import "JoinVC.h"
#import "OrderVC.h"
#import "NavC.h"
#import "WebVC.h"
#import "APIClient.h"
#import "CityListVC.h"
#import "FindNannyVC.h"
#import "AddressVC.h"
#import "AddressCity.h"

@interface MainVC ()<SDCycleScrollViewDelegate,UITabBarControllerDelegate,UIScrollViewDelegate>{

    SDCycleScrollView *_cycleScrollView;
   
}

@end

@implementation MainVC

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.hiddenTabBar = NO;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navTitle = @"飞佣";
    self.hiddenNavBar = YES;
    
    [self loadAndupdateTopAdView:nil];
    
    self.tabBarController.delegate = self;
    
    _mScrollView.delegate = self;
    
    
    [self loadCity];
}

- (void)loadCity{

    if([SAppInfo shareClient].mCity.length > 0){
        
        [_mCityBt setTitle:[SAppInfo shareClient].mCity forState:UIControlStateNormal];
    }else{
        
        [self performSelector:@selector(loadCity) withObject:nil afterDelay:2];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    int Index = (int)tabBarController.selectedIndex;
    ((NavC *)viewController).TabBar = tabBarController;
    
    if(Index == 1){
        
        if ( [SUser isNeedLogin] ) {
            
            self.tabBarController.selectedIndex = 0;
            [self gotoLoginVC:viewController];
            
        }
    }
    
}


//加载广告
-(void)loadAndupdateTopAdView:(NSArray *)arr
{
    NSMutableArray *bannerAry = [[NSMutableArray alloc] initWithObjects:@"http://img1.gtimg.com/sports/pics/hv1/105/196/1592/103569885.jpg", nil];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Width*(13.0/32.0)) imagesGroup:bannerAry];
    _cycleScrollView.delegate = self;
//    [_mBannerView addSubview:_cycleScrollView];
    
    
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
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

- (IBAction)extendClick:(id)sender {
    
    int index = (int)((UIButton *)sender).tag;
    if(index == 12){
        
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    }
    else if (index == 10){
        
        CityListVC *cl = [[CityListVC alloc] initWithNibName:@"CityListVC" bundle:nil];
        
        [self pushViewController:cl];
    }
    else{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"057912312"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }

}

- (IBAction)menuClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;

    if (bt.tag == ZHUJIABAOMU || bt.tag == BUZHUJIABAOMU) {
        FindNannyVC *find = [[FindNannyVC alloc] initWithNibName:@"FindNannyVC" bundle:nil];
        find.mType = (int)bt.tag;;
        [self pushViewController:find];
        
        return;
    }
    
    if (bt.tag == YUESAO) {
        FindNannyVC *find = [[FindNannyVC alloc] initWithNibName:@"FindYueSaoVC" bundle:nil];
        find.mType = (int)bt.tag;;
        [self pushViewController:find];
        
        return;
    }
    
    if (bt.tag == PEIHU) {
        FindNannyVC *find = [[FindNannyVC alloc] initWithNibName:@"FindHuGongVC" bundle:nil];
        find.mType = (int)bt.tag;;
        [self pushViewController:find];
        
        return;
    }
    
    if (bt.tag == XIAOSHIGONG) {
        FindNannyVC *find = [[FindNannyVC alloc] initWithNibName:@"FindHourVC" bundle:nil];
        find.mType = (int)bt.tag;;
        [self pushViewController:find];
        
        return;
    }
    
    
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待！" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
    
    return;

    
}

- (IBAction)explainClick:(id)sender {
    
    int index = (int)((UIButton *)sender).tag;
    
    if(index == 10){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"057912312"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }else if(index == 11){
        
//        WebVC *web = [[WebVC alloc] init];
//        web.mName = @"平台介绍";
//        web.isMode = YES;
//        web.mUrl = [NSString stringWithFormat:@"%@introduce.html",[APIClient getDomain]];
//        [self presentViewController:web animated:YES completion:nil];
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待！" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
        
        
    }else if(index == 12){
    
        WebVC *web = [[WebVC alloc] init];
        web.mName = @"资费说明";
        web.isMode = YES;
        web.mUrl = [NSString stringWithFormat:@"%@charge.html",[APIClient getDomain]];
        [self presentViewController:web animated:YES completion:nil];
        
    }else{
    
        JoinVC *join = [[JoinVC alloc] initWithNibName:@"JoinVC" bundle:nil];
        
        [self pushViewController:join];
    }

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    if (y>=100) {
        
        _mHeadView.hidden = YES;
    }else{
        _mHeadView.hidden = NO;
    }
}

- (IBAction)ChoseCityClick:(id)sender {
    
    AddressCity *ac = [[AddressCity alloc] initWithNibName:@"AddressCity" bundle:nil];
    ac.itblock = ^(NSString *city){
        [_mCityBt setTitle:city forState:UIControlStateNormal];
    };
    
    [self pushViewController:ac];
}
@end
