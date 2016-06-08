//
//  MainVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "MainVC.h"
#import "SDCycleScrollView.h"
#import "ParentalServiceVC.h"

@interface MainVC ()<SDCycleScrollViewDelegate>{

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
    self.hiddenBackBtn = YES;
    
    [self loadAndupdateTopAdView:nil];
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
    
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待！" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
    }]];
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
    
    return;

}

- (IBAction)menuClick:(id)sender {
    
    UIButton *bt = (UIButton *)sender;
    if(bt.tag == FEIYONG || bt.tag == YANGLAO){
        //初始化提示框；
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待！" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
    
        return;
    }
    
    ParentalServiceVC *ps = [[ParentalServiceVC alloc] initWithNibName:@"ParentalServiceVC" bundle:nil];
    ps.mType = (int)bt.tag;
    [self.navigationController pushViewController:ps animated:YES];
    
}

- (IBAction)explainClick:(id)sender {
    
    [self gotoLogin];
    
//    //初始化提示框；
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"暂未开通" preferredStyle:  UIAlertControllerStyleAlert];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //点击按钮的响应事件；
//    }]];
//    
//    //弹出提示框；
//    [self presentViewController:alert animated:true completion:nil];
}
@end
