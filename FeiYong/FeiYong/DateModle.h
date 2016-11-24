//
//  DateModle.h
//  FeiYong
//
//  Created by 周大钦 on 16/5/27.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

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


@property (nonatomic,assign)  float mlat;
@property (nonatomic,assign)  float mlng;
@property (nonatomic,strong)  NSString *mProvince;
@property (nonatomic,strong)  NSString *mCity;
@property (nonatomic,strong)  NSString *mArea;
@property (nonatomic,strong)  NSString *mAddress;

//支付需要跳出到APP,这里记录回调
@property (nonatomic,strong)    void(^mPayBlock)(SResBase* resb);

+(SAppInfo*)shareClient;

-(void)getLocation;

+(int)calcDist:(float)lat lng:(float)lng;

@end

@interface SBanner : SAutoEx

@property (nonatomic,strong) NSString *mBanner_url;
@property (nonatomic,strong) NSString *mBanner_img_path;

+(void)getBanner:(void(^)(SResBase* retobj,NSArray* arr))block;

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

@interface SShop : SAutoEx
@property (nonatomic,strong) NSString*  mDistance;
@property (nonatomic,strong) NSString*  mGps;
@property (nonatomic,strong) NSString*  mPhone;
@property (nonatomic,strong) NSString*  mP_province;
@property (nonatomic,strong) NSString*  mP_city;
@property (nonatomic,strong) NSString*  mP_area;
@property (nonatomic,strong) NSString*  mP_address;
@property (nonatomic,strong) NSString*  mName;

@end

@interface SCity : SAutoEx

@property (nonatomic,strong) NSString*  mProvince;
@property (nonatomic,strong) NSString*  mCity;
@property (nonatomic,strong) NSString*  mIcon;

//根据城市返回门店数据	/query-shop-by-city	city=北京市(城市数据)
-(void)getShopByCity:(void(^)(SResBase* retobj,NSArray* arr))block;

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

+(void)aliPay:(NSString *)title orderNo:(NSString *)orderNo price:(float)price detail:(NSString *)detail block:(void(^)(SResBase* retobj))block;


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
+(void)updateInfo:(NSString *)name sex:(NSString *)sex photo:(NSData *)photo block:(void(^)(SResBase* retobj))block;
+(void)uploadPhoto:(NSData *)photo block:(void(^)(SResBase* retobj))block;

//获取验证码
+(void)getCode:(NSString *)phone block:(void(^)(SResBase* retobj))block;
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

//返回门店城市	/shop-city
+(void)getShopCity:(void(^)(SResBase* retobj,NSArray *arr))block;

//提交养老需求
+(void)uploadAdvancedBill:(NSString *)province city:(NSString *)city area:(NSString *)area name:(NSString *)name phone:(NSString *)phone submit_type:(NSString *)submit_type submit_content:(NSString *)submit_content block:(void(^)(SResBase* retobj))block;



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



@property (nonatomic,assign)                int         mId;
@property (nonatomic,assign)                int         mBill_id;
@property (nonatomic,assign)                float       mAll_amount; //总价格
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
@property (nonatomic,assign)                int         mFirst;

//约见阿姨后的信息
@property (nonatomic,strong)                NSString* mMeet_location;                     //见面地址
@property (nonatomic,strong)                NSString* mMail_name;                         //阿姨名称
@property (nonatomic,strong)                NSString* mMeet_date;                     //见面日期
@property (nonatomic,strong)                NSString* mMail_work_type;                     //阿姨类型
@property (nonatomic,strong)                NSString* mMeet_time;                     //见面时间
@property (nonatomic,strong)                NSString* mMail_photo_url;                     //头像
@property (nonatomic,assign)                int       mMail_id;                     //阿姨id

+(void)getNewOrder:(void(^)(SResBase* retobj,int paid,int apointment,int waithire))block;

//根据订单id获得订单号	/query-billno-by-billid	bill_id=62(订单id)
-(void)getOrderNo:(void(^)(SResBase* retobj,NSString *orderNo))block;

//查看默认见面地点	/query-default-meet-location
-(void)getDefaultAddress:(void(^)(SResBase* retobj,NSString *address))block;

//约见阿姨,确定预约日期、时间、地点	/make-an-appointment	bill_id=xxxx(订单id)&meet_date=2016-06-12(预约日期)&meet_time=09:30(预约时间)&meet_location=xxxxxxxxxxx(预约地点)
-(void)makeAppointment:(NSString *)meet_date_time meet_location:(NSString *)meet_location block:(void(^)(SResBase* retobj))block;

//完成订单支付	/complete-agency-pay	bill_id=xxxx(订单id)
-(void)payOK:(void(^)(SResBase* retobj))block;

//订单列表
+(void)getOrderList:(int)type block:(void(^)(SResBase* retobj,NSArray *arr))block;


//雇佣阿姨	/employ-maid	employer_id=2(雇主id)&bill_id=48(订单id)&maid_id=3(阿姨id)
-(void)employMaid:(void(^)(SResBase* retobj))block;

//解聘阿姨	/dismiss-maid	bill_id=48(订单id)&maid_id=3(阿姨id)
-(void)dismissMaid:(void(^)(SResBase* retobj))block;

//重新计算订单价格（包括了商品与折扣卷）	/recalculate-amount	bill_id=1301(订单id)&goods_ids=1,3,2(商品id)&goods_count=1,1,2(商品对应的数量&app_trancation_amount=320(app端计算的交易金额)
-(void)recalculateAmount:(NSString *)goods_ids goods_count:(NSString *)goods_count app_trancation_amount:(float)app_trancation_amount block:(void(^)(SResBase* retobj,float trancation_amount))block;

@end

@interface SOrderDetail : SAutoEx

//查看订单详情	/query-bill-detail	bill_id=1301(订单id)	{ "_no":1000,"_msg":"操作成功","_data":{ "amount":1,"id":1301,"back_amount":0,"time":"2016-09-27 17:17:38.0","status":"已完成","no":"BL2016092700002","goods":[ ],"maid":"任丽娟","all_amount":1 } }
@property (nonatomic,assign)                float     mAmount;   //阿姨价格
@property (nonatomic,assign)                float     mId;       //订单ID
@property (nonatomic,assign)                float     mBack_amount; //差价
@property (nonatomic,strong)                NSString* mTime;   //下单时间
@property (nonatomic,strong)                NSString* mStatus; //订单状态
@property (nonatomic,strong)                NSString* mNo;   //订单号
@property (nonatomic,strong)                NSString* mMaid;  //雇佣的阿姨
@property (nonatomic,assign)                float     mAll_amount; //总价格
@property (nonatomic,strong)                NSArray* mGoods;  //雇佣的阿姨

+(void)getOrderDetail:(int)bill_id block:(void(^)(SResBase* retobj,SOrderDetail *order))block;

//订单投诉反馈	/submit-bill-suggest	employer_id=2(雇主ID)&bill_id=1760(订单ID)&content=aaa(投诉内容)&refund=true(是否退款，值为2个:true、false)
-(void)submitSuggest:(NSString *)content refund:(int)refund block:(void(^)(SResBase* retobj))block;


@end

@interface SHour : SAutoEx

@property (nonatomic,strong)                NSString *mLabel;
@property (nonatomic,strong)                NSString *mContent;

@end

@interface SAuntInfo : SAutoEx

@property (nonatomic,assign)                int       mId;
@property (nonatomic,strong)                NSString *mName;                    //姓名
@property (nonatomic,strong)                NSString *mPhoto_url;               //头像地址
@property (nonatomic,strong)                NSString *mStar;                   //星级
@property (nonatomic,strong)                NSString *mProvince;                //籍贯 省
@property (nonatomic,strong)                NSString *mLiving_area;
@property (nonatomic,strong)                NSString *mLiving_city;
@property (nonatomic,strong)                NSString *mLiving_province;
@property (nonatomic,strong)                NSString *mWork_province;           //工作 省
@property (nonatomic,strong)                NSString *mWork_city;               //工作 市
@property (nonatomic,strong)                NSString *mWork_area;               //工作 地区
@property (nonatomic,strong)                NSString *mConstellation;           //星座
@property (nonatomic,strong)                NSString *mWork_type;               //工作类型
@property (nonatomic,strong)                NSString *mEducation;               //学历
@property (nonatomic,assign)                int       mWorking_years;           //工龄
@property (nonatomic,assign)                int       mAge;                     //年龄
@property (nonatomic,assign)                int       mPay;                     //月薪

@property (nonatomic,assign)                int       mMaid_id;
@property (nonatomic,strong)                NSString *mMaid_name;                   //姓名
@property (nonatomic,assign)                int       mCheck;                     //是否被选中

//找保姆   find-nurse
//employer_id=xx(用户id)
//work_province=xxx(服务地点-省)
//&work_city=xxx(服务地点-市)
//&work_area=xxx(服务地点-区)
//&min_age=0(最小年龄)
//&max_age=100(最大年龄)
//&over_night=住家(是否住家:住家、白班)

+(void)findNurse:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night prio_province:(NSString *)prio_province star:(int)star block:(void(^)(SResBase* retobj,NSArray *arr))block;


//找陪护 /find-accompany
+(void)findAccompany:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area  over_night:(NSString *)over_night sex:(NSString *)sex care_type:(NSString *)care_type star:(int)star block:(void(^)(SResBase* retobj,NSArray *arr))block;

///找月嫂  find-maternity-matron	employer_id=xx(用户id)&work_province=xxx(服务地点-省)&work_city=xxx(服务地点-市)&work_area=xxx(服务地点-区)&have_auth=xxx(有无证书:有、无)
+(void)findMatron:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area have_auth:(NSString *)have_auth star:(int)star block:(void(^)(SResBase* retobj,NSArray *arr))block;

//找小时工
+(void)findHourWorker:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area service_address:(NSString *)service_address additional:(NSString *)additional service_items:(NSString *)service_items service_time:(NSString *)service_time service_duration:(int)service_duration service_count:(int)service_count block:(void(^)(SResBase* retobj,SOrder *order))block;

//根据地区查找小时工起做小时 query-hourworker-atleast-duration
+(void)findHourByAddress:(NSString *)province city:(NSString *)city area:(NSString *)area block:(void(^)(SResBase* retobj,int hour))block;

//查看各地区小时工各项价格
+(void)hourWorkerByAddress:(NSString *)province city:(NSString *)city area:(NSString *)area block:(void(^)(SResBase* retobj,NSArray *hours))block;

//找育儿嫂  /find-child-care    employer_id=xx(用户id)&work_province=xxx(服务地点-省)&work_city=xxx(服务地点-市)&work_area=xxx(服务地点-区)&min_age=0(最小年龄)&max_age=100(最大年龄)&over_night=住家(是否住家:住家、白班)
+(void)findChildCare:(int)employer_id work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area min_age:(int)min_age max_age:(int)max_age over_night:(NSString *)over_night prio_province:(NSString *)prio_province block:(void(^)(SResBase* retobj,NSArray *arr))block;

//放弃阿姨数据	/delete-maid	employer_id=xx(用户id)&maid_id=xxxx(对应的阿姨数据的id)
-(void)deleteThis:(void(^)(SResBase* retobj))block;

//展示阿姨的评价	/show-comment	maid_id=5(阿姨的id)&comment_type=工作评价(评论类型:工作评价、一面之缘、线上评价。该参数为可选参数,不写该参数显示全部类型的评论)&page=0(当前显示第几页的评论,每页返回10条数据)
-(void)getComment:(int)page block:(void(^)(SResBase* retobj,NSArray *arr))block;

//提交阿姨评论	/submit-comment	employer_id=xx(用户id)&maid_id=7(阿姨id)&comment_type=一面之缘(评论类型:工作评价、一面之缘、线上评价)&comment=aaaaa(评价内容)&star_count=5(用户的评价星数)

-(void)submitComment:(NSString *)comment star_count:(int)star_count block:(void(^)(SResBase* retobj))block;


+(void)submitOrder:(NSString *)array work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area service_date:(NSString *)service_date service_address:(NSString *)service_address additional:(NSString *)additional service_time:(NSString *)service_time service_duration:(NSString *)service_duration work_type:(NSString *)work_type over_night:(NSString *)over_night care_type:(NSString *)care_type block:(void(^)(SResBase* retobj,SOrder *order))block;


//定金支付提交信息
+(void)customBill:(NSString *)sex min_age:(int)min_age max_age:(int)max_age star:(int)star type:(NSString *)type work_province:(NSString *)work_province work_city:(NSString *)work_city work_area:(NSString *)work_area work_address:(NSString *)work_address province:(NSString *)province service_time:(NSString *)service_time service_duration:(NSString *)service_duration over_night:(NSString *)over_night care_type:(NSString *)care_type additional:(NSString *)additional block:(void(^)(SResBase* retobj,NSString *bid))block;

@end


@interface SGoods : SAutoEx

@property (nonatomic,assign) int      mGoods_id;         //商品ID
@property (nonatomic,strong) NSString *mPreview_img_path;        //商品图片
@property (nonatomic,assign) float    mPrice;           //价格
@property (nonatomic,strong) NSString *mCategory_name;   //类别名称
@property (nonatomic,strong) NSString *mGoods_name;      //商品名称
@property (nonatomic,strong) NSString *mIntroduction;    //商品详情
@property (nonatomic,strong) NSArray  *mPoll_img_path;   //轮播图
@property (nonatomic,strong) NSArray  *mDetail_img_path; //详情图
@property (nonatomic,assign) int      mCount;           //数量
@property (nonatomic,assign) BOOL      mCheck;           //数量


//根据类别查看商城的商品	/query-goods-by-category	category=全部(值为4个:全部、洗涤用品、养生保健、母婴用品)
+(void)getGoodsByCategory:(NSString *)category block:(void(^)(SResBase* retobj,NSArray *arr))block;

+(void)searchByKey:(NSString *)search_key block:(void(^)(SResBase* retobj,NSArray *arr))block;

//根据商品id查询商品详情	/query-goods-by-id	goods_id=1
-(void)getDetail:(void(^)(SResBase* retobj,SGoods *goods))block;

///add-goods-to-cart	employer_id=2(雇主id)&goods_ids=2,3(商品的id)&goods_increments=1,2(商品的增量)
-(void)addGoods:(int)num block:(void(^)(SResBase* retobj))block;

-(void)delGoods:(void(^)(SResBase* retobj))block;

-(void)delAllGoods:(void(^)(SResBase* retobj))block;

//查看购物车	/query-cart-by-employer-id	employer_id=2(雇主id)
+(void)getCartData:(void(^)(SResBase* retobj,NSArray *arr))block;


@end

//group_name":"厨卫清洁剂","group_img_path":"upload/goods/groups/img_group1.png","group_content":"威猛先生厨房卫生间好帮手","group_goods_id":"2,3","group_title":"厨卫清洁剂"
@interface SRecomend : SAutoEx

@property (nonatomic,strong) NSString *mGroup_name;
@property (nonatomic,strong) NSString *mGroup_img_path;
@property (nonatomic,strong) NSString *mGroup_content;
@property (nonatomic,strong) NSString *mGroup_goods_id;
@property (nonatomic,strong) NSString *mGroup_title;

@end


@interface SShops : SAutoEx

@property (nonatomic,strong) NSArray *mGoods_banner;
@property (nonatomic,strong) NSArray *mGoods_recommend;

//商城首页需要的数据	/goods-index-page
+(void)getShopData:(void(^)(SResBase* retobj,SShops *shops))block;

@end

//"face_value":100,"begin_time":"2016-10-10 00:00:00.0","end_time":"2017-01-01 00:00:00.0","status":"已生效","enough_money":500,"type":"满减卷","discount":1,"use_bill_type":"全部" 

//优惠券
@interface SCoupon : SAutoEx

@property (nonatomic,assign) float     mFace_value;  //金额
@property (nonatomic,strong) NSString *mBegin_time;  //开始时间
@property (nonatomic,strong) NSString *mEnd_time;    //结束时间
@property (nonatomic,strong) NSString *mStatus;      //状态
@property (nonatomic,assign) float     mEnough_money;//满多少钱可以用
@property (nonatomic,strong) NSString *mType;        //类型（满减券，打折券）
@property (nonatomic,assign) float     mDiscount;    //折扣
@property (nonatomic,strong) NSString *mUse_bill_type;//使用范围

//获取会员券列表
+(void)getCoupon:(NSString *)type status:(NSString *)status block:(void(^)(SResBase* retobj,NSArray *arr))block;

//兑换码兑换
+(void)exangeCode:(NSString *)gift_code block:(void(^)(SResBase* retobj))block;

@end














