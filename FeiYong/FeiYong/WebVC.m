//
//  WebVC.m
//  YiZanService
//
//  Created by zzl on 15/3/29.
//  Copyright (c) 2015年 zywl. All rights reserved.
//

#import "WebVC.h"
@interface WebVC ()<UIWebViewDelegate>

@end

@implementation WebVC
{
    UIWebView* itwebview;
}

- (void)viewDidLoad {
    self.hiddenTabBar = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navTitle = _mName;
    itwebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_Width, DEVICE_InNavBar_Height)];
    [self.view addSubview:itwebview];
    
    [itwebview setScalesPageToFit:NO];
    itwebview.delegate = self;
    [SVProgressHUD showWithStatus:@"加载中..."];
    [itwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.mUrl]]];
    
   
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    self.navTitle = title;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:error.description];
}

- (void)leftBtnTouched:(id)sender{

    if (_isMode) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [super leftBtnTouched:sender];
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

@end
