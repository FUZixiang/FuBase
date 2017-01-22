//
//  ViewController.m
//  FUBaseProject
//
//  Created by 林强 on 2016/11/9.
//  Copyright © 2016年 FU. All rights reserved.
//

#import "FUViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreVideo/CoreVideo.h>
#import <Photos/Photos.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface FUViewController ()<PHPhotoLibraryChangeObserver>

@end

@implementation FUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.info =[[NSMutableDictionary alloc]init];
    self.info1 =[[NSMutableDictionary alloc]init];
    self.info2 =[[NSMutableDictionary alloc]init];
    
    
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver:self];
        }
    }];
    NSLog(@"%@",[[self class] getOperatorsType]);
}
// 获取运营商类型
+ (NSString *)getOperatorsType
{
    NSString *SSOperatorsType= @"其他";
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
    
    NSString *currentCountryCode = [carrier mobileCountryCode];
    NSString *mobileNetWorkCode = [carrier mobileNetworkCode];
    
    if (![currentCountryCode isEqualToString:@"460"]) {
        return SSOperatorsType;
    }
    
    // 参考 https://en.wikipedia.org/wiki/Mobile_country_code
    
    if ([mobileNetWorkCode isEqualToString:@"00"] ||
        [mobileNetWorkCode isEqualToString:@"02"] ||
        [mobileNetWorkCode isEqualToString:@"07"] ||
        [mobileNetWorkCode isEqualToString:@"08"]) {
        
        // 中国移动
        return SSOperatorsType = @"中国移动";
    }
    
    if ([mobileNetWorkCode isEqualToString:@"01"] ||
        [mobileNetWorkCode isEqualToString:@"06"] ||
        [mobileNetWorkCode isEqualToString:@"09"]) {
        
        // 中国联通
        return SSOperatorsType = @"中国联通";
    }
    
    if ([mobileNetWorkCode isEqualToString:@"03"] ||
        [mobileNetWorkCode isEqualToString:@"05"] ||
        [mobileNetWorkCode isEqualToString:@"11"]) {
        
        // 中国电信
        return SSOperatorsType = @"中国电信";
    }
    
    if ([mobileNetWorkCode isEqualToString:@"20"]) {
        
        // 中国铁通
        return SSOperatorsType = @"中国铁通";
    }
    
    return SSOperatorsType;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    NSLog(@"Here%@",changeInstance);

    
}

    



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickMyVideo:(id)sender
{
    self.strFlag =@"1";
    [self showMyUIAction];
}

- (IBAction)clickMyVideo2:(id)sender
{
    self.strFlag =@"2";
    [self showMyUIAction];
}
- (IBAction)clickMyVideo3:(id)sender
{
    
//    取2的视频覆盖1的视频
    
    NSURL* mediaURL2 = [self.info2 objectForKey:UIImagePickerControllerMediaURL];
    NSURL* mediaURL1 = [self.info1 objectForKey:UIImagePickerControllerMediaURL];
    //创建ALAssetsLibrary对象并将视频保存到媒体库
    // Assets Library 框架包是提供了在应用程序中操作图片和视频的相关功能。相当于一个桥梁，链接了应用程序和多媒体文件。
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    // 将视频保存到相册中
    [assetsLibrary groupForURL:mediaURL2 resultBlock:^(ALAssetsGroup *group) {
        
    } failureBlock:^(NSError *error) {
        
    }];
    [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL1
                                      completionBlock:^(NSURL *assetURL, NSError *error) {
                                          if (!error) {
                                              NSLog(@"captured video saved with no error.");
                                          }else{
                                              NSLog(@"error occured while saving the video:%@", error);
                                          }
                                      }];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:mediaURL1];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
    }];
    
    
//    [[PHPhotoLibrary sharedPhotoLibrary] ]
    
}
#pragma mark - Add Picture

-(void)showMyUIAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册",@"Video", nil];
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self addCarema];
    }else if (buttonIndex == 1){
        [self openPicLibrary];
    }else if (buttonIndex == 2){
        [self choosevideo];
    }
}
- (void)choosevideo
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    ipc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:nil];
    ipc.delegate = self;//设置委托
    
}

-(void)addCarema
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker.navigationBar setBackgroundColor:[UIColor blackColor]];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0) {
            
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }
        [self presentViewController:picker animated:YES completion:^{
            //            NSLog(@"傅");
            
        }];
        
    }else{
        //如果没有提示用户
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有找到相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

-(void)openPicLibrary
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker.navigationBar setBackgroundColor:[UIColor blackColor]];
        picker.delegate = self;
        picker.allowsEditing = YES;
        //        picker.showsCameraControls  = YES;
        //        UIImagePickerControllerCropRect
        //        picker.allowsImageEditing=YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if([[[UIDevice
              currentDevice] systemVersion] floatValue]>=8.0) {
            
            self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            
        }
        [self presentViewController:picker animated:YES completion:^{
            //            NSLog(@"傅");
            
        }];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UIImage *editImage = info[UIImagePickerControllerOriginalImage];
    
    NSData *data;
    if (UIImagePNGRepresentation(editImage) == nil) {
        
        data = UIImageJPEGRepresentation(editImage, 0.1);
        
    } else {
        
        data = UIImagePNGRepresentation(editImage);
    }
    
    if ([mediaType isEqualToString:@"public.movie"]){
        if ([self.strFlag isEqualToString:@"1"])
        {
            self.info1 =[[NSMutableDictionary alloc]initWithDictionary:info];
            
        }
        else if([self.strFlag isEqualToString:@"2"])
        {
            self.info2 =[[NSMutableDictionary alloc]initWithDictionary:info];
        }
        
        
    
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        //        [self.delegate UUInputFunctionView:self sendPicture:editImage];
        
        
    }];
}

/// 上传图片
-(void)uploadImageWithUrl:(NSString *)url image:(UIImage *)image dict:(NSDictionary *)Dict
{
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
