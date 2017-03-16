//
//  GetVersionNumber.m
//  YinPiaoLiCai
//
//  Created by yingpiao on 14-9-4.
//  Copyright (c) 2014年 lianwg. All rights reserved.
//

#import "FUGetAllSystemInfo.h"

#import <sys/utsname.h>

@implementation FUGetAllSystemInfo


/**
 应用的Version号：
 */
+(NSString *)GetAPPShortVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    //或
    //[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
/**
获得build号：
*/
+(NSString *)GetAPPbuild
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

/**系统版本号
 */
+(NSString *)GetIOSVersion
{
    
    return [[UIDevice currentDevice] systemVersion];
}
+(NSString *)GetAPPVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
}
// 当前应用软件版本  比如：1.0.1
+(NSString *)GetAPPCFBundleShortVersionString
{
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString * appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return appCurVersion;
}

// 当前应用名称
+(NSString *)GetAPPCurName
{
    NSDictionary * infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString * appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    return appCurName;
}
+(NSString *)GetVersion
{
    NSString *version=[NSString stringWithFormat:@"IOS%@ %@", [[self class] GetIOSVersion],[[self class] GetAPPCFBundleShortVersionString]];
    return version;
}
+(float)GetScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+(float)GetScreenHeight;
{
    return [UIScreen mainScreen].bounds.size.height;
}

+(CGSize)GetScreenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+(NSString *)UTCDate
{
    NSDate *date = [NSDate date];
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
//    NSInteger interval = [zone secondsFromGMTForDate: date];
    
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    //    NSLog(@"%@", localeDate);
    
    NSTimeInterval timeStamp= [date timeIntervalSince1970];
    NSString *UTCtime=[NSString stringWithFormat:@"%.0f",timeStamp];
    return UTCtime;
    //    NSLog(@"日期转换为时间戳 %@ = %f", date, timeStamp);
}


+(NSString *)getTimeStringWithFormatter:(NSString *)format date:(NSDate *)myDate
{
    if (format ==nil || [format isKindOfClass:[NSNull class]] ||[format isEqualToString:@"" ])
    {
        format=@"YYYY-MM-dd HH:mm:ss";
    }
//    设置时间显示格式:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString *nowtimeStr = [formatter stringFromDate:myDate];
    return nowtimeStr;
}

+(NSDate *)GetUTC:(NSString *)confromTimesp
{
//    设置时间显示格式:
//    NSString* timeStr = @"2011-01-26 17:40:50";
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//    
//    //设置时区,这个对于时间的处理有时很重要
//    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
//    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
//    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
//    
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//    
//    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
//    
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//    
//    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
////    时间转时间戳的方法:
//    NSString *timeSp = [NSString stringWithFormat:@"%d", (long)[datenow timeIntervalSince1970]];
//    NSLog(@"timeSp:%@",timeSp); //时间戳的值
////    时间戳转时间的方法
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:1296035591];
//    NSLog(@"1296035591  = %@",confromTimesp);
//    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
//    NSLog(@"confromTimespStr =  %@",confromTimespStr);
//    时间戳转时间的方法:
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMMddHHMMss"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSTimeZone* timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    NSDate *confromDate = [NSDate dateWithTimeIntervalSince1970:[confromTimesp longLongValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromDate];
    NSDate *date = [formatter dateFromString:confromTimespStr];
    //NSLog(@"date1:%@",date);
    //NSLog(@"date2:%@",[[self class] getNowDateFromatAnDate:[NSDate new]]);
    //NSLog(@"date3:%@",[[self class] getNowDateFromatAnDate:confromDate]);
    return date;
    
}

+(NSDate *)getDateFromUCT:(NSString *)confromTimesp
{
    NSDate *confromDate = [NSDate dateWithTimeIntervalSince1970:[confromTimesp longLongValue]];
    NSDate *MyDate=[[self class] getNowDateFromatAnDate:confromDate];
//    NSLog(@"date:%@",MyDate);
    return MyDate;
    
}

+(NSString *)getStringDateFromUCT:(NSString *)confromTimesp Formatter:(NSString *)format
{
    
    return [[self class] getTimeStringWithFormatter:format date:[[self class] getDateFromUCT:confromTimesp]];
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}
//+(NSString*) md5:(NSString*) str
//
//{
//    
//    const char *cStr = [str UTF8String];
//    
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    
//    CC_MD5( cStr, strlen(cStr), result );
//    NSMutableString *hash = [NSMutableString string];
//    
//    for(int i=0;i<CC_MD5_DIGEST_LENGTH;i++)
//    {
//        [hash appendFormat:@"%02X",result[i]];
//    }
//    
//    return [hash lowercaseString];
//    
//}
//32位MD5加密方式
//+(NSString *)getMd5_32Bit_String:(NSString *)srcString
//{
//    const char *cStr = [srcString UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    // CC_MD5( cStr, strlen(cStr), digest ); 这里的用法明显是错误的，但是不知道为什么依然可以在网络上得以流传。当srcString中包含空字符（\0）时
//    CC_MD5( cStr, strlen(cStr), digest );
//    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [result appendFormat:@"%02x", digest[i]];
//    
//    return result;
//}

+ (NSString *)stringToMD5:(NSString *)str
{
    
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [str UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}
#pragma mark 小写
+(NSString *)getMd5_32Bit_String:(NSString *)srcString
{
    return [[self class] stringToMD5:srcString];
}
+(NSString *)getMd5_32Bit_String:(NSString *)srcString with:(NSInteger)num
{
    NSString *strMD5=srcString;
    for (NSInteger i=0; i< num; i++) {
        strMD5 = [[self class] stringToMD5:strMD5];
    }
    return strMD5;
}

#pragma mark 大写
+(NSString *)getMd5_32Bit_uppercaseString:(NSString *)srcString
{
    return [[[self class] stringToMD5:srcString] uppercaseString];
}
+(NSString *)getMd5_32Bit_uppercaseString:(NSString *)srcString with:(NSInteger)num
{
    NSString *strMD5=srcString;
    for (NSInteger i=0; i< num; i++) {
        strMD5 = [[[self class] stringToMD5:strMD5] uppercaseString];
    }
    return strMD5;
}



+(NSString *)getAFID
{
    NSString *adId =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if (adId==nil || [adId isKindOfClass:[NSNull class]] ||adId ==NULL) {
        adId=@"";
    }
    return adId;
}



//手机系统版本名
+ (NSString *)iphoneSystemName
{
    NSString * iponeM = [[UIDevice currentDevice] systemName];
    return iponeM;
}


//4.电池电量
+ (CGFloat )iphoneBatteryLevel
{
    CGFloat batteryLevel=[[UIDevice currentDevice] batteryLevel];
    return batteryLevel;
}

//手机类型
+ (NSString *)iphoneType {
    
//    需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])  return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])  return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])  return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])  return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])  return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])  return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])  return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])  return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])  return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])  return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])  return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])  return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])  return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])  return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])  return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])  return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])  return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])  return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])  return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])  return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])  return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])  return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])  return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])  return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])  return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}


@end
