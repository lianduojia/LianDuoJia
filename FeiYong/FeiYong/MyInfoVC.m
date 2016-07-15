//
//  MyInfoVC.m
//  FeiYong
//
//  Created by 周大钦 on 16/6/8.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "MyInfoVC.h"
#import "YLPickerView.h"
#import "AFNetworking.h"
#import "RSKImageCropper.h"
#import "Util.h"


@interface MyInfoVC ()<UIActionSheetDelegate,RSKImageCropViewControllerDataSource,RSKImageCropViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    YLPickerView *_picker;
    
    UIImage *_image;
    
    NSString *_name;
    NSString *_sex;

}

@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _mHeadImg.layer.masksToBounds = YES;
    _mHeadImg.layer.cornerRadius = 21;
    
    self.navTitle = @"个人信息";
    
    _picker = [[YLPickerView alloc] initWithNibName:@"YLPickerView" bundle:nil];
    
    [self.navBar.mRightButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self showStatu:@"加载中.."];
    [SUser getDetail:^(SResBase *retobj) {
        if (retobj.msuccess) {
            [SVProgressHUD dismiss];
            
            [self loadMyInfo];
            _image = _mHeadImg.image;
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
    
    _image = _mHeadImg.image;
    _name = _mName.text;
    _sex = _mSex.text;
}

-(void)loadMyInfo{

    _mName.text = [SUser currentUser].mName;
    _mSex.text = [SUser currentUser].mSex;
    [_mHeadImg sd_setImageWithURL:[NSURL URLWithString:[[APIClient sharedClient] photoUrl:[SUser currentUser].mPhoto_url]] placeholderImage:[UIImage imageNamed:@"own_default"]];
    
    _image = _mHeadImg.image;
    _name = _mName.text;
    _sex = _mSex.text;
    
}

- (void)rightBtnTouched:(id)sender{

    if (_mName.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        
        return;
    }
    if ([_mSex.text isEqualToString:@"选择"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择性别"];
        
        return;
    }
    
    NSData *photoData = nil;
    
    if(_mHeadImg.image == _image && [_name isEqualToString:_mName.text] && [_sex isEqualToString:_mSex.text]){
    
        [SVProgressHUD showErrorWithStatus:@"您未做任何修改"];
        return;
    }
    
    if (_mHeadImg.image != _image) {
        photoData = [Util imageData:_mHeadImg.image];
    }
    
    NSString *name = nil;
    NSString *sex = nil;
    if (![_name isEqualToString:_mName.text] || ![_sex isEqualToString:_mSex.text]) {
        name = _mName.text;
        sex = _mSex.text;
    }
    
    [self showStatu:@"保存中.."];
    [SUser updateInfo:name sex:sex photo:photoData block:^(SResBase *retobj) {
        if (retobj.msuccess) {
            [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            
        }else{
            [SVProgressHUD showErrorWithStatus:retobj.mmsg];
        }
    }];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex != 2 ) {
        
        [self startImagePickerVCwithButtonIndex:buttonIndex];
    }
    
}
- (void)startImagePickerVCwithButtonIndex:(NSInteger )buttonIndex
{
    int type;
    
    
    if (buttonIndex == 0) {
        type = UIImagePickerControllerSourceTypeCamera;
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = type;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing =NO;
        
        [self presentViewController:imagePicker animated:YES completion:^{
            
        }];
        
    }
    else if(buttonIndex == 1){
        type = UIImagePickerControllerSourceTypePhotoLibrary;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = type;
        imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:NULL];
        
        
    }
    
    
    
}
- (void)imagePickerController:(UIImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    
    UIImage* tempimage1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self gotCropIt:tempimage1];
    
    [imagePickerController dismissViewControllerAnimated:YES completion:^() {
        
    }];
    
}
-(void)gotCropIt:(UIImage*)photo
{
    RSKImageCropViewController *imageCropVC = nil;
    
    imageCropVC = [[RSKImageCropViewController alloc] initWithImage:photo cropMode:RSKImageCropModeCircle];
    imageCropVC.dataSource = self;
    imageCropVC.delegate = self;
    [self.navigationController pushViewController:imageCropVC animated:YES];
    
}
- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    
    [controller.navigationController popViewControllerAnimated:YES];
}

- (CGRect)imageCropViewControllerCustomMaskRect:(RSKImageCropViewController *)controller
{
    return   CGRectMake(self.view.center.x-self.mHeadImg.frame.size.width/2, self.view.center.y-self.mHeadImg.frame.size.height/2, self.mHeadImg.frame.size.width, self.mHeadImg.frame.size.height);
    
}
- (UIBezierPath *)imageCropViewControllerCustomMaskPath:(RSKImageCropViewController *)controller
{
    return [UIBezierPath bezierPathWithRect:CGRectMake(self.view.center.x-self.mHeadImg.frame.size.width/2, self.view.center.y-self.mHeadImg.frame.size.height/2, self.mHeadImg.frame.size.width, self.mHeadImg.frame.size.height)];
    
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage
{
    
    [controller.navigationController popViewControllerAnimated:YES];
    
    //    tempImage = croppedImage;//[Util scaleImg:croppedImage maxsize:140];
    
    _mHeadImg.image = croppedImage;
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

- (IBAction)ChoseAgeClick:(id)sender {
    
    [_picker initView:self.view block:^(NSString *sex) {
       
        _mSex.text = sex;
    }];
}

- (IBAction)ChosePhotoClick:(id)sender {
    
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    [ac showInView:[self.view window]];
}
@end
