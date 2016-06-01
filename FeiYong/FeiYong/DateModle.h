//
//  DateModle.h
//  FeiYong
//
//  Created by 周大钦 on 16/5/27.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModle : NSObject



@end

@interface SAutoEx : NSObject

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

@end

//返回通用数据,,,
@interface SResBase : NSObject

@property (nonatomic,assign) int       msuccess;//是否成功了
@property (nonatomic,assign) int        mcode;  //错误码
@property (nonatomic,strong) NSString*  mmsg;   //客户端需要显示的提示信息,正确,失败,根据msuccess判断显示错误还是提示,
@property (nonatomic,strong) NSString*  mdebug;
@property (nonatomic,strong) id         mdata;

-(id)initWithObj:(NSDictionary*)obj;

-(void)fetchIt:(NSDictionary*)obj;

+(SResBase*)infoWithError:(NSString*)error;

@end

