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

@interface Order : SAutoEx


/*********************************支付四要素*********************************/

//商户在支付宝签约时，支付宝为商户分配的唯一标识号(以2088开头的16位纯数字)。
@property (nonatomic, copy) NSString *partner;

//卖家支付宝账号对应的支付宝唯一用户号(以2088开头的16位纯数字),订单支付金额将打入该账户,一个partner可以对应多个seller_id。
@property (nonatomic, copy) NSString *sellerID;

//商户网站商品对应的唯一订单号。
@property (nonatomic, copy) NSString *outTradeNO;

//该笔订单的资金总额，单位为RMB(Yuan)。取值范围为[0.01，100000000.00]，精确到小数点后两位。
@property (nonatomic, copy) NSString *totalFee;



/*********************************商品相关*********************************/
//商品的标题/交易标题/订单标题/订单关键字等。
@property (nonatomic, copy) NSString *subject;

//对一笔交易的具体描述信息。如果是多种商品，请将商品描述字符串累加传给body。
@property (nonatomic, copy) NSString *body;



/*********************************其他必传参数*********************************/

//接口名称，固定为mobile.securitypay.pay。
@property (nonatomic, copy) NSString *service;

//商户网站使用的编码格式，固定为utf-8。
@property (nonatomic, copy) NSString *inputCharset;

//支付宝服务器主动通知商户网站里指定的页面http路径。
@property (nonatomic, copy) NSString *notifyURL;



/*********************************可选参数*********************************/

//支付类型，1：商品购买。(不传情况下的默认值)
@property (nonatomic, copy) NSString *paymentType;

//具体区分本地交易的商品类型,1：实物交易; (不传情况下的默认值),0：虚拟交易; (不允许使用信用卡等规则)。
@property (nonatomic, copy) NSString *goodsType;

//支付时是否发起实名校验,F：不发起实名校验; (不传情况下的默认值),T：发起实名校验;(商户业务需要买家实名认证)
@property (nonatomic, copy) NSString *rnCheck;

//标识客户端。
@property (nonatomic, copy) NSString *appID;

//标识客户端来源。参数值内容约定如下：appenv=“system=客户端平台名^version=业务系统版本”
@property (nonatomic, copy) NSString *appenv;

//设置未付款交易的超时时间，一旦超时，该笔交易就会自动被关闭。当用户输入支付密码、点击确认付款后（即创建支付宝交易后）开始计时。取值范围：1m～15d，或者使用绝对时间（示例格式：2014-06-13 16:00:00）。m-分钟，h-小时，d-天，1c-当天（1c-当天的情况下，无论交易何时创建，都在0点关闭）。该参数数值不接受小数点，如1.5h，可转换为90m。
@property (nonatomic, copy) NSString *itBPay;

//商品地址
@property (nonatomic, copy) NSString *showURL;

//业务扩展参数，支付宝特定的业务需要添加该字段，json格式。 商户接入时和支付宝协商确定。
@property (nonatomic, strong) NSMutableDictionary *outContext;

-(void)aliPay:(void(^)(SResBase* retobj))block;


@end

@interface SUser : SAutoEx

@property (nonatomic,strong)                NSString *mId;
@property (nonatomic,strong)                NSString *mPhone;
@property (nonatomic,strong)                NSString *mName;


//返回当前用户
+(SUser*)currentUser;

//判断是否需要登录
+(BOOL)isNeedLogin;

//退出登陆
+(void)logout;

//注册－－短信验证
+(void)registers:(NSString *)phone code:(NSString *)code block:(void(^)(SResBase* retobj))block;

//注册
+(void)regist:(NSString *)name pwd:(NSString *)pwd phone:(NSString *)phone block:(void(^)(SResBase* retobj))block;

//登陆
+(void)login:(NSString *)name code:(NSString *)pwd block:(void(^)(SResBase* retobj))block;

//忘记密码
+(void)forgetPwd:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code block:(void(^)(SResBase* retobj))block;

@end

@interface SAuntInfo : SAutoEx

//{"living_province":"","id":1,"leave":1,"living_area":"",
//    "working_years":0,"age":28,"pay":10000,"name":"路人甲","living_city":"",
//    "work_area":"朝阳区","work_city":"长春市","work_province":"吉林省"}

@property (nonatomic,assign)                int       mId;
@property (nonatomic,strong)                NSString *mName;                    //姓名
@property (nonatomic,strong)                NSString *mLeave;                   //星级
@property (nonatomic,strong)                NSString *mLiving_province;         //籍贯 省
@property (nonatomic,strong)                NSString *mLiving_city;             //籍贯 市
@property (nonatomic,strong)                NSString *mLiving_area;             //籍贯 地区
@property (nonatomic,strong)                NSString *mWork_province;           //工作 省
@property (nonatomic,strong)                NSString *mWork_city;               //工作 市
@property (nonatomic,strong)                NSString *mWork_area;               //工作 地区
@property (nonatomic,assign)                int       mWorking_years;           //工龄
@property (nonatomic,assign)                int       mAge;                     //年龄
@property (nonatomic,assign)                int       mPay;                     //月薪

//找保姆   find-nurse
//employer_id=xx(用户id)
//work_province=xxx(服务地点-省)
//&work_city=xxx(服务地点-市)
//&work_area=xxx(服务地点-区)
//&min_age=0(最小年龄)
//&max_age=100(最大年龄)
//&over_night=住家(是否住家:住家、白班)

+(void)findNurse:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night block:(void(^)(SResBase* retobj,NSArray *arr))block;


//找陪护 /find-accompany
+(void)findAccompany:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night sex:(NSString *)sex care_type:(NSString *)care_type block:(void(^)(SResBase* retobj,NSArray *arr))block;

///找月嫂  find-maternity-matron	employer_id=xx(用户id)&work_province=xxx(服务地点-省)&work_city=xxx(服务地点-市)&work_area=xxx(服务地点-区)&have_auth=xxx(有无证书:有、无)
+(void)findMatron:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area have_auth:(NSString *)have_auth block:(void(^)(SResBase* retobj,NSArray *arr))block;

//找小时工	/find-hour-worker	employer_id=xx(用户id)&work_province=xxx(服务地点-省)&work_city=xxx(服务地点-市)&work_area=xxx(服务地点-区)&count=2(服务人数)
+(void)findHourWorker:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area count:(int)count block:(void(^)(SResBase* retobj,NSArray *arr))block;

//找育儿嫂  /find-child-care    employer_id=xx(用户id)&work_province=xxx(服务地点-省)&work_city=xxx(服务地点-市)&work_area=xxx(服务地点-区)&min_age=0(最小年龄)&max_age=100(最大年龄)&over_night=住家(是否住家:住家、白班)
+(void)findChildCare:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night block:(void(^)(SResBase* retobj,NSArray *arr))block;

//放弃阿姨数据	/delete-maid	employer_id=xx(用户id)&maid_id=xxxx(对应的阿姨数据的id)
-(void)deleteThis:(void(^)(SResBase* retobj))block;

//展示阿姨的评价	/show-comment	maid_id=5(阿姨的id)&comment_type=工作评价(评论类型:工作评价、一面之缘、线上评价。该参数为可选参数,不写该参数显示全部类型的评论)&page=0(当前显示第几页的评论,每页返回10条数据)
-(void)getComment:(NSString *)comment_type page:(int)page block:(void(^)(SResBase* retobj,NSArray *arr))block;

@end


