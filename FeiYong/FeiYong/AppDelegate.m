//
//  AppDelegate.m
//  FeiYong
//
//  Created by 周大钦 on 16/5/26.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "AppDelegate.h"
#import "SMS_SDK/SMSSDK.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UMMobClick/MobClick.h"

@interface AppDelegate ()<NSXMLParserDelegate>{

    
    UIScrollView *_scrollView;
    
    NSString *_currentTagName;
    
    NSMutableArray *_provinces;
    NSMutableArray *_citys;
    NSMutableArray *_areas;
    
    NSMutableDictionary *_provinceDic;
    NSMutableDictionary *_cityDic;
}

@end

@implementation AppDelegate

// 开始解析
-(void)start{
    
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSArray *provinces = [def objectForKey:@"Province"];
    if (provinces.count>0) {
        return;
    }
    
    _provinces = [NSMutableArray new];
    _citys = [NSMutableArray new];
    _areas = [NSMutableArray new];
    
    _provinceDic = [NSMutableDictionary new];
    _cityDic = [NSMutableDictionary new];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"province_data" ofType:@"xml"];
    NSURL * url = [NSURL fileURLWithPath:path];
    
    //开始解析 xml
    NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self ;
    
    [parser parse];
    
    NSLog(@"解析搞定...");
    
}

- (void)firstLoad{

    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        
//        [SUser logout];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Height)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        
        [self.window.rootViewController.view addSubview:_scrollView];
        
        
        _scrollView.contentSize = CGSizeMake(DEVICE_Width*3, DEVICE_Height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        
        for (int i = 0; i<3; i++) {
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(i*DEVICE_Width, 0, DEVICE_Width, DEVICE_Height)];
            
            if (DeviceIsiPhone4) {
                imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide4-%d",i+1]];
            }else{
                imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide-%d",i+1]];
            }
            
            if (i==2) {
                
                imgV.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CloseFirst)];
                [imgV addGestureRecognizer:tap];
            }
            
            [_scrollView addSubview:imgV];
        }
        
    }else{
        NSLog(@"不是第一次启动");
    }

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"1390bb8412ad4"
             withSecret:@"d5be49608b1ee6ef7798cf5bbe521a73"];
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    UMConfigInstance.appKey = @"57748a82e0f55a9255002676";
    UMConfigInstance.channelId = @"Web";
    [MobClick startWithConfigure:UMConfigInstance];
    //是否第一次打开
    [self firstLoad];
    //解析城市地区XML
    [self start];
    
    
    [[SAppInfo shareClient] getLocation];
    
    [NSThread sleepForTimeInterval:1.5];
    [_window makeKeyAndVisible];
    
    return YES;
}

-(void)CloseFirst{
    
    [_scrollView removeFromSuperview];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //    UIApplicationOpenURLOptionsOpenInPlaceKey = 0;
    //    UIApplicationOpenURLOptionsSourceApplicationKey = "com.alipay.iphoneclient";com.tencent.xin
    
    if ([[options objectForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"] isEqualToString:@"com.alipay.iphoneclient"]) {
        
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      
                                                      MLLog(@"xxx:%@",resultDic);
                                                      
                                                      SResBase* retobj = nil;
                                                      
                                                      if (resultDic)
                                                      {
                                                          if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                                                          {
                                                              retobj = [[SResBase alloc]init];
                                                              retobj.msuccess = YES;
                                                              retobj.mmsg = @"支付成功";
                                                              retobj.mcode = 0;
                                                              [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                                                          }
                                                          else
                                                          {
                                                              retobj = [SResBase infoWithError: [resultDic objectForKey:@"memo" ]];
                                                              [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                                                          }
                                                      }
                                                      else
                                                      {
                                                          retobj = [SResBase infoWithError: @"支付出现异常"];
                                                          [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                                                      }
                                                      
                                                      if( [SAppInfo shareClient].mPayBlock )
                                                      {
                                                          [SAppInfo shareClient].mPayBlock( retobj );
                                                      }
                                                      else
                                                      {
                                                          retobj = [SResBase infoWithError: @"支付出现异常"];
                                                          [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                                                          MLLog(@"alipay block nil?");
                                                      }

                                                  }];
        return YES;
        
    }
    return YES;
}



- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // url:wx206e0a3244b4e469://pay/?returnKey=&ret=0 withsouce url:com.tencent.xin
    MLLog(@"url:%@ withsouce url:%@",url,sourceApplication);
    if ([url.host isEqualToString:@"safepay"])
    {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      
                                                      MLLog(@"xxx:%@",resultDic);
                                                      
                                                      SResBase* retobj = nil;
                                                      
                                                      if (resultDic)
                                                      {
                                                          if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                                                          {
                                                              retobj = [[SResBase alloc]init];
                                                              retobj.msuccess = YES;
                                                              retobj.mmsg = @"支付成功";
                                                              retobj.mcode = 0;
                                                              [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
                                                          }
                                                          else
                                                          {
                                                              retobj = [SResBase infoWithError: [resultDic objectForKey:@"memo" ]];
                                                              [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                                                          }
                                                      }
                                                      else
                                                      {
                                                          retobj = [SResBase infoWithError: @"支付出现异常"];
                                                          [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                                                      }
                                                      
                                                      if( [SAppInfo shareClient].mPayBlock )
                                                      {
                                                          [SAppInfo shareClient].mPayBlock( retobj );
                                                      }
                                                      else
                                                      {
                                                          retobj = [SResBase infoWithError: @"支付出现异常"];
                                                          [SVProgressHUD showErrorWithStatus:retobj.mmsg];
                                                          MLLog(@"alipay block nil?");
                                                      }

                                                  }];
        return YES;
    }
   
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.ldj.FeiYong" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FeiYong" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FeiYong.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//文档开始时触发 ,开始解析时 只触发一次
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    
}

// 文档出错时触发
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@",parseError);
}

//遇到一个开始标签触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    //把elementName 赋值给 成员变量 currentTagName
    _currentTagName  = elementName ;
    
    //如果名字 是Note就取出 id
    if ([_currentTagName isEqualToString:@"province"]) {
        
        NSString * _name = [attributeDict objectForKey:@"name"];
        //把name放入字典中
        [_provinceDic setObject:_name forKey:@"name"];
        
    }
    
    if ([_currentTagName isEqualToString:@"city"]) {
        
        NSString * _name = [attributeDict objectForKey:@"name"];
        
        //把name放入字典中
        [_cityDic setObject:_name forKey:@"name"];
        
    }
    
    if ([_currentTagName isEqualToString:@"district"]) {
        
        NSString * _name = [attributeDict objectForKey:@"name"];
        // 实例化一个可变的字典对象,用于存放
        NSMutableDictionary *dict = [NSMutableDictionary new];
        //把name放入字典中
        [dict setObject:_name forKey:@"name"];
        
        // 把可变字典 放入到 可变数组集合_notes 变量中
        [_areas addObject:dict];
    }
    
}
#pragma mark 该方法主要是解析元素文本的主要场所，由于换行符和回车符等特殊字符也会触发该方法，因此要判断并剔除换行符和回车符
// 遇到字符串时 触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
    
    string  = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    
    NSMutableDictionary * dict = [_provinces lastObject];
    if ([_currentTagName isEqualToString:@"CDate"] && dict) {
        [dict setObject:string forKey:@"CDate"];
    }
    
    if ([_currentTagName isEqualToString:@"Content"] && dict) {
        [dict setObject:string forKey:@"Content"];
    }
    
    if ([_currentTagName isEqualToString:@"UserID"] && dict) {
        [dict setObject:string forKey:@"UserID"];
    }
    
    
}

//遇到结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    _currentTagName = elementName ;
    
    
    
    if ([_currentTagName isEqualToString:@"city"]) {
        
        [_cityDic setObject:_areas forKey:@"child"];
        
        [_citys addObject:_cityDic];
        _areas = [NSMutableArray new];
        _cityDic = [NSMutableDictionary new];
        
    }
    
    if ([_currentTagName isEqualToString:@"province"]) {
        
        [_provinceDic setObject:_citys forKey:@"child"];
        
        [_provinces addObject:_provinceDic];
        _citys = [NSMutableArray new];
        _provinceDic = [NSMutableDictionary new];
        
    }
    
}

// 遇到文档结束时触发
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器） 通过广播机制将数据通过广播通知投送到 表示层
    NSLog(@"====%@",_provinces);
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:_provinces forKey:@"Province"];
    [def synchronize];
}


@end
