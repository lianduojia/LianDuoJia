//
//  BaseVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "BaseVC.h"
#import "LoginVC.h"
#import "IQKeyboardManager.h"
#import "UMMobClick/MobClick.h"

@interface BaseVC ()<UIGestureRecognizerDelegate>{

    EmptyView *_emptyview;
}

@end

@implementation BaseVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager]setEnableAutoToolbar:YES];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    self.hiddenTabBar = YES;
    
    [MobClick beginLogPageView:self.navTitle];//("PageOne"为页面名称，可自定义)
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
      [MobClick endLogPageView:self.navTitle];
    
//    [SVProgressHUD dismiss];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

-(void)setHaveHeader:(BOOL)have
{
    __block BaseVC *vc = self;
    
    if(have){
        [self.tableView addHeaderWithCallback:^{
            [vc headerBeganRefresh];
        }];
    }else{
        [self.tableView removeHeader];
    }
    
}
-(void)setHaveFooter:(BOOL)haveFooter
{
    __block BaseVC *vc = self;
    
    if (haveFooter) {
        [self.tableView addFooterWithCallback:^{
            [vc footetBeganRefresh];
        }];
        
    }else{
        [self.tableView removeFooter];
    }
    
}

- (void)setHiddenNavBar:(BOOL)hiddenNavBar{

    self.navBar.hidden = hiddenNavBar;
}
- (void)setHiddenTabBar:(BOOL)hiddenTabBar{

    self.tabBarController.tabBar.hidden = hiddenTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    //    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
//    self.view.backgroundColor = M_BGCO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化NavBar
    self.navBar = [NavBar shareView];
    
    self.navBar.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_NavBar_Height);
    [self.view addSubview:self.navBar];
    
    [self.navBar.mLeftButton addTarget:self action:@selector(leftBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar.mRightButton addTarget:self action:@selector(rightBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
     [self.navBar.mRightButton2 addTarget:self action:@selector(rightBtnTouched2:) forControlEvents:UIControlEventTouchUpInside];
    
    self.tempArray = [[NSMutableArray alloc]init];
    self.page = 0;
}

-(void)gotoLogin{
    
    LoginVC *login = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];

    [self presentViewController:login animated:YES completion:nil];
}

-(void)gotoLoginVC:(UIViewController *)viewcontroller{
    
    LoginVC *login = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    login.mViewController = viewcontroller;
    [self presentViewController:login animated:YES completion:nil];

}

-(void)leftBtnTouched:(id)sender
{
    [self popViewController];
    //todo
}
-(void)rightBtnTouched:(id)sender
{
    //todo
}

-(void)rightBtnTouched2:(id)sender{


}

//设置NavTitle
- (void)setNavTitle:(NSString *)navTitle{

    self.navBar.mTitle.text = navTitle;
}

//设置NavRightText
- (void)setNavRightText:(NSString *)navRightText{

    [self.navBar.mRightButton setTitle:navRightText forState:UIControlStateNormal];
}

- (void)setHiddenBackBtn:(BOOL)hiddenBackBtn{
    
    self.navBar.mLeftButton.hidden = hiddenBackBtn;
}

-(void)headerBeganRefresh
{
//    [self headerEndRefresh];
    
    //todo
}
-(void)footetBeganRefresh
{
//    [self footetEndRefresh];
    //todo
}

-(void)headerEndRefresh{
    [self.tableView headerEndRefreshing];
}//header停止刷新
-(void)footetEndRefresh{
    [self.tableView footerEndRefreshing];
}//footer停止刷新

-(void)addEmpty:(CGRect)rect image:(NSString *)img{
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 140, 127)];
    imgV.image = [UIImage imageNamed:@"empty"];
    if (img.length>0) {
        imgV.image = [UIImage imageNamed:img];
    }
    imgV.center = view.center;
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imgV];
    
    self.tableView.tableFooterView = view;
}

-(void)addEmpty2:(CGRect)rect{
    _emptyview = [[EmptyView alloc] initWithNibName:@"EmptyView2" bundle:nil];
    _emptyview.view.frame = rect;
    
    self.tableView.tableFooterView = _emptyview.view;
}

-(void)removeEmpty{
    
    self.tableView.tableFooterView = [UIView new];
}

-(void)loadTableView:(CGRect)rect delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)datasource
{
    self.tableView = [[UITableView alloc]initWithFrame:rect];
    self.tableView.delegate = delegate;
    self.tableView.dataSource = datasource;
    [self.view addSubview:self.tableView];
    
}

-(void)pushViewController:(UIViewController *)controller{

    [self.navigationController pushViewController:controller animated:YES];
}

-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)popViewController_2
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 2 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}

-(void)popViewController_3
{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > 3 )
    {
        [vcs removeLastObject];
        [vcs removeLastObject];
        [vcs removeLastObject];
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self popViewController];
}


-(void)showStatu:(NSString *)string{

    [SVProgressHUD showWithStatus:string maskType:SVProgressHUDMaskTypeClear];
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
