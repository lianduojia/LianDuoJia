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

#define Width [UIScreen mainScreen].bounds.size.width

@interface ShopMallVC ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>{

    NSMutableArray *_imageArray;
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
    
    _imageArray = [NSMutableArray new];
    
    for (int index = 0; index < 3; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"banner%d",index+1]];
        [_imageArray addObject:image];
    }
    
    [self setupUI];
}


- (void)setupUI {
    
    
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 120, Width, DEVICE_InNavTabBar_Height - 120 + 14)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0;
    pageFlowView.minimumPageScale = 0.9;
    pageFlowView.isOpenAutoScroll = NO;
    
    //提前告诉有多少页
    pageFlowView.orginPageCount = _imageArray.count;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 14 - 8, Width, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [bottomScrollView addSubview:pageFlowView];
    
    [self.view addSubview:bottomScrollView];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(Width - 84, DEVICE_InNavTabBar_Height - 120);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    // 构建淘宝客户端协议的 URL
    NSURL *url = [NSURL URLWithString:@"taobao://www.taobao.com"];
    // 判断当前系统是否有安装淘宝客户端
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        // 如果已经安装淘宝客户端，就使用客户端打开链接
        [[UIApplication sharedApplication] openURL:url];
    } else {
        // 否则使用 Mobile Safari 或者内嵌 WebView 来显示
        url=[NSURL URLWithString:@"https://www.taobao.com"];
        [[UIApplication sharedApplication] openURL:url];
    }
//    WebVC *web = [[WebVC alloc] init];
//    web.mName = @"淘宝";
//    web.isMode = YES;
//    web.mUrl = @"https://www.taobao.com";
//    [self presentViewController:web animated:YES completion:nil];

    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return _imageArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, Width - 84, (Width - 84) * DEVICE_InNavTabBar_Height - 120)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    bannerView.mainImageView.image = _imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
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
