

#import "APIClient.h"
#import "DateModle.h"
#import "CustomDefine.h"
#import "Util.h"

static NSString* const  kAFAppDotNetAPIBaseURLString    = @"hair.test.o2o.fanwe.cn/";




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
    
    NSMutableDictionary* tparam = NSMutableDictionary.new;
    
    if( parameters )//真正的参数需要弄到 Data里面
    {
        NSData* jj = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil
                      ];
        NSString *str = [[NSString alloc] initWithData:jj encoding:NSUTF8StringEncoding];
        
        NSMutableString*  sssss = [NSMutableString stringWithFormat:@"%@%@?",kAFAppDotNetAPIBaseURLString,URLString];
        
        for ( NSString* onekey in ((NSDictionary*)parameters).allKeys ) {
            [sssss appendFormat:@"%@=%@&",onekey,[parameters objectForKey:onekey]];
        }
        [sssss replaceCharactersInRange:NSMakeRange(sssss.length-1, 1) withString:@""];
        
        MLLog(@"request 请求加密前参数：%@",sssss);
        
//#ifdef ENC
//        if( !binit )
//        {
//            int iv = [GInfo shareClient].mivint;
//            NSString* key = token;//[Util URLDeCode:token];
//            NSString* userid = [self getUserId];
//            if( userid.length == 0 )
//                userid = @"0";
//            key = [Util md5:[key stringByAppendingString:userid]];
//            
//            iv = [Util gettopestV:iv];
//            str = [CBCUtil CBCEncrypt:str key:key index:iv];
//            if( str == nil )
//            {
//                SResBase* itbase = [SResBase infoWithError:@"程序处理错误"];
//                callback( itbase );
//                return;
//            }
//        }
//#endif
        [tparam setObject:str forKey:@"data"];
    }
    
    MLLog(@"request 所有请求参数：%@",tparam);
    
    [self POST:URLString parameters:tparam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id fuckdata = [responseObject objectForKeyMy:@"data"];
        if( responseObject && fuckdata && [fuckdata isKindOfClass:[NSString class]] )
        {
            NSMutableDictionary* tresb = [[NSMutableDictionary alloc]initWithDictionary:responseObject];
            
            NSError* jsonerrr = nil;
            id datobj = nil;
            if( tresb )
            {
                datobj = [NSJSONSerialization JSONObjectWithData:[fuckdata dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&jsonerrr];
            }
            
            if( datobj )
            {
                [tresb setObject:datobj forKey:@"data"];
                
            }
            else
            {
                [tresb setObject:[NSNumber numberWithInt:9997] forKey:@"code"];
                [tresb setObject:@"程序处理有错误." forKey:@"msg"];
                [tresb removeObjectForKey:@"data"];
                MLLog(@"json err:%@",jsonerrr.description);
            }
            responseObject = tresb;
        }
        
        MLLog(@"URL:%@ data:%@",operation.response.URL,responseObject);
        
        SResBase* retob = [[SResBase alloc]initWithObj:responseObject];
        
//        if( retob.mcode == 99996 )
//        {//需要登陆
//            id oneid = [UIApplication sharedApplication].delegate;
//            [oneid performSelector:@selector(gotoLogin) withObject:nil afterDelay:0.4f];
//        }
        callback(  retob );
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MLLog(@"url:%@ error:%@",operation.request,error.description);
        callback( [SResBase infoWithError:@"网络请求错误.."] );
        
    }];
}




@end





