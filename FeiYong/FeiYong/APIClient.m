

#import "APIClient.h"
#import "DateModle.h"
#import "CustomDefine.h"
#import "Util.h"
#import "AFNetworking/AFHTTPSessionManager.h"

 NSString*  kAFAppDotNetAPIBaseURLString    = @"http://114.215.101.20:8080/FYCenter/";
//NSString*  kAFAppDotNetAPIBaseURLString    = @"http://ccxhtb.jios.org:8080/BsuGameCenter/";
// NSString*  kAFAppDotNetAPIBaseURLString    = @"http://101.200.153.33:8080/FYCenter/";

@interface APIClient ()

@end

#pragma mark -

@implementation APIClient

+(NSString*)getDomain
{
    return kAFAppDotNetAPIBaseURLString;
}

+ (instancetype)sharedClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    });
    _sharedClient.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
    _sharedClient.requestSerializer.timeoutInterval = 10;
    return _sharedClient;
}

-(NSString *)photoUrl:(NSString *)string{

    return [NSString stringWithFormat:@"%@%@",kAFAppDotNetAPIBaseURLString,string];
}

-(NSString *)imgUrl:(NSString *)string{
    
    return [NSString stringWithFormat:@"%@%@",kAFAppDotNetAPIBaseURLString,string];
}



#pragma mark -




-(void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)(  SResBase* info))callback
{
    NSMutableDictionary* tparam = NSMutableDictionary.new;
    
    if( parameters )//真正的参数需要弄到 Data里面
    {
        NSData* jj = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil
                      ];
        NSString *str = [[NSString alloc] initWithData:jj encoding:NSUTF8StringEncoding];
        [tparam setObject:str forKey:@"data"];
    }
    
    [self GET:URLString parameters:tparam progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MLLog(@"data:%@",responseObject);
        
        SResBase* retob = [[SResBase alloc]initWithObj:responseObject];
        
        callback(  retob );
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MLLog(@"error:%@",error.description);
        
    }];
    
}




/**
 *  Post链接总方法
 *
 *  @param apiType    请求链接
 *  @param parameters 参数
 *  @param callback   返回网络数据
 */
-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)(  SResBase* info))callback
{
   
    
    NSMutableString*  Url = [NSMutableString stringWithFormat:@"%@%@",kAFAppDotNetAPIBaseURLString,URLString];
    
    NSLog(@"=====%@%@",Url,parameters);

//    [session.requestSerializer setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"] ;
    
    [self GET:Url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"返回数据：%@",responseObject);
        
        SResBase* retob = [[SResBase alloc]initWithObj:responseObject];
        
        callback(retob);
        
        NSLog(@"成功");
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        MLLog(@"error:%@",error.description);
        callback( [SResBase infoWithError:@"网络请求错误.."] );
        
    }];

}




@end





