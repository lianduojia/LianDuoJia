

#import "APIClient.h"
#import "DateModle.h"
#import "CustomDefine.h"
#import "Util.h"
#import "AFNetworking/AFHTTPSessionManager.h"

 NSString*  kAFAppDotNetAPIBaseURLString    = @"http://42.121.120.51:8080/FYCenter/";
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
    _sharedClient.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/json",@"text/html",@"charset=UTF-8",@"text/plain",@"application/json",nil];
    _sharedClient.requestSerializer.timeoutInterval = 10;
    return _sharedClient;
}

- (void)cancelHttpOpretion:(AFHTTPRequestOperation *)http
{
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        if ([operation isEqual:http]) {
            [operation cancel];
            break;
        }
    }
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
    
    [self GET:URLString parameters:tparam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MLLog(@"URL%@ data:%@",operation.response.URL,responseObject);
        
        SResBase* retob = [[SResBase alloc]initWithObj:responseObject];
        
        callback(  retob );
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MLLog(@"error:%@",error.description);
        callback( [SResBase infoWithError: @"网络请求错误.."] );
        
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
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
//    [session.requestSerializer setValue:@"text/html;charset=utf-8" forHTTPHeaderField:@"Content-Type"] ;
    
    [session GET:Url parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSData *JSONData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];

        NSLog(@"返回数据：%@",responseObject);
        
        SResBase* retob = [[SResBase alloc]initWithObj:responseObject];
        
        callback(retob);
        
        NSLog(@"成功");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        MLLog(@"error:%@",error.description);
        callback( [SResBase infoWithError:@"网络请求错误.."] );
    }];

}




@end





