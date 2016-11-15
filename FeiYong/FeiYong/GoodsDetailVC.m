//
//  GoodsDetailVC.m
//  FeiYong
//
//  Created by 周大钦 on 2016/11/4.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "SDCycleScrollView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "WebVC.h"

@interface GoodsDetailVC ()<SDCycleScrollViewDelegate,UIScrollViewDelegate>{

    SDCycleScrollView *_cycleScrollView;
    
    float yy;
    
    int _num;
    
}

@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _num = 1;
    self.navBar.hidden = YES;
    
    self.mNavView.alpha = 0;
    self.mTitle.alpha = 0;
    _mScrollView.delegate = self;
    _mTitle.text = _mGoods.mGoods_name;
    
    [self showStatu:@"加载中.."];
    
    [_mGoods getDetail:^(SResBase *retobj, SGoods *goods) {
        
        if (retobj.msuccess) {
            
            [SVProgressHUD dismiss];
            
            _mGoods = goods;
            
            [self loadData];
            
        }else{
        
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    
    self.mNavView.alpha = y/DEVICE_Width;
    self.mTitle.alpha = y/DEVICE_Width;
}

- (void)loadData{
    
    _mGoodsName.text = _mGoods.mGoods_name;
    _mPrice.text = [NSString stringWithFormat:@"¥%g",_mGoods.mPrice];

    if (_mGoods.mPoll_img_path.count==1) {
        
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Width)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:[_mGoods.mPoll_img_path objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"default"]];
        imgV.contentMode = UIViewContentModeScaleAspectFill;
        imgV.clipsToBounds = YES;
        imgV.backgroundColor = randomColor;
        [_mBannerView addSubview:imgV];
        
    }else if (_mGoods.mPoll_img_path.count>1){
    
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, DEVICE_Width, DEVICE_Width) imagesGroup:_mGoods.mPoll_img_path];
        _cycleScrollView.delegate = self;
        [_mBannerView addSubview:_cycleScrollView];
    }
    
    yy = 0;
    
    for(int i = 0;i<_mGoods.mDetail_img_path.count;i++){
    
        NSString *string = [_mGoods.mDetail_img_path objectAtIndex:i];
        UIImageView *v1 = [[UIImageView alloc]init];
        v1.userInteractionEnabled = YES;
        v1.tag = i+1;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PhotoClick:)];
        [v1 addGestureRecognizer:tap];
        
        
            [v1 sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
                if (error) {
                    [SVProgressHUD showErrorWithStatus:error.description];
                }else{
                    v1.frame = CGRectMake(0, yy, DEVICE_Width, image.size.height/image.size.width*DEVICE_Width);
                    [_mRemarkView addSubview:v1];
                    yy+= v1.frame.size.height;
                    _mRemarkHeight.constant = yy;
                }
                
                
                
            }];

    }
    
    
}

-(void)PhotoClick:(UITapGestureRecognizer *)tap{
    
    UIImageView* tagv = (UIImageView*)tap.view;
    
    NSMutableArray* allimgs = NSMutableArray.new;
    for ( NSString* url in _mGoods.mDetail_img_path)
    {
        MJPhoto* onemj = [[MJPhoto alloc]init];
        onemj.url = [NSURL URLWithString:url ];
        onemj.srcImageView = tagv;
        [allimgs addObject: onemj];
    }
    
    MJPhotoBrowser* browser = [[MJPhotoBrowser alloc]init];
    browser.currentPhotoIndex = tagv.tag-1;
    browser.photos  = allimgs;
    [browser show];

}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    
    
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

- (IBAction)mBackClick:(id)sender {
    
    [self popViewController];
}

- (IBAction)mKefuClick:(id)sender {
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",TEL];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (IBAction)mChangeNumClick:(id)sender {
    
    int index = (int)((UIButton *)sender).tag;
    
    switch (index) {
        case 10:
            
            if (_num>0) {
                _num--;
            }
            
            break;
        case 11:
            _num++;
            break;
            
        default:
            break;
    }
    
    [_mNum setTitle:[NSString stringWithFormat:@"%d",_num] forState:UIControlStateNormal];
    if (_num==0) {
        _mDel.enabled = NO;
    }else{
        _mDel.enabled = YES;
    }
}

- (IBAction)mAddShopCarClick:(id)sender {
    
    if ([SUser isNeedLogin]) {
        [self gotoLogin];
        return;
    }
    
    [self showStatu:@"操作中.."];
    _mGoods.mCount = _num;
    
    [_mGoods addGoods:_mGoods.mCount block:^(SResBase *retobj){
       
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:retobj.mmsg];
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

- (IBAction)mGuizeClick:(id)sender {
    
    WebVC *web = [[WebVC alloc] init];
    web.mName = @"购买规则";
    web.isMode = YES;
    web.mUrl = [NSString stringWithFormat:@"%@pr.html",[APIClient getDomain]];
    [self presentViewController:web animated:YES completion:nil];

    
}
@end
