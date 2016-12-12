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
#import "AFNetworking/AFHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

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
    self.mmsg = [obj objectForKeyMy:@"_extramsg"];
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

@interface SAppInfo()<CLLocationManagerDelegate>

@end

SAppInfo* g_appinfo = nil;
@implementation SAppInfo{
    
    CLLocationManager *_locationManager;
}

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

+(int)calcDist:(float)lat lng:(float)lng
{
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:lat  longitude:lng];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:[SAppInfo shareClient].mlat longitude:[SAppInfo shareClient].mlng];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist];
    NSLog(@"距离:%f",kilometers);
    
    return kilometers;
}

- (void)getLocation{
    
    
//    // 判断的手机的定位功能是否开启
//    // 开启定位:设置 > 隐私 > 位置 > 定位服务
//    if ([CLLocationManager locationServicesEnabled]) {
//        // 启动位置更新
//        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
//        [_locationManager startUpdatingLocation];
//    }
//    else {
//        
//    }
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
            //定位功能可用，开始定位
            // 实例化一个位置管理器
            _locationManager = [[CLLocationManager alloc] init];
            
            [_locationManager requestWhenInUseAuthorization];
            
            _locationManager.delegate = self;
            
            // 设置定位精度
            // kCLLocationAccuracyNearestTenMeters:精度10米
            // kCLLocationAccuracyHundredMeters:精度100 米
            // kCLLocationAccuracyKilometer:精度1000 米
            // kCLLocationAccuracyThreeKilometers:精度3000米
            // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
            // kCLLocationAccuracyBestForNavigation:导航情况下最高精度，一般要有外接电源时才能使用
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            
            // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
            // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
            _locationManager.distanceFilter = kCLDistanceFilterNone; // 如果设为kCLDistanceFilterNone，则每秒更新一次;
            if([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
                [_locationManager  requestWhenInUseAuthorization];
        
        [_locationManager startUpdatingLocation];

    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
       [[NSNotificationCenter defaultCenter] postNotificationName:@"nogps" object:nil];
        //发送消息
    }

}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    [manager stopUpdatingLocation];
    
    CLLocation* location = [locations lastObject];
    
    [SAppInfo shareClient].mlat = location.coordinate.latitude;
    [SAppInfo shareClient].mlng = location.coordinate.longitude;
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];

            NSDictionary *dic = placemark.addressDictionary;
            
            [SAppInfo shareClient].mAddress = [dic objectForKeyMy:@"Name"];
            [SAppInfo shareClient].mArea = [dic objectForKeyMy:@"SubLocality"];
            [SAppInfo shareClient].mCity = [dic objectForKeyMy:@"City"];
            [SAppInfo shareClient].mProvince = [dic objectForKeyMy:@"State"];
    
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取经纬度
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    
    [SAppInfo shareClient].mlat = newLocation.coordinate.latitude;
    [SAppInfo shareClient].mlng = newLocation.coordinate.longitude;
    
    
    
    
    // 停止位置更新
    [manager stopUpdatingLocation];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}



@end

@implementation SBanner

- (id)initWithObj:(NSDictionary *)obj{

    if( self && obj )
    {
        [self fetchIt:obj];
        
        self.mBanner_img_path = [NSString stringWithFormat:@"%@%@",[APIClient getDomain],self.mBanner_img_path];
//        self.mBanner_url = [NSString stringWithFormat:@"%@%@",[APIClient getDomain],self.mBanner_url];
    }
    
    return self;
}

+(void)getBanner:(void(^)(SResBase* retobj,NSArray* arr))block{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@"启动" forKey:@"banner_type"];
    [[APIClient sharedClient] postUrl:@"query-banner-imgs" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SBanner *shop = [[SBanner alloc] initWithObj:dic];
                    
                    [array addObject:shop];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
        
    }];
    
}

@end

@implementation SAddress



@end

@implementation SShop

- (id)initWithObj:(NSDictionary *)obj{
    
    if( self && obj )
    {
        [self fetchIt:obj];
        
        NSArray *array = [_mGps componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
        
        if (array.count>1) {
            float _mlng = [[array objectAtIndex:0] floatValue];
            float _mlat = [[array objectAtIndex:1] floatValue];
            
            self.mDistance = [Util getDistStr: [SAppInfo calcDist:_mlat lng:_mlng]];
        }

    }
    
    return self;
}

@end

@implementation SCity

- (id)initWithObj:(NSDictionary *)obj{
    
    if( self && obj )
    {
        [self fetchIt:obj];
        
        self.mIcon = [[APIClient sharedClient] imgUrl:self.mIcon];
    }
    
    return self;
}

//根据城市返回门店数据	/query-shop-by-city	city=北京市(城市数据)
-(void)getShopByCity:(void(^)(SResBase* retobj,NSArray* arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:self.mCity forKey:@"city"];
    
    [[APIClient sharedClient] postUrl:@"query-shop-by-city" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SShop *shop = [[SShop alloc] initWithObj:dic];
                    
                    [array addObject:shop];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
        
    }];

}

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


+(void)aliPay:(NSString *)title orderNo:(NSString *)orderNo price:(float)price detail:(NSString *)detail block:(void(^)(SResBase* retobj))block{

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
    order.body = detail; //商品描述
    order.totalFee = [NSString stringWithFormat:@"%.2f",price
                      ]; //商品价格
    order.notifyURL =  [NSString stringWithFormat:@"%@alipay-notify-url",[APIClient getDomain]]; //回调URL
    
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


//            block(retobj);
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
    user.mPhone = [obj objectForKeyMy:@"phone"];
    
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
        
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:info.mdata];
            
            if ([SUser currentUser].mPhone) {
                [dic setObject:[SUser currentUser].mPhone forKey:@"phone"];
            }
            [SUser saveUserInfo:dic];
            
        }
        block(info);
    }];

}

+(void)updateInfo:(NSString *)name sex:(NSString *)sex photo:(NSData *)photo block:(void(^)(SResBase* retobj))block{
    
    if (photo) {
        
        [SVProgressHUD showWithStatus:@"上传图片中.." maskType:SVProgressHUDMaskTypeClear];
        
        [SUser uploadPhoto:photo block:^(SResBase *retobj) {
            
            if (retobj.msuccess) {
                
                [SVProgressHUD showSuccessWithStatus:@"上传头像成功"];
                
                NSMutableDictionary* param =    NSMutableDictionary.new;
                [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
                [param setObject:[SUser currentUser].mName forKey:@"name"];
                
                if ([SUser currentUser].mSex) {
                    [param setObject:[SUser currentUser].mSex forKey:@"sex"];
                }else{
                    [param setObject:@"" forKey:@"sex"];
                }
                
                [param setObject:[SUser currentUser].mPhone forKey:@"phone"];
                [param setObject:[retobj.mdata objectForKey:@"photo_url"] forKey:@"photo_url"];
                [SUser saveUserInfo:param];
                
                if (name !=nil) {
                    
                    
                    
                    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
                    [param setObject:name forKey:@"name"];
                    if ([SUser currentUser].mSex) {
                        [param setObject:[SUser currentUser].mSex forKey:@"sex"];
                    }else{
                        [param setObject:@"" forKey:@"sex"];
                    }
                    [param setObject:[SUser currentUser].mPhone forKey:@"phone"];
                    
                    [SVProgressHUD showWithStatus:@"更新个人信息中" maskType:SVProgressHUDMaskTypeClear];
                    [[APIClient sharedClient] postUrl:@"update-persional-details" parameters:param call:^(SResBase *info) {
                        
                        if(info.msuccess){
                            [param setObject:[retobj.mdata objectForKey:@"photo_url"] forKey:@"photo_url"];
                            [SUser saveUserInfo:param];
                            
                        }
                        block(info);
                    }];

                }else{
                
                    block(retobj);
                }
                
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:retobj.mmsg];
            }
        }];
    }else{
        
        NSMutableDictionary* param =    NSMutableDictionary.new;
        [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
        [param setObject:name forKey:@"name"];
        [param setObject:sex forKey:@"sex"];
        
        [[APIClient sharedClient] postUrl:@"update-persional-details" parameters:param call:^(SResBase *info) {
            
            if(info.msuccess){
                
                [SUser saveUserInfo:param];
                
                
            }
            block(info);
        }];

    }

    
}

+(void)uploadPhoto:(NSData *)photo block:(void(^)(SResBase* retobj))block{
    
    NSString *URLString = @"upload-file";
    
    NSLog(@"%@", [[NSString alloc] initWithData:photo encoding:NSUTF8StringEncoding]);
    NSMutableString*  Url = [NSMutableString stringWithFormat:@"%@%@?employer_id=%@",[APIClient getDomain],URLString,[SUser currentUser].mId];
    NSMutableDictionary* param =    NSMutableDictionary.new;
    
    AFHTTPSessionManager *_afHTTPSessionManager = [APIClient sharedClient];

    [_afHTTPSessionManager.requestSerializer setAuthorizationHeaderFieldWithUsername:@"[USERNAME]" password:@"[PASSWORD]"];
    
    [_afHTTPSessionManager POST:Url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:photo name:@"screenshot" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //上传图片成功执行回调
        SResBase* retob = [[SResBase alloc] initWithObj:responseObject];
        
        block(retob);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传图片失败执行回调
        SResBase* retob = [[SResBase alloc] init];
        retob.msuccess = NO;
        retob.mmsg = error.description;
        
        block(retob);
    }];

}

//获取验证码
+(void)getCode:(NSString *)phone block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:phone forKey:@"phone"];
    [[APIClient sharedClient] postUrl:@"request-verify-code" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

//注册－－短信验证
+(void)registers:(NSString *)phone code:(NSString *)code block:(void(^)(SResBase* retobj))block{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:phone forKey:@"phone"];
    [param setObject:code forKey:@"code"];
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
    
    if(address_province!=nil)
        [param setObject:address_province forKey:@"address_province"];
    if(address_city!=nil)
        [param setObject:address_city forKey:@"address_city"];
    if(address_area!=nil)
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

//提交养老需求
+(void)uploadAdvancedBill:(NSString *)province city:(NSString *)city area:(NSString *)area name:(NSString *)name phone:(NSString *)phone submit_type:(NSString *)submit_type submit_content:(NSString *)submit_content block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    
    if(province!=nil)
        [param setObject:province forKey:@"province"];
    if(city!=nil)
        [param setObject:city forKey:@"city"];
    if(area!=nil)
        [param setObject:area forKey:@"area"];
    [param setObject:submit_content forKey:@"submit_content"];
    [param setObject:name forKey:@"name"];
    [param setObject:phone forKey:@"phone"];
    [param setObject:submit_type forKey:@"submit_type"];
    if ([SUser currentUser]) {
        [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    }
    
    
    [[APIClient sharedClient] postUrl:@"upload-advanced-bill" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];

}

//返回门店城市	/shop-city
+(void)getShopCity:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    
    [[APIClient sharedClient] postUrl:@"shop-group-city" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SCity *city = [[SCity alloc] initWithObj:dic];
                    
                    [array addObject:city];
                }
            }
            block(info,array);
            
        }
        else{
            block(info,nil);
        }
        
    }];
}


@end

@implementation SComment



@end

@implementation SOrder

- (id)initWithObj:(NSDictionary *)obj{
    
    if( self && obj )
    {
        [self fetchIt:obj];
        
        self.mMail_photo_url = [[APIClient sharedClient] photoUrl:self.mMail_photo_url];
    }
    
    return self;
}


+(void)getNewOrder:(void(^)(SResBase* retobj,int paid,int apointment,int waithire))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    
    [[APIClient sharedClient] postUrl:@"query-new-message" parameters:param call:^(SResBase *info) {
        if(info.msuccess){
            block(info,[[info.mdata objectForKey:@"waiting_for_paid"] intValue],[[info.mdata objectForKey:@"waiting_for_apointment"] intValue],[[info.mdata objectForKey:@"waiting_for_hire"] intValue]);
        }else{
            block(info,0,0,0);
        }
        
    }];
}

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

-(void)getDefaultAddress:(void(^)(SResBase* retobj,NSString *address))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"bill_id"];
    
    [[APIClient sharedClient] postUrl:@"query-default-meet-location" parameters:param call:^(SResBase *info) {
        
        block(info,[info.mdata objectForKey:@"address"]);
    }];
}

-(void)makeAppointment:(NSString *)meet_date_time meet_location:(NSString *)meet_location block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"bill_id"];
    [param setObject:meet_date_time forKey:@"meet_date_time"];
    [param setObject:meet_location forKey:@"meet_location"];
    
    [[APIClient sharedClient] postUrl:@"meet-maid" parameters:param call:^(SResBase *info) {
        block(info);
    }];
}

//完成订单支付	/complete-agency-pay	bill_id=xxxx(订单id)
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
            string = @"query-to-be-paid-bill";
            break;
        case 1:
            //待预约
            string = @"query-appointment-maid";
        
            break;
        case 2:
            //待聘用
            string = @"query-to-be-hire-maid";
            break;
        case 3:
            //已聘用
            string = @"query-hired-maid";
            break;
        case 4:
            //已完成
            string = @"query-complete-bill";
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
    [param setObject:@(_mBill_id) forKey:@"bill_id"];
    [param setObject:@(_mMail_id) forKey:@"maid_id"];
    
    [[APIClient sharedClient] postUrl:@"hire-maid" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];

}

//解聘阿姨	/dismiss-maid	bill_id=48(订单id)&maid_id=3(阿姨id)
-(void)dismissMaid:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mBill_id) forKey:@"bill_id"];
    [param setObject:@(_mMail_id) forKey:@"maid_id"];
    
    [[APIClient sharedClient] postUrl:@"dismiss-maid" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];

}

//重新计算订单价格（包括了商品与折扣卷）	/recalculate-amount	bill_id=1301(订单id)&goods_ids=1,3,2(商品id)&goods_count=1,1,2(商品对应的数量&app_trancation_amount=320(app端计算的交易金额)
-(void)recalculateAmount:(NSString *)goods_ids goods_count:(NSString *)goods_count app_trancation_amount:(float)app_trancation_amount block:(void(^)(SResBase* retobj,float trancation_amount))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(_mId) forKey:@"bill_id"];
    [param setObject:goods_ids forKey:@"goods_ids"];
    [param setObject:goods_count forKey:@"goods_count"];
    [param setObject:@(app_trancation_amount) forKey:@"app_trancation_amount"];
    
    [[APIClient sharedClient] postUrl:@"recalculate-amount" parameters:param call:^(SResBase *info) {
        
        block(info,[[info.mdata objectForKeyMy:@"trancation_amount"] floatValue]);
        
    }];

}

@end


@implementation SOrderDetail

- (id)initWithObj:(NSDictionary *)obj{
    
    if( self && obj )
    {
        [self fetchIt:obj];
        
        if (_mGoods.count>0) {
            
            NSMutableArray *arr = [NSMutableArray new];
            for (NSDictionary *dic in _mGoods) {
                
                SGoods *banner = [[SGoods alloc] initWithObj:dic];
                
                [arr addObject:banner];
            }
            
            _mGoods = arr;
        }
        
        
    }
    
    return self;
}

+(void)getOrderDetail:(int)bill_id block:(void (^)(SResBase *, SOrderDetail *))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(bill_id) forKey:@"bill_id"];
    
    [[APIClient sharedClient] postUrl:@"query-bill-detail" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            SOrderDetail *order = [[SOrderDetail alloc] initWithObj:info.mdata];
            
            block(info,order);
            
        }else{
            
            block(info,nil);
        }

    }];
}

//订单投诉反馈	/submit-bill-suggest	employer_id=2(雇主ID)&bill_id=1760(订单ID)&content=aaa(投诉内容)&refund=true(是否退款，值为2个:true、false)
-(void)submitSuggest:(NSString *)content refund:(int)refund block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"bill_id"];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:content forKey:@"content"];
     [param setObject:@(refund) forKey:@"refund"];
    
    [[APIClient sharedClient] postUrl:@"submit-bill-suggest" parameters:param call:^(SResBase *info) {
        block(info);
    }];

}

@end

@implementation SHour


@end

@implementation SAuntInfo

- (id)initWithObj:(NSDictionary *)obj{
    
    if( self && obj )
    {
        [self fetchIt:obj];
        
        self.mPhoto_url = [[APIClient sharedClient] photoUrl:self.mPhoto_url];
    }
    
    return self;
}

//找保姆
+(void)findNurse:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night prio_province:(NSString *)prio_province star:(int)star block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;

    if (prio_province == nil) {
        prio_province = @"不限";
    }
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:@(min_age) forKey:@"min_age"];
    [param setObject:@(max_age) forKey:@"max_age"];
    [param setObject:@(star) forKey:@"star"];
    [param setObject:[Util JSONString:over_night] forKey:@"over_night"];
    [param setObject:[Util JSONString:prio_province] forKey:@"prio_provinces"];
    
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
+(void)findAccompany:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area  over_night:(NSString *)over_night sex:(NSString *)sex care_type:(NSString *)care_type star:(int)star block:(void(^)(SResBase* retobj,NSArray *arr))block{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(star) forKey:@"star"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
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
+(void)findMatron:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area have_auth:(NSString *)have_auth star:(int)star block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;

    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:@(star) forKey:@"star"];
    
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

//employer_id=xx(用户id)&work_province=xxx(服务地点-省)&work_city=xxx(服务地点-市)&work_area=xxx(服务地点-区)&count=2(服务人数)&prio_province=东三省&prio_province=河北(优先筛选籍贯)&service_address=xxxxx(服务地点详细地址)&additional=xxx(对小时工的附加要求)&service_time=09:00(服务时段,格式为hh:MM)&service_duration=1小时(服务时长,值为:1小时、2小时、3小时、4小时、5小时、6小时、7小时、8小时) 
//找小时工
+(void)findHourWorker:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area service_address:(NSString *)service_address additional:(NSString *)additional service_items:(NSString *)service_items service_time:(NSString *)service_time service_duration:(int)service_duration service_count:(int)service_count block:(void(^)(SResBase* retobj,SOrder *order))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;

    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:[Util JSONString:service_address] forKey:@"service_address"];
    [param setObject:[Util JSONString:additional] forKey:@"additional"];
    [param setObject:[Util JSONString:service_time] forKey:@"service_time"];
    [param setObject:@(service_duration) forKey:@"service_duration"];
    [param setObject:@(service_count) forKey:@"service_count"];
    [param setObject:[Util JSONString:service_items] forKey:@"service_items"];

    [[APIClient sharedClient] postUrl:@"hour-worker-agency-bill" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            SOrder *order = [[SOrder alloc] initWithObj:info.mdata];
            block(info,order);
            
        }
        else{
            block(info,nil);
        }
    }];

}

+(void)findHourByAddress:(NSString *)province city:(NSString *)city area:(NSString *)area block:(void(^)(SResBase* retobj,int hour))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    
    [param setObject:province forKey:@"province"];
    [param setObject:city forKey:@"city"];
    [param setObject:area forKey:@"area"];
    
    [[APIClient sharedClient] postUrl:@"query-hourworker-atleast-duration" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            block(info,[[info.mdata objectForKey:@"duration"] intValue]);
        }
        else{
            block(info,2);
        }
    }];

}

//查看各地区小时工各项价格
+(void)hourWorkerByAddress:(NSString *)province city:(NSString *)city area:(NSString *)area block:(void(^)(SResBase* retobj,NSArray *hours))block{
    
    NSMutableDictionary* param =    NSMutableDictionary.new;
    
    [param setObject:province forKey:@"province"];
    [param setObject:city forKey:@"city"];
    [param setObject:area forKey:@"area"];
    
    [[APIClient sharedClient] postUrl:@"query-hour-worker-service-item-price-integration" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SHour *aunt = [[SHour alloc] initWithObj:dic];
                    
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
+(void)findChildCare:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night prio_province:(NSString *)prio_province block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    if (prio_province == nil) {
        prio_province = @"不限";
    }
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:[Util JSONString:work_province] forKey:@"work_province"];
    [param setObject:[Util JSONString:work_city] forKey:@"work_city"];
    [param setObject:[Util JSONString:work_area] forKey:@"work_area"];
    [param setObject:@(min_age) forKey:@"min_age"];
    [param setObject:@(max_age) forKey:@"max_age"];
    [param setObject:[Util JSONString:over_night] forKey:@"over_night"];
    [param setObject:[Util JSONString:prio_province] forKey:@"prio_provinces"];
    
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

-(void)getComment:(int)page block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:@(_mId) forKey:@"maid_id"];
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

-(void)submitComment:(NSString *)comment star_count:(int)star_count block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param =    NSMutableDictionary.new;
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(_mId) forKey:@"maid_id"];
    [param setObject:[Util JSONString:comment] forKey:@"comment"];
    [param setObject:@(star_count) forKey:@"star_count"];
    
    [[APIClient sharedClient] postUrl:@"submit-comment" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

+(void)submitOrder:(NSString *)array work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area service_date:(NSString *)service_date service_address:(NSString *)service_address additional:(NSString *)additional service_time:(NSString *)service_time service_duration:(NSString *)service_duration work_type:(NSString *)work_type over_night:(NSString *)over_night care_type:(NSString *)care_type block:(void(^)(SResBase* retobj,SOrder *order))block{

    
    
    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    if (service_date) {
        [param setObject:service_date forKey:@"service_date"];
    }
    
    [param setObject:work_province forKey:@"work_province"];
    [param setObject:work_city forKey:@"work_city"];
    [param setObject:work_area forKey:@"work_area"];
    [param setObject:service_address forKey:@"service_address"];
    [param setObject:array forKey:@"maid_ids"];
    
    //小时工
    if(service_duration){
        [param setObject:service_duration forKey:@"service_duration"];
    }
    if (service_time) {
          [param setObject:service_time forKey:@"service_time"];
    }
    
    if (over_night) {
        [param setObject:over_night forKey:@"over_night"];
    }
    
    if (care_type) {
        [param setObject:care_type forKey:@"care_type"];
    }
    
    if (additional) {
        [param setObject:additional forKey:@"additional"];
    }
    
    
    NSString *string = @"";
    
    if ([work_type isEqualToString:@"小时工"]) {
        string = @"hour-worker-agency-bill";
    }else{
        string = @"agency-bill";
        if (work_type) {
            [param setObject:work_type forKey:@"work_type"];
        }
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


//定金支付提交信息
+(void)customBill:(NSString *)sex min_age:(int)min_age max_age:(int)max_age star:(int)star type:(NSString *)type work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area work_address:(NSString *)work_address province:(NSString *)province service_time:(NSString *)service_time service_duration:(NSString *)service_duration over_night:(NSString *)over_night care_type:(NSString *)care_type additional:(NSString *)additional block:(void(^)(SResBase* retobj,NSString *bid,int day,int num))block{

    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(min_age) forKey:@"min_age"];
    [param setObject:@(star) forKey:@"star"];
    if (max_age>0) {
        [param setObject:@(max_age) forKey:@"max_age"];
    }
    if (service_duration){
        [param setObject:service_duration forKey:@"service_duration"];
    }
    if (sex) {
        [param setObject:sex forKey:@"sex"];
    }
    if (type) {
        [param setObject:type forKey:@"type"];
    }
    if (work_province) {
        [param setObject:work_province forKey:@"work_province"];
    }
    if (work_city) {
        [param setObject:work_city forKey:@"work_city"];
    }
    if (work_area) {
        [param setObject:work_area forKey:@"work_area"];
    }
    if (work_address) {
        [param setObject:work_address forKey:@"work_address"];
    }
    if (province) {
        [param setObject:province forKey:@"province"];
    }
    if (service_time) {
        [param setObject:service_time forKey:@"service_time"];
    }
    if (over_night) {
        [param setObject:over_night forKey:@"over_night"];
    }
    if (care_type) {
        [param setObject:care_type forKey:@"care_type"];
    }
    if (additional) {
        [param setObject:additional forKey:@"additional"];
    }
    
    [[APIClient sharedClient] postUrl:@"custom-bill" parameters:param call:^(SResBase *info) {
            
            block(info,[[info.mdata objectForKeyMy:@"id"] stringValue],[[info.mdata objectForKeyMy:@"remain_day"] intValue],[[info.mdata objectForKeyMy:@"ranking"] intValue]);
    }];

}

@end


@implementation SGoods

- (id)initWithObj:(NSDictionary *)obj{
    
    if( self && obj )
    {
        [self fetchIt:obj];
        
        
        self.mPreview_img_path = [NSString stringWithFormat:@"%@%@",[APIClient getDomain],self.mPreview_img_path];
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSString *str in _mPoll_img_path) {
            
            [arr addObject:[NSString stringWithFormat:@"%@%@",[APIClient getDomain],str]];
        }
        _mPoll_img_path = arr;
        
        NSMutableArray *arr2 = [NSMutableArray new];
        for (NSString *str in _mDetail_img_path) {
            
            [arr2 addObject:[NSString stringWithFormat:@"%@%@",[APIClient getDomain],str]];
        }
        _mDetail_img_path = arr2;
    }
    
    return self;
}

+(void)getGoodsByCategory:(NSString *)category block:(void (^)(SResBase *, NSArray *))block{

    
    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:category forKey:@"category"];
    
    [[APIClient sharedClient] postUrl:@"query-goods-by-category" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SGoods *goods = [[SGoods alloc] initWithObj:dic];
                    
                    [array addObject:goods];
                }
            }
            block(info,array);

        }else{
            
            block(info,nil);
        }
    }];
}

+(void)searchByKey:(NSString *)search_key block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:search_key forKey:@"search_key"];
    
    [[APIClient sharedClient] postUrl:@"search-goods" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SGoods *goods = [[SGoods alloc] initWithObj:dic];
                    
                    [array addObject:goods];
                }
            }
            block(info,array);
            
        }else{
            
            block(info,nil);
        }
    }];

}

-(void)getDetail:(void(^)(SResBase* retobj,SGoods *goods))block{

    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:@(_mGoods_id) forKey:@"goods_id"];
    
    [[APIClient sharedClient] postUrl:@"query-goods-by-id" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            SGoods *goods = [self initWithObj:info.mdata];
            
            block(info,goods);
            
        }else{
            
            block(info,nil);
        }
    }];

}

///add-goods-to-cart	employer_id=2(雇主id)&goods_ids=2,3(商品的id)&goods_increments=1,2(商品的增量)
-(void)addGoods:(int)num block:(void(^)(SResBase* retobj))block{
    
    
    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(_mGoods_id) forKey:@"goods_ids"];
    
    [param setObject:@(num) forKey:@"goods_increments"];
    
    
    [[APIClient sharedClient] postUrl:@"add-goods-to-cart" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

-(void)delGoods:(void(^)(SResBase* retobj))block{
    
    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(_mGoods_id) forKey:@"goods_ids"];
    [param setObject:@(-1) forKey:@"goods_increments"];
    
    [[APIClient sharedClient] postUrl:@"add-goods-to-cart" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

-(void)delAllGoods:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:@(_mGoods_id) forKey:@"goods_ids"];
    [param setObject:[NSString stringWithFormat:@"-%d",_mCount] forKey:@"goods_increments"];
    
    [[APIClient sharedClient] postUrl:@"add-goods-to-cart" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];
}

//查看购物车	/query-cart-by-employer-id	employer_id=2(雇主id)
+(void)getCartData:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    
    [[APIClient sharedClient] postUrl:@"query-cart-by-employer-id" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SGoods *goods = [[SGoods alloc] initWithObj:dic];
                    
                    [array addObject:goods];
                }
            }
            block(info,array);
            
        }else{
            
            block(info,nil);
        }
    }];

}

@end

@implementation SRecomend



@end

@implementation SShops


- (id)initWithObj:(NSDictionary *)obj{
    
    if( self && obj )
    {
        [self fetchIt:obj];
        
        if (_mGoods_banner) {
            
            NSMutableArray *arr = [NSMutableArray new];
            for (NSDictionary *dic in _mGoods_banner) {
                
                SBanner *banner = [[SBanner alloc] initWithObj:dic];
                
                [arr addObject:banner];
            }
            
            _mGoods_banner = arr;
        }
        
        if (_mGoods_recommend) {
            
            NSMutableArray *arr = [NSMutableArray new];
            for (NSDictionary *dic in _mGoods_recommend) {
                
                SGoods *goods = [[SGoods alloc] initWithObj:dic];
                
                [arr addObject:goods];
            }
            
            _mGoods_recommend = arr;
        }
       
    }
    
    return self;
}


+(void)getShopData:(void(^)(SResBase* retobj,SShops *shops))block{

    [[APIClient sharedClient] postUrl:@"goods-index-page" parameters:nil call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            SShops *shop = [[SShops alloc] initWithObj:info.mdata];
            
            block(info,shop);
            
        }else{
            
            block(info,nil);
        }
    }];

}

@end

@implementation SCoupon

//获取会员券列表
+(void)getCoupon:(NSString *)type status:(NSString *)status block:(void(^)(SResBase* retobj,NSArray *arr))block{

    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:status forKey:@"status"];
    
    [[APIClient sharedClient] postUrl:@"query-employer-coupon" parameters:param call:^(SResBase *info) {
        
        if (info.msuccess) {
            
            NSMutableArray *array = [NSMutableArray new];
            if (info.mdata) {
                for (NSDictionary *dic in info.mdata) {
                    
                    SCoupon *coupon = [[SCoupon alloc] initWithObj:dic];
                    
                    [array addObject:coupon];
                }
            }
            block(info,array);
            
        }else{
            
            block(info,nil);
        }
    }];
 
}

//兑换码兑换
+(void)exangeCode:(NSString *)gift_code block:(void(^)(SResBase* retobj))block{

    NSMutableDictionary* param = [NSMutableDictionary new];
    [param setObject:[SUser currentUser].mId forKey:@"employer_id"];
    [param setObject:gift_code forKey:@"gift_code"];
    
    [[APIClient sharedClient] postUrl:@"exange-gift-code" parameters:param call:^(SResBase *info) {
        
        block(info);
    }];

}

@end




