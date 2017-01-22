//
//  ViewController.h
//  FUBaseProject
//
//  Created by 林强 on 2016/11/9.
//  Copyright © 2016年 FU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreVideo/CoreVideo.h>
#import <Photos/Photos.h>

@interface ViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) PHFetchResult *assetsFetchResults;

@property (strong,nonatomic) NSMutableDictionary *info;
@property (strong,nonatomic) NSMutableDictionary *info1;
@property (strong,nonatomic) NSMutableDictionary *info2;

@property (strong,nonatomic) NSString *strFlag;

@end

