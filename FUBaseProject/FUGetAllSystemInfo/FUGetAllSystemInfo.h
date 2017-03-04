//
//  GetVersionNumber.h
//  YinPiaoLiCai
//
//  Created by yingpiao on 14-9-4.
//  Copyright (c) 2014年 lianwg. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
//#import "frameworkerHeader.h"
//    A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
@interface FUGetAllSystemInfo : NSObject
/**
 应用的Version号：
 */
+(NSString *)GetAPPShortVersion;
/**
 获得build号：
 */
+(NSString *)GetAPPbuild;
/**
 获得APPVersion号：
 */
+(NSString *)GetAPPVersion;
/**系统版本号
 */
+(NSString *)GetIOSVersion;

+(NSString *)GetVersion;
//获取屏幕大小
+(float)GetScreenWidth;
+(float)GetScreenHeight;
+(CGSize)GetScreenSize;


//时间戳
+(NSString *)UTCDate;

+(NSString *)getTimeStringWithFormatter:(NSString *)format date:(NSDate *)myDate;
+(NSDate *)GetUTC:(NSString *)confromTimesp;
/**时间戳 转时间
 */
+(NSDate *)getDateFromUCT:(NSString *)confromTimesp;
/**时间戳 转时间
 *得到自定义的时间格式
 */
+(NSString *)getStringDateFromUCT:(NSString *)confromTimesp Formatter:(NSString *)format;

/**得到本时区时间
 */
+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;


+(NSString*) md5:(NSString*) str;
//32位MD5加密方式
+(NSString *)getMd5_32Bit_String:(NSString *)srcString;


+(NSString *)getAFID;


//手机系统版本名
+ (NSString *)iphoneSystemName;
//4.电池电量
+ (CGFloat )iphoneBatteryLevel;
//手机类型
+ (NSString *)iphoneType;
@end
