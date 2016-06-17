//
//  DateModle.m
//  FeiYong
//
//  Created by 周大钦 on 16/5/27.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "DateModle.h"
#import <objc/message.h>
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APIClient.h"
#import "Util.h"

@implementation DateModle

@end

@implementation SAutoEx

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self && obj )
    {
        [self fetchIt:obj];
    }
    return self;
}

-(void)fetchIt:(NSDictionary*)obj
{
    if( obj == nil ) return;
    NSMutableDictionary* nameMapProp = NSMutableDictionary.new;
    id leaderClass = [self class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(leaderClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        [nameMapProp setObject:[NSString stringWithFormat:@"%s",property_getAttributes(property)] forKey:propName];
    }
    if( properties )
    {
        free( properties );
    }
    
    if( nameMapProp.count == 0 ) return;
    
    NSArray* allnames = [nameMapProp allKeys];
    for ( NSString* oneName in allnames ) {
        if( ![oneName hasPrefix:@"m"] ) continue;
        //mId....like this
        NSString* jsonkey = [oneName stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:[[oneName substringWithRange:NSMakeRange(1, 1)] lowercaseString] ];
        //mId ==> mid;
        jsonkey = [jsonkey substringFromIndex:1];
        //mid ==> id;
        id itobj = [obj objectForKey:jsonkey];
        
        if( itobj == nil ) continue;
        
        
        
        [self setValue:itobj forKey:oneName];
    }
}
@end

@interface SResBase()

@property (nonatomic,strong)    id mcoredat;

@end

@implementation SResBase


-(id)initWithObj:(NSDictionary *)obj
{
    self = [super init];
    if( self && obj != nil )
    {
        [self fetchIt:obj];
        self.mcoredat = obj;
    }
    return self;
}

-(void)fetchIt:(NSDictionary *)obj
{
    _mcode = [[obj objectForKeyMy:@"_no"] intValue];
    
    if (_mcode == 1000) {
        _msuccess = 1;
    }
//    _msuccess = _mcode;
    self.mmsg = [obj objectForKeyMy:@"_msg"];
    self.mdata = [obj objectForKeyMy:@"_data"];
}

+(SResBase*)infoWithError:(NSString*)error
{
    SResBase* retobj = SResBase.new;
    retobj.mcode = 1;
    retobj.msuccess = NO;
    retobj.mmsg = error;
    return retobj;
}
@end

SAppInfo* g_appinfo = nil;
@implementation SAppInfo

+(SAppInfo*)shareClient{

    if( g_appinfo ) return g_appinfo;
    @synchronized(self) {
        
        if ( !g_appinfo )
        {
            SAppInfo* t = [SAppInfo loadAppInfo];
            g_appinfo = t;
        }
        return g_appinfo;
    }

}

+(SAppInfo*)loadAppInfo
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"gappinfo"];
    SAppInfo* tt = SAppInfo.new;
    if( dat )
    {
        
    }
    return tt;
}

@end

@implementation SAddress



@end


@implementation Order

- (NSString *)description {
    
    NSMutableString * discription = [NSMutableString string];
    if (self.partner) {
        [discription appendFormat:@"partner=\"%@\"", self.partner];
    }
    
    if (self.sellerID) {
        [discription appendFormat:@"&seller_id=\"%@\"", self.sellerID];
    }
    if (self.outTradeNO) {
        [discription appendFormat:@"&out_trade_no=\"%@\"", self.outTradeNO];
    }
    if (self.subject) {
        [discription appendFormat:@"&subject=\"%@\"", self.subject];
    }
    
    if (self.body) {
        [discription appendFormat:@"&body=\"%@\"", self.body];
    }
    if (self.totalFee) {
        [discription appendFormat:@"&total_fee=\"%@\"", self.totalFee];
    }
    if (self.notifyURL) {
        [discription appendFormat:@"&notify_url=\"%@\"", self.notifyURL];
    }
    
    if (self.service) {
        [discription appendFormat:@"&service=\"%@\"",self.service];//mobile.securitypay.pay
    }
    if (self.paymentType) {
        [discription appendFormat:@"&payment_type=\"%@\"",self.paymentType];//1
    }
    
    if (self.inputCharset) {
        [discription appendFormat:@"&_input_charset=\"%@\"",self.inputCharset];//utf-8
    }
    if (self.itBPay) {
        [discription appendFormat:@"&it_b_pay=\"%@\"",self.itBPay];//30m
    }
    if (self.showURL) {
        [discription appendFormat:@"&show_url=\"%@\"",self.showURL];//m.alipay.com
    }
    if (self.appID) {
        [discription appendFormat:@"&app_id=\"%@\"",self.appID];
    }
    for (NSString * key in [self.outContext allKeys]) {
        [discription appendFormat:@"&%@=\"%@\"", key, [self.outContext objectForKey:key]];
    }
    return discription;
}


+(void)aliPay:(NSString *)title orderNo:(NSString *)orderNo price:(float)price block:(void(^)(SResBase* retobj))block{

    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088221624818651";
    NSString *seller = @"2789207168@qq.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMxDELcUANF42raPmW6NhbinT0uWY+FReaTcrFVOuUngtOfCt0MijtWJarT3S0mvsrKBLZoewwkOToUWCC4aX/rp5M76K9C61fheXqbHDJYu5ndXD6PsAkXUlhtLY0IToA7E2S7viGe2zzBs5SnSj/QQRk3R882ODs6Ygqys1wMFAgMBAAECgYEAw+WJ8VtQ0ZSrhazAxMMbvRVQujh4gA6IsHEnIgWHNHA6b49R/SP2gprw6K/G19uWcRXsq0PXXycGbSLNI5IN+zpdGFVbnrPyL2Ir7o8TXJ7J5wjHdl1w0BHixQ0CgohsKdnsRpZilDmzvXRMwf81Ot/wAQubWgIHqHkyuqkSa8ECQQDsRt3gN/LG865/aa0xtgmHpY9upnmLf8rpvG9JoVwvSc8BnxaOnhm/E98vUrt1n/PKr6ZmUKF9Vc70xpoL0W9xAkEA3VAOHZTzHRhPufgBn5geJOphQHiUy+8pcUF23QIxLnmNfLsjS6t54rtCetVDgMdoxJbM+Z3H8xSr6V6t9zjq1QJAckLPF5hW2qmLUGh9bhXXQ/bnhx4Ql0qEiUYsF1JmLyQlbGZP1UZVsxbcDpmWuApTLkiFUuNZRTBS9gJ5CpAMsQJBAIezg8Q9xchsVM6KNKygQLOQB6vZhBt7/WRVqMWhh3igzdHSibTnYyhUfFIHHIoFO8d3VB4m0ijJ3xOMm41AmDUCQAlgTVGKhKOTr7addFA72cZtO5wtr1FEkwA2B3oDw8Cs9prdL5EtkDRQsIVwR8oBFDJyGvjkpQLcwqO1EMF1QLQ=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
//    /*
//     *生成订单信息及签名
//     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = orderNo; //订单ID（由商家自行制定）
    order.subject = title; //商品标题
    order.body = @"中介费"; //商品描述
    order.totalFee = [NSString stringWithFormat:@"0.01"]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"lianduojia";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];

    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [SAppInfo shareClient].mPayBlock = ^(SResBase *retobj) {
            block(retobj);//再回调获取
            [SAppInfo shareClient].mPayBlock = nil;
            
        };
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"xxx:%@",resultDic);
            
            SResBase* retobj = nil;
            
            if (resultDic)
            {
                if ( [[resultDic objectForKey:@"resultStatus"] intValue] == 9000 )
                {
                    retobj = [[SResBase alloc]init];
                    retobj.msuccess = YES;
                    retobj.mmsg = @"支付成功";
                    retobj.mcode = 0;
                }
                else
                {
                    retobj = [SResBase infoWithError: [resultDic objectForKey:@"memo" ]];
                }
            }
            else
            {
                retobj = [SResBase infoWithError: @"支付出现异常"];
            }
            
            if( [SAppInfo shareClient].mPayBlock )
            {
                [SAppInfo shareClient].mPayBlock( retobj );
            }
            else
            {
                MLLog(@"alipay block nil?");
            }


            block(retobj);
        }];
    }

}

@end

@class SAddress;
@implementation SUser

- (id)initWithObj:(NSDictionary *)obj{

    SUser *user = [[SUser alloc] init];
    if ([obj objectForKeyMy:@"id"]) {
        user.mId = [obj objectForKeyMy:@"id"];
    }else{
        user.mId = [obj objectForKeyMy:@"employer_id"];
    }
    user.mName = [obj objectForKeyMy:@"name"];
    user.mSex = [obj objectForKeyMy:@"sex"];
    user.mPhoto_url = [obj objectForKeyMy:@"photo_url"];
    
    return user;
}


//返回当前用户
+(SUser*)currentUser{

    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    NSDictionary* dat = [def objectForKey:@"userInfo"];
    if( dat )
    {
        SUser* tu = [[SUser alloc] initWithObj:dat];
        return tu;
    }
    return nil;
}

+(void)saveUserInfo:(id)dccat
{
    dccat = [Util delNUll:dccat];
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:dccat forKey:@"userInfo"];
    [def synchronize];
}

//判断是否需要登录
+(BOOL)isNeedLogin{
    return [SUser currentUser] == nil;
}

//退出登陆
+(void)logout{
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    [def setObject:nil forKey:@"userInfo"];
    [def synchronize];
}

//查看个人信息
+(void)getDetail:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [[APIClient sharedClient] postUrl:@"query-personal-details" parameters:param call:^(SResBase *info) {
        
        if(info.msuccess){
        
            [SUser saveUserInfo:info.mdata];
            
        }
        block(info);
    }];

}

+(void)updateInfo:(NSString *)name sex:(NSString *)sex photo_url:(NSString *)photo_url block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:name forKey:@"name"];
    [param setObject:sex forKey:@"sex"];
    [param setObject:photo_url forKey:@"photo_url"];
    [[APIClient sharedClient] postUrl:@"update-persional-details" parameters:param call:^(SResBase *info) {
        
        if(info.msuccess){
            
            [SUser saveUserInfo:param];
            
        }
        block(info);
    }];

}

//注册－－短信验证
+(void)registers:(NSString *)phone code:(NSString *)code block:(void(^)(SResBase* retobj))block{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:phone forKey:@"phone"];
    [param setObject:code forKey:@"code"];
    [param setObject:@"ios" forKey:@"type"];
    [[APIClient sharedClient] postUrl:@"regist-msg" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

//注册
+(void)regist:(NSString *)name pwd:(NSString *)pwd phone:(NSString *)phone block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:name forKey:@"name"];
    [param setObject:pwd forKey:@"pwd"];
    [param setObject:phone forKey:@"phone"];
    [[APIClient sharedClient] postUrl:@"regist" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

//登陆
+(void)login:(NSString *)name code:(NSString *)pwd block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =   NSMutableDictionary.new;
    [param setObject:name forKey:@"phone"];
    [param setObject:pwd forKey:@"pwd"];
    [[APIClient sharedClient] postUrl:@"login" parameters:param call:^(SResBase *info) {
        
        if( info.msuccess )
        {
            [self saveUserInfo:info.mdata];
        }
        
        block(info);
    }];
    
}

//忘记密码
+(void)forgetPwd:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code block:(void(^)(SResBase* retobj))block{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:phone forKey:@"phone"];
    [param setObject:pwd forKey:@"pwd"];
    [param setObject:code forKey:@"code"];
    [param setObject:@"ios" forKey:@"type"];
    [[APIClient sharedClient] postUrl:@"forget-pwd" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

+(void)feedBack:(NSString *)salutation content:(NSString *)content block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:salutation forKey:@"salutation"];
    [param setObject:content forKey:@"content"];
    [[APIClient sharedClient] postUrl:@"feedback" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

//查询余额	/query-balance	employer_id=2(雇主ID)
+(void)getBalance:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [[APIClient sharedClient] postUrl:@"query-balance" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

//查看地址	/query-address	employer_id=2(雇主ID)
+(void)getAddress:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    
    [[APIClient sharedClient] postUrl:@"query-address" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SAddress *order = [[SAddress alloc] initWithObj:dic];
                    
                    [array addObject:order];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
        
    }];
}

+(void)editAddress:(int)address_id address_province:(NSString *)address_province address_city:(NSString *)address_city address_area:(NSString *)address_area address_detail:(NSString *)address_detail link_man:(NSString *)link_man link_phone:(NSString *)link_phone block:(void(^)(SResBase* retobj))block;{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:address_province forKey:@"address_province"];
    [param setObject:address_city forKey:@"address_city"];
    [param setObject:address_area forKey:@"address_area"];
    [param setObject:address_detail forKey:@"address_detail"];
    [param setObject:link_man forKey:@"link_man"];
    [param setObject:link_phone forKey:@"link_phone"];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    
    NSString *string = @"add-address";
    
    if (address_id !=0) {
        [param setObject:@(address_id) forKey:@"address_id"];
        string = @"update-address";
    }
    
    [[APIClient sharedClient] postUrl:string parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

+(void)joinShop:(NSString *)address_province address_city:(NSString *)address_city address_area:(NSString *)address_area link_man:(NSString *)link_man link_phone:(NSString *)link_phone block:(void (^)(SResBase *))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:address_province forKey:@"address_province"];
    [param setObject:address_city forKey:@"address_city"];
    [param setObject:address_area forKey:@"address_area"];
    [param setObject:link_man forKey:@"name"];
    [param setObject:link_phone forKey:@"phone"];
    if ([SUser currentUser]) {
        [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    }
    
    
    [[APIClient sharedClient] postUrl:@"shop-join" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];

}


@end

@implementation SComment



@end

@implementation SOrder

//根据订单id获得订单号	/query-billno-by-billid	bill_id=62(订单id)
-(void)getOrderNo:(void(^)(SResBase* retobj,NSString *orderNo))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"bill_id"];
    
    [[APIClient sharedClient] postUrl:@"query-billno-by-billid" parameters:param call:^(SResBase *info) {
        if(info.msuccess){
            block(info,[info.mdata objectForKey:@"no"]);
        }else{
            block(info,@"");
        }
        
    }];

}


-(void)makeAppointment:(NSString *)meet_date meet_time:(NSString *)meet_time meet_location:(NSString *)meet_location block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"bill_id"];
    [param setObject:meet_date forKey:@"meet_date"];
    [param setObject:meet_time forKey:@"meet_time"];
    [param setObject:meet_location forKey:@"meet_location"];
    
    [[APIClient sharedClient] postUrl:@"make-an-appointment" parameters:param call:^(SResBase *info) {
        block(info);
    }];
}

//完成订单中介费支付	/complete-agency-pay	bill_id=xxxx(订单id)
-(void)payOK:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"bill_id"];
    
    [[APIClient sharedClient] postUrl:@"complete-agency-pay" parameters:param call:^(SResBase *info) {
        block(info);
    }];

}

///query-bill	employer_id=2(用户的id)  type=(0:待支付 )
+(void)getOrderList:(int)type block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    
    NSString *string = @"";
    
    switch (type) {
        case 0:
            //待支付
            string = @"query-bill";
            break;
        case 1:
            //待预约
            string = @"query-complete-bill";
            [param setObject:@"中介费" forKey:@"bill_type"];
            break;
        case 2:
            //待评价
            string = @"query-meet-maid";
            break;
        case 3:
            //待预约
            string = @"query-complete-bill";
            [param setObject:@"所有" forKey:@"bill_type"];
            break;
            
        default:
            break;
    }
    
    [[APIClient sharedClient] postUrl:string parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SOrder *order = [[SOrder alloc] initWithObj:dic];
                    
                    [array addObject:order];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }

    }];
}

//雇佣阿姨	/employ-maid	employer_id=2(雇主id)&bill_id=48(订单id)&maid_id=3(阿姨id)
-(void)employMaid:(void(^)(SResBase* retobj))block{

     NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(_mBill_id) forKey:@"bill_id"];
    [param setObject:@(_mMail_id) forKey:@"maid_id"];
    
    [[APIClient sharedClient] postUrl:@"employ-maid" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];

}

@end

@implementation SAuntInfo

//找保姆
+(void)findNurse:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;

    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:@(min_age) forKey:@"min_age"];
    [param setObject:@(max_age) forKey:@"max_age"];
    [param setObject:[Util JSONString:over_night] forKey:@"over_night"];
    
    [[APIClient sharedClient] postUrl:@"find-nurse" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SAuntInfo *aunt = [[SAuntInfo alloc] initWithObj:dic];
                    
                    [array addObject:aunt];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
    }];

}

//找护工
+(void)findAccompany:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night sex:(NSString *)sex care_type:(NSString *)care_type block:(void(^)(SResBase* retobj,NSArray *arr))block{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(employer_id) forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:@(min_age) forKey:@"min_age"];
    [param setObject:@(max_age) forKey:@"max_age"];
    [param setObject:[Util JSONString:over_night] forKey:@"over_night"];
    [param setObject:[Util JSONString:sex] forKey:@"sex"];
    [param setObject:[Util JSONString:care_type] forKey:@"care_type"];
    
    [[APIClient sharedClient] postUrl:@"find-accompany" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SAuntInfo *aunt = [[SAuntInfo alloc] initWithObj:dic];
                    
                    [array addObject:aunt];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
    }];

}

//找月嫂
+(void)findMatron:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area have_auth:(NSString *)have_auth block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;

    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:[Util JSONString:have_auth] forKey:@"have_auth"];
    
    [[APIClient sharedClient] postUrl:@"find-maternity-matron" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SAuntInfo *aunt = [[SAuntInfo alloc] initWithObj:dic];
                    
                    [array addObject:aunt];
                }
            }
            block(info,array);
            
        }else{
            block(info,nil);
        }
    }];

}

//找小时工
+(void)findHourWorker:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area count:(int)count block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:@(count) forKey:@"count"];
    
    [[APIClient sharedClient] postUrl:@"find-hour-worker" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SAuntInfo *aunt = [[SAuntInfo alloc] initWithObj:dic];
                    
                    [array addObject:aunt];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
    }];

}

//找育儿嫂
+(void)findChildCare:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:@(min_age) forKey:@"min_age"];
    [param setObject:@(max_age) forKey:@"max_age"];
    [param setObject:[Util JSONString:over_night] forKey:@"over_night"];
    
    [[APIClient sharedClient] postUrl:@"find-child-care" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SAuntInfo *aunt = [[SAuntInfo alloc] initWithObj:dic];
                    
                    [array addObject:aunt];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
    }];

    
}

//放弃阿姨数据	/delete-maid	employer_id=xx(用户id)&maid_id=xxxx(对应的阿姨数据的id)

-(void)deleteThis:(void(^)(SResBase* retobj))block{

     NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(self.mId) forKey:@"maid_id"];
    
    [[APIClient sharedClient] postUrl:@"delete-maid" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];

}

-(void)getComment:(NSString *)comment_type page:(int)page block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"maid_id"];
    [param setObject:[Util JSONString:comment_type] forKey:@"comment_type"];
    [param setObject:@(page) forKey:@"page"];
    
    [[APIClient sharedClient] postUrl:@"show-comment" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SComment *aunt = [[SComment alloc] initWithObj:dic];
                    
                    [array addObject:aunt];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }

    }];
}

-(void)submitComment:(NSString *)comment_type comment:(NSString *)comment star_count:(int)star_count block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(_mId) forKey:@"maid_id"];
    [param setObject:[Util JSONString:comment_type] forKey:@"comment_type"];
    [param setObject:[Util JSONString:comment] forKey:@"comment"];
    [param setObject:@(star_count) forKey:@"star_count"];
    
    [[APIClient sharedClient] postUrl:@"submit-comment" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

+(void)submitOrder:(NSArray *)array service_date:(NSString *)service_date service_address:(NSString *)service_address additional:(NSString *)additional service_time:(NSString *)service_time service_duration:(NSString *)service_duration block:(void(^)(SResBase* retobj,SOrder *order))block{

    NSString *idstring = @"";
    for (SAuntInfo *aunt in array) {
        idstring = [idstring stringByAppendingString:[NSString stringWithFormat:@"%d,",aunt.mId]];
    }
    idstring = [idstring substringToIndex:([idstring length]-1)];
    
    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:service_date forKey:@"service_date"];
    [param setObject:service_address forKey:@"service_address"];
    [param setObject:idstring forKey:@"maid_id"];
    
    //小时工
    if(service_duration){
        [param setObject:service_duration forKey:@"service_duration"];
    }
    if (service_time) {
          [param setObject:service_time forKey:@"service_time"];
    }
    
    NSString *string = @"";
    
    if (service_time || service_duration) {
        string = @"hour-worker-agency-bill";
    }else{
        string = @"agency-bill";
    }
    
    
    [[APIClient sharedClient] postUrl:string parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            SOrder *order =  [[SOrder alloc] initWithObj:info.mdata];
            
            block(info,order);
        }else{
        
            block(info,nil);
        }
    }];
}

@end




