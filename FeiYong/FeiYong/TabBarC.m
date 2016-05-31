//
//  TabBarC.m
//  XiCheBuyer
//
//  Created by 周大钦 on 15/6/19.
//  Copyright (c) 2015年 zdq. All rights reserved.
//

#import "TabBarC.h"
#import "AppDelegate.h"

@interface TabBarC ()

@end

@implementation TabBarC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSArray *items = self.tabBar.items;
    
    for (int i = 0; i < items.count; i ++) {
        
        UITabBarItem *item = [items objectAtIndex:i];
        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"item%d",i+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"item%d-1",i+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    
    self.tabBar.tintColor = [UIColor whiteColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
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
