//
//  WPAnnotation.h
//  EzvizRealPlayDemo
//
//  Created by fuzixiang on 15/7/8.
//  Copyright (c) 2015年 hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface WPAnnotation : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
//自定义大头针图片
@property(nonatomic,copy) NSString *icon;
@end
