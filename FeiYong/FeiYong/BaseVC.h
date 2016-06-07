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

-(void)gotoLogin;

-(void)leftBtnTouched:(id)sender;                       //左边navbar事件
-(void)rightBtnTouched:(id)sender;                      //右边navbar事件

-(void)headerBeganRefresh;                              //header刷新
-(void)footetBeganRefresh;                              //footer刷新
-(void)headerEndRefresh;                                //header停止刷新
-(void)footetEndRefresh;                                //footer停止刷新

-(void)popViewController;                               //返回上个controller

@end
