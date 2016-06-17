//
//  BaseVC.h
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshBaseView.h"
#import "MJRefresh.h"
#import "CustomDefine.h"
#import "NavBar.h"

@interface BaseVC : UIViewController

@property (nonatomic,strong)    NSString* mPageName;
@property (nonatomic,strong) NavBar     *navBar;            //NavBar
@property (nonatomic,strong) NSString   *navTitle;          //navTitle
@property (nonatomic,strong) NSString   *navRightText;      //navBar RightText

@property (nonatomic,strong) NSMutableArray *tempArray; //tableview存储数据数组
@property (nonatomic,assign) int  page;                 //tableview翻页

@property (nonatomic,assign) BOOL  hiddenTabBar;         //是否需要隐藏tabbar
@property (nonatomic,assign) BOOL  hiddenNavBar;         //是否需要隐藏navbar
@property (nonatomic,assign) BOOL  hiddenBackBtn;        //是否需要隐藏BackBtn

@property (nonatomic,assign) BOOL haveHeader;           //是否需要下拉刷新
@property (nonatomic,assign) BOOL haveFooter;           //是否需要上拉加载
@property (nonatomic,strong) UITableView *tableView;    //列表
-(void)loadTableView:(CGRect)rect delegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)datasource;

-(void)gotoLogin;
-(void)gotoLoginVC:(UIViewController *)viewcontroller;

-(void)leftBtnTouched:(id)sender;                       //左边navbar事件
-(void)rightBtnTouched:(id)sender;                      //右边navbar事件

-(void)headerBeganRefresh;                              //header刷新
-(void)footetBeganRefresh;                              //footer刷新
-(void)headerEndRefresh;                                //header停止刷新
-(void)footetEndRefresh;                                //footer停止刷新

-(void)addEmpty;
-(void)removeEmpty;

-(void)pushViewController:(UIViewController *)controller;
-(void)popViewController;
-(void)popViewController_2;
-(void)popViewController_3;


-(void)showStatu:(NSString *)string;                    //显示提示消息

@end
