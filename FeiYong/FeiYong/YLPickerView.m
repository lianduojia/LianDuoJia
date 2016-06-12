//
//  YLPickerView.m
//  FeiYong
//
//  Created by 连多家 on 16/6/11.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "YLPickerView.h"

@interface YLPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource,NSXMLParserDelegate>{
    
    NSMutableArray *_provinces;
    NSMutableArray *_citys;
    NSMutableArray *_areas;
    
    NSMutableDictionary *_provinceDic;
    NSMutableDictionary *_cityDic;
    
    NSString *_provice;
    NSString *_city;
    NSString *_area;
    
}

@end

@implementation YLPickerView


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _provinces = [NSMutableArray new];
    _citys = [NSMutableArray new];
    _areas = [NSMutableArray new];
    
    _provinceDic = [NSMutableDictionary new];
    _cityDic = [NSMutableDictionary new];
    
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    _provinces = [def objectForKey:@"provinces"];
    
    [self start];

}


// 开始解析
-(void)start{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"province_data" ofType:@"xml"];
    NSURL * url = [NSURL fileURLWithPath:path];
    
    //开始解析 xml
    NSXMLParser * parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    parser.delegate = self ;
    
    [parser parse];
    
    NSLog(@"解析搞定...");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 该方法的返回值决定该控件包含多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3;
}
#pragma mark - 该方法的返回值决定该控件指定列包含多少个列表项
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (0 == component)
    {
        return _provinces.count;
    }
    if (1 == component) {
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
       
        NSDictionary *dic = _provinces[rowProvince];
        
        return [[dic objectForKey:@"city"] count];
    }else{
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        
         NSDictionary *dic = _provinces[rowProvince];
        
        NSArray *citys = [dic objectForKey:@"city"];
        
        NSDictionary *dic2 = citys[rowCity];
        
        return [[dic2 objectForKey:@"area"] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (0 == component) {
        
        return [_provinces[row] objectForKey:@"province"];
    }
    if(1 == component){
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary *dic = _provinces[rowProvince];
        NSArray *arr = [dic objectForKey:@"city"];
        return [arr[row] objectForKey:@"city"];
    }else{
        
        NSInteger rowProvince = [pickerView selectedRowInComponent:0];
        NSDictionary *dic = _provinces[rowProvince];
        NSArray *citys = [dic objectForKey:@"city"];
        NSInteger rowCity = [pickerView selectedRowInComponent:1];
        NSDictionary *dic2 = citys[rowCity];
        NSArray *area = [dic2 objectForKey:@"area"];
        return [area[row] objectForKey:@"district"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(0 == component){
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    if(1 == component)
        [pickerView reloadComponent:2];
    
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    NSInteger rowTow = [pickerView selectedRowInComponent:1];
    NSInteger rowThree = [pickerView selectedRowInComponent:2];
    
    NSDictionary *dic = _provinces[rowOne];
    
    _provice = [dic objectForKey:@"province"];
    
    NSArray *citys = [dic objectForKey:@"city"];
    
    NSDictionary *cityDic = [citys objectAtIndex:rowTow];
    
    _city = [cityDic objectForKey:@"city"];
    
    NSArray *areas = [cityDic objectForKey:@"area"];
    
    NSDictionary *areaDic = [areas objectAtIndex:rowThree];
    
    _area = [areaDic objectForKey:@"district"];
    
    
}


- (IBAction)mCancelClick:(id)sender {
    
    [self closeView];
    _itblock(NO,nil,nil,nil);
}

- (IBAction)mSubmittClick:(id)sender {
    
    [self closeView];
    _itblock(YES,_provice,_city,_area);
}

-(void)initView:(UIView *)view block:(void(^)(BOOL flag,NSString *province,NSString *city,NSString *area))block{

    CGRect rect = self.view.frame;
    rect.origin.y = DEVICE_Height;
    rect.size.width = DEVICE_Width;
    self.view.frame = rect;
    
    [view addSubview:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect2 = self.view.frame;
        rect2.origin.y = DEVICE_Height-216;
        self.view.frame = rect2;
    }];
    
    self.itblock = ^(BOOL flag,NSString *province,NSString *city,NSString *area){
    
        block(flag,province,city,area);
    };
}


-(void)closeView{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect2 = self.view.frame;
        rect2.origin.y = DEVICE_Height;
        self.view.frame = rect2;
    }];
    
    [self performSelector:@selector(Remove) withObject:nil afterDelay:0.2f];
}

-(void)Remove{
    [self.view removeFromSuperview];
}

//文档开始时触发 ,开始解析时 只触发一次
-(void)parserDidStartDocument:(NSXMLParser *)parser{
   
}

// 文档出错时触发
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@",parseError);
}

//遇到一个开始标签触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    //把elementName 赋值给 成员变量 currentTagName
    _currentTagName  = elementName ;
    
    //如果名字 是Note就取出 id
    if ([_currentTagName isEqualToString:@"province"]) {
        
        NSString * _name = [attributeDict objectForKey:@"name"];
        //把name放入字典中
        [_provinceDic setObject:_name forKey:@"province"];
        
    }
    
    if ([_currentTagName isEqualToString:@"city"]) {
        
        NSString * _name = [attributeDict objectForKey:@"name"];

        //把name放入字典中
        [_cityDic setObject:_name forKey:@"city"];
        
    }
    
    if ([_currentTagName isEqualToString:@"district"]) {
        
        NSString * _name = [attributeDict objectForKey:@"name"];
        // 实例化一个可变的字典对象,用于存放
        NSMutableDictionary *dict = [NSMutableDictionary new];
        //把name放入字典中
        [dict setObject:_name forKey:@"district"];
        
        // 把可变字典 放入到 可变数组集合_notes 变量中
        [_areas addObject:dict];
    }
    
}
#pragma mark 该方法主要是解析元素文本的主要场所，由于换行符和回车符等特殊字符也会触发该方法，因此要判断并剔除换行符和回车符
// 遇到字符串时 触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
    
    string  = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""]) {
        return;
    }
    
    NSMutableDictionary * dict = [_provinces lastObject];
    if ([_currentTagName isEqualToString:@"CDate"] && dict) {
        [dict setObject:string forKey:@"CDate"];
    }
    
    if ([_currentTagName isEqualToString:@"Content"] && dict) {
        [dict setObject:string forKey:@"Content"];
    }
    
    if ([_currentTagName isEqualToString:@"UserID"] && dict) {
        [dict setObject:string forKey:@"UserID"];
    }
    
    
}

//遇到结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.currentTagName = elementName ;
    

    
    if ([_currentTagName isEqualToString:@"city"]) {
        
        [_cityDic setObject:_areas forKey:@"area"];
        
        [_citys addObject:_cityDic];
        _areas = [NSMutableArray new];
        _cityDic = [NSMutableDictionary new];
        
    }
    
    if ([_currentTagName isEqualToString:@"province"]) {
    
        [_provinceDic setObject:_citys forKey:@"city"];
        
        [_provinces addObject:_provinceDic];
        _citys = [NSMutableArray new];
        _provinceDic = [NSMutableDictionary new];
        
    }
    
}

// 遇到文档结束时触发
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器） 通过广播机制将数据通过广播通知投送到 表示层
    NSLog(@"====%@",_provinces);
    
    self.mPicker.delegate = self;
    self.mPicker.dataSource = self;

}


@end
