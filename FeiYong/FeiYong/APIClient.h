

#import <Foundation/Foundation.h>
#import "AFNetworking/AFHTTPSessionManager.h"
#import "AFURLResponseSerialization.h"


@class SResBase;

@interface APIClient : AFHTTPSessionManager

+(NSString*)getDomain;


+ (APIClient *)sharedClient;

-(void)getUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( SResBase* info))callback;

-(void)postUrl:(NSString *)URLString parameters:(id)parameters call:(void (^)( SResBase* info))callback;

-(NSString *)photoUrl:(NSString *)string;

@end
