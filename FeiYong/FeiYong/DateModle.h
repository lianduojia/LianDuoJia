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

@interface SAppInfo : SAutoEx

//支付需要跳出到APP,这里记录回调
@property (nonatomic,strong)    void(^mPayBlock)(SResBase* resb);

+(SAppInfo*)shareClient;

@end


//[{"address_id":1,"employer_id":2,"address_area":"南关区","link_man":"XFC","link_phone":"16866888866","address_province":"吉林省","address_city":"长春市","address_detail":"qqqq"}]}
@interface SAddress : SAutoEx

@property (nonatomic,assign) int        mAddress_id;
@property (nonatomic,strong) NSString*  mLink_man;
@property (nonatomic,strong) NSString*  mLink_phone;
@property (nonatomic,strong) NSString*  mAddress_province;
@property (nonatomic,strong) NSString*  mAddress_city;
@property (nonatomic,strong) NSString*  mAddress_area;
@property (nonatomic,strong) NSString*  mAddress_detail;

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

+(void)aliPay:(NSString *)title orderNo:(NSString *)orderNo price:(float)price block:(void(^)(SResBase* retobj))block;


@end

@interface SUser : SAutoEx

@property (nonatomic,strong)                NSString *mId;
@property (nonatomic,strong)                NSString *mPhone;
@property (nonatomic,strong)                NSString *mName;
@property (nonatomic,strong)                NSString *mPhoto_url;
@property (nonatomic,strong)                NSString *mSex;

//返回当前用户
+(SUser*)currentUser;

//判断是否需要登录
+(BOOL)isNeedLogin;

//退出登陆
+(void)logout;

//查看个人资料	/query-personal-details	employer_id	{"_no":1000,"_msg":"操作成功","_data":{"employer_id":2,"sex":"女","photo_url":"","name":"18686683694"}}
+(void)getDetail:(void(^)(SResBase* retobj))block;

//更新个人资料	/update-persional-details	employer_id=2(雇主id)&name=xxx(要更新的昵称)&sex=男(更新的性别数据:男、女)&photo_url=./aaa/bbb/ccc.png(照片的url数据)
+(void)updateInfo:(NSString *)name sex:(NSString *)sex photo_url:(NSString *)photo_url block:(void(^)(SResBase* retobj))block;

//注册－－短信验证
+(void)registers:(NSString *)phone code:(NSString *)code block:(void(^)(SResBase* retobj))block;

//注册
+(void)regist:(NSString *)name pwd:(NSString *)pwd phone:(NSString *)phone block:(void(^)(SResBase* retobj))block;

//登陆
+(void)login:(NSString *)name code:(NSString *)pwd block:(void(^)(SResBase* retobj))block;

//忘记密码
+(void)forgetPwd:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code block:(void(^)(SResBase* retobj))block;

//意见反馈	/feedback	employer_id=2(雇主ID)&salutation=xx(称谓)&content=xxxxxxx(意见反馈内容)
+(void)feedBack:(NSString *)salutation content:(NSString *)content block:(void(^)(SResBase* retobj))block;

//查询余额	/query-balance	employer_id=2(雇主ID)
+(void)getBalance:(void(^)(SResBase* retobj))block;

//查看地址	/query-address	employer_id=2(雇主ID)
+(void)getAddress:(void(^)(SResBase* retobj,NSArray *arr))block;

//新增地址	/add-address	employer_id=2(雇主ID)&address_province=北京市(地址-省)&address_city=北京市(地址-市)&address_area=朝阳区(地址-区)&address_detail=xxxxxx（详细地址)&link_man=cf(联系人)&link_phone=1111111111(联系电话)
+(void)editAddress:(int)address_id address_province:(NSString *)address_province address_city:(NSString *)address_city address_area:(NSString *)address_area address_detail:(NSString *)address_detail link_man:(NSString *)link_man link_phone:(NSString *)link_phone block:(void(^)(SResBase* retobj))block;

//商铺加盟提交信息	/shop-join employer_id=2(雇主ID)&address_id=3&address_province=北京市(地址-省)&address_city=北京市(地址-市)&address_area=朝阳区(地址-区)&address_detail=xxxxxx（详细地址)&link_man=cf(联系人)&link_phone=1111111111(联系电话)
+(void)joinShop:(NSString *)address_province address_city:(NSString *)address_city address_area:(NSString *)address_area link_man:(NSString *)link_man link_phone:(NSString *)link_phone block:(void(^)(SResBase* retobj))block;

@end


//评价对象
//[{"employer_id":2,"maid_id":5,"employer_photo_url":"","employer_name":"18686683694","comment":"工作认真，做事情细致"},

@interface SComment : SAutoEx

@property (nonatomic,assign)                int mEmployer_id;                    //用户id
@property (nonatomic,assign)                int mMaid_id;                        //阿姨id
@property (nonatomic,strong)                NSString* mEmployer_photo_url;       //用户头像
@property (nonatomic,strong)                NSString* mEmployer_name;            //用户姓名
@property (nonatomic,strong)                NSString* mComment;                  //评价内容
@property (nonatomic,strong)                NSString* mComment_type;             //评价类型
@property (nonatomic,strong)                NSString* mDate;                     //评价时间


@end

@interface SOrder : SAutoEx

//{"amount":7000,"no":"BL2016061000001","maids":["月嫂3","月嫂3","月嫂3","月嫂3"],"maid_count":4,"goods_info":"中介费"}
//{"meet_location":"万达广场","mail_name":"月嫂1","meet_date":"2016-04-02","mail_work_type":"陪护","meet_time":"09:00","mail_photo_url":"","mail_id":3}

@property (nonatomic,assign)                int         mId;
@property (nonatomic,assign)                int         mBill_id;
@property (nonatomic,assign)                int         mAmount;
@property (nonatomic,strong)                NSString*   mAdditional;
@property (nonatomic,strong)                NSString*   mStatus;
@property (nonatomic,strong)                NSString*   mNo;
@property (nonatomic,strong)                NSArray*    mMaid;
@property (nonatomic,strong)                NSArray*    mMaids;
@property (nonatomic,assign)                int         mMaid_count;
@property (nonatomic,strong)                NSString*   mGoods_info;
@property (nonatomic,strong)                NSString*   mWork_type; //工作类型
@property (nonatomic,strong)                NSString*   mTime;


//约见阿姨后的信息
@property (nonatomic,strong)                NSString* mMeet_location;                     //见面地址
@property (nonatomic,strong)                NSString* mMail_name;                         //阿姨名称
@property (nonatomic,strong)                NSString* mMeet_date;                     //见面日期
@property (nonatomic,strong)                NSString* mMail_work_type;                     //阿姨类型
@property (nonatomic,strong)                NSString* mMeet_time;                     //见面时间
@property (nonatomic,strong)                NSString* mMail_photo_url;                     //头像
@property (nonatomic,assign)                int       mMail_id;                     //阿姨id


//根据订单id获得订单号	/query-billno-by-billid	bill_id=62(订单id)
-(void)getOrderNo:(void(^)(SResBase* retobj,NSString *orderNo))block;

//约见阿姨,确定预约日期、时间、地点	/make-an-appointment	bill_id=xxxx(订单id)&meet_date=2016-06-12(预约日期)&meet_time=09:30(预约时间)&meet_location=xxxxxxxxxxx(预约地点)
-(void)makeAppointment:(NSString *)meet_date meet_time:(NSString *)meet_time meet_location:(NSString *)meet_location block:(void(^)(SResBase* retobj))block;

//完成订单中介费支付	/complete-agency-pay	bill_id=xxxx(订单id)
-(void)payOK:(void(^)(SResBase* retobj))block;

//订单列表
+(void)getOrderList:(int)type block:(void(^)(SResBase* retobj,NSArray *arr))block;


//雇佣阿姨	/employ-maid	employer_id=2(雇主id)&bill_id=48(订单id)&maid_id=3(阿姨id)
-(void)employMaid:(void(^)(SResBase* retobj))block;

@end

@interface SAuntInfo : SAutoEx

@property (nonatomic,assign)                int       mId;
@property (nonatomic,strong)                NSString *mName;                    //姓名
@property (nonatomic,strong)                NSString *mPhoto_url;               //头像地址
@property (nonatomic,strong)                NSString *mLeave;                   //星级
@property (nonatomic,strong)                NSString *mLiving_province;         //籍贯 省
@property (nonatomic,strong)                NSString *mLiving_city;             //籍贯 市
@property (nonatomic,strong)                NSString *mLiving_area;             //籍贯 地区
@property (nonatomic,strong)                NSString *mWork_province;           //工作 省
@property (nonatomic,strong)                NSString *mWork_city;               //工作 市
@property (nonatomic,strong)                NSString *mWork_area;               //工作 地区
@property (nonatomic,strong)                NSString *mConstellation;           //星座
@property (nonatomic,strong)                NSString *mWork_type;               //工作类型
@property (nonatomic,assign)                int       mWorking_years;           //工龄
@property (nonatomic,assign)                int       mAge;                     //年龄
@property (nonatomic,assign)                int       mPay;                     //月薪

@property (nonatomic,assign)                int       mMaid_id;
@property (nonatomic,strong)                NSString *mMaid_name;                    //姓名

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

//提交阿姨评论	/submit-comment	employer_id=xx(用户id)&maid_id=7(阿姨id)&comment_type=一面之缘(评论类型:工作评价、一面之缘、线上评价)&comment=aaaaa(评价内容)&star_count=5(用户的评价星数)

-(void)submitComment:(NSString *)comment_type comment:(NSString *)comment star_count:(int)star_count block:(void(^)(SResBase* retobj))block;

//点击支付中介费生成订单(小时工以外工种订单)	/agency-bill	employer_id=xx(用户ID)&maid_id=3(准备预约阿姨的id)&maid_id=4(准备预约阿姨的id)&maid_id=5(准备预约阿姨的id)&maid_id=7(准备预约阿姨的id)&service_date=2016-03-03(服务时间,格式为yyyy-MM-dd)&service_address=xxxxx(服务地点详细地址)&additional=xxx(对阿姨的附加要求)

//&additional=xxx(对小时工的附加要求)&service_time=09:00(服务时段,格式为hh:MM)&service_duration=1小时(服务时长,值为:1小时、2小时、3小时、4小时、5小时、6小时、7小时、8小时)
+(void)submitOrder:(NSArray *)array service_date:(NSString *)service_date service_address:(NSString *)service_address additional:(NSString *)additional service_time:(NSString *)service_time service_duration:(NSString *)service_duration block:(void(^)(SResBase* retobj,SOrder *order))block;

@end


















