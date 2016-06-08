//
//  BombBoxVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/7.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "BombBoxVC.h"
#import "JFCalendarPickerView.h"

@interface BombBoxVC ()<UITableViewDataSource,UITableViewDelegate>{

    NSArray *_marray;
    
    NSMutableArray *_week;
    
    int _index;
}

@end

@implementation BombBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mBoxView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    self.mBoxView.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.mBoxView.layer.shadowOpacity = 0.3;//阴影透明度，默认0
    self.mBoxView.layer.shadowRadius = 10;//阴影半径，默认3
    
    self.mBgView.layer.masksToBounds = YES;
    self.mBgView.layer.cornerRadius = 8;
    
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    
    _mTableView.tableFooterView = UIView.new;
    
    _index = 100;
}

- (void)close{
    [self closeCalendarPickView];
}

-(void)initCalendarPickView:(void(^)(NSInteger day, NSInteger month, NSInteger year))block{

    JFCalendarPickerView *calendarPicker = [JFCalendarPickerView showOnView:self.mBoxView];
    calendarPicker.layer.masksToBounds = YES;
    calendarPicker.layer.cornerRadius = 8;
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    calendarPicker.frame = self.mBoxView.bounds;
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        block(day,month,year);
    };
    
}

//弹出服务时段
-(void)initTimeIntervalView:(UIView *)view title:(NSString *)title index:(int)index Array:(NSArray *)arry
{
    [self.view layoutIfNeeded];
    [self.mBoxView layoutIfNeeded];
    _index = index;
    if (arry.count == 2) {
        self.mHeight.constant = 1.5;
    }else{
        self.mHeight.constant = 0.75;
    }
    [self.view layoutIfNeeded];
    
    if (_week == nil) {
        _week = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    if (arry.count == 7) {
        
        _mSubmitHeight.constant = 50;
        if (_week.count == 0) {
            
            for (int i = 0; i<arry.count; i++) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:[arry objectAtIndex:i] forKey:@"name"];
                [dic setObject:@(0) forKey:@"select"];
                
                [_week addObject:dic];
            }
        }
        
    }else{
         _mSubmitHeight.constant = 0;
    }
    
    [self.mBoxView layoutIfNeeded];
    
    
    self.mTitle.text = title;
    _marray = arry;
    
    self.view.frame = CGRectMake(0, -DEVICE_Height, DEVICE_Width, DEVICE_Height);
    
    [view addSubview:self.view];
    
    [self.mTableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        
        self.view.frame = CGRectMake(0, 0, DEVICE_Width, DEVICE_Height);
        
    } completion:^(BOOL isFinished) {
        
    }];
}

-(void)closeCalendarPickView{
    
    [UIView animateWithDuration:0.5 animations:^(void) {
        
        self.mBoxView.frame = CGRectMake(self.mBoxView.frame.origin.x, DEVICE_Height, self.mBoxView.frame.size.width, self.mBoxView.frame.size.height);
        
    } completion:^(BOOL isFinished) {
        
        [self.view removeFromSuperview];
        for (UIView *view in self.mBoxView.subviews) {
            [view removeFromSuperview];
        }
    }];


    
}

- (void)closeView{

    [UIView animateWithDuration:0.5 animations:^(void) {
        
        self.view.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height);
        
    } completion:^(BOOL isFinished) {
        
        [self.view removeFromSuperview];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
       return _marray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *detifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:detifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_marray.count == 7) {
        
        NSDictionary *dic = [_week objectAtIndex:indexPath.row];
        
        if ([[dic objectForKey:@"select"] intValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        
        if (indexPath.row == _index) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    
    cell.tintColor = M_CO;
    
    cell.textLabel.text = [_marray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_marray.count == 7) {
        
        NSDictionary *dic = [_week objectAtIndex:indexPath.row];
        if ([[dic objectForKey:@"select"] intValue]) {
            [dic setValue:@(0) forKey:@"select"];
        }else{
            [dic setValue:@(1) forKey:@"select"];
        }
    }else{
    
        _index = (int)indexPath.row;
        
        [self.delegate selectString:[_marray objectAtIndex:indexPath.row] index:_index];
        
        
        [self closeView];
    }
    
    [_mTableView reloadData];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mSubmitClick:(id)sender {
    
    NSString *string = @"";
    for (NSDictionary *dic in _week) {
        if ([[dic objectForKey:@"select"] intValue]) {
            
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@ ",[dic objectForKey:@"name"]]];
        }
    }
    
    [self.delegate selectString:string index:_index];
    
    
    [self closeView];
}
@end
