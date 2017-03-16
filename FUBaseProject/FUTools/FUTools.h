//
//  publicData.h
//  caipiao500
//
//  Created by fu on 15-5-8.
//  Copyright (c) 2015年 3c. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <CFNetwork/CFNetwork.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Security/Security.h>
#import <CoreGraphics/CoreGraphics.h>

#import "CCLocationManager.h"

//打标签
//git tag 'v1.0.5'
//上传
//git push --tags
//检查
//pod spec lint --allow-warnings FUBaseProject.podspec
//上传pod
//pod trunk push FUBaseProject.podspec

NSString* stringJudge(NSString* str);

@interface FUTools : NSObject
//@property(readonly,nonatomic)CGRect iponeFrame;
+(void)loadInit;

// 将JSON串转化为字典或者数组
+(id)toArrayOrNSDictionary:(NSData *)jsonData;
// 将字典或者数组转化为JSON串
+ (NSData *)toJSONData:(id)theData;


//字符大小
+ (CGSize)textSizeWithFont:(UIFont *)font str:(NSString*)name;
+(UIColor*)getSystemBackgroundColor;
+(UIColor*)getSystemTextColor;

+(UILabel*)setPublicLable:(NSString*)title font:(UIFont*)font frame:(CGRect)frame textColor:(UIColor*)textColor;

+ (void)showHUD:(NSString *)msg;
+ (void)showHUD:(NSString *)msg currentView:(UIView*)View;
+ (void)removeHUD;


//十六进制颜色
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;

+(NSString *)HidePhoneNumber:(NSString *)mobile;

+(UIImage *)fixOrientation:(UIImage *)aImage;


+(void)fuCity:(NSString *) FUcity;
+(void)fuCityQ:(NSString *) FUcity locality:(NSString *) FUlocality;
+(void)fuCityQ:(CLPlacemark *)placemark;

+(NSMutableDictionary *)FUDoDicttionary:(NSMutableDictionary *)mDict;


+(BOOL)FUDoDicttionaryNULL:(id)mDict;

#pragma mark 保留有需要的字符
/**保留有需要的字符
 *strNew 要处理的字符串
 *keepStr 要保留的字符串类型
 */
+(NSString *)RetainRequiredCharacters:(NSString *)strNew keepStr:(NSString *)keepStr;

/**判断用户输入的邮箱地址是否合法的代码
 电子邮箱的地址里允许使用的字符是特殊的，我们可以在应用里加入邮箱地址合法性判断功能，防止用户输入错误的字符。
 正确返回YES
 */
+(BOOL) validateEmail: (NSString *) candidate;


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;


//车型
+ (BOOL) validateCarType:(NSString *)CarType;


//用户名
+ (BOOL) validateUserName:(NSString *)name;


//密码
+ (BOOL) validatePassword:(NSString *)passWord;


//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//检查输入是否为中文 单字符
+(BOOL)CheckForChinese1:(NSString *) str;
//检查输入是否为中文
+(BOOL)CheckForChinese:(NSString *) str;

//=============身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

+ (BOOL)verifyIDCardNumber:(NSString *)value; //验证身份证

//+ (BOOL)verifyCardNumberWithSoldier:(NSString *)value;   //验证军官证或警官证

//+ (BOOL)verifyIDCardHadAdult:(NSString *)card;  //验证身份证是否成年且小于100岁****这个方法中不做身份证校验，请确保传入的是正确身份证

//+ (BOOL)verifyIDCardMoreThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType; //验证身份证加上指定天数是否大于指定number的类型
//
//+ (BOOL)verifyIDCardLessThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType;  //验证身份证是否小于指定number的类型

+ (NSString *)getIDCardBirthday:(NSString *)card;   //得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证

+ (NSInteger)getIDCardSex:(NSString *)card;   //得到身份证的性别（1男0女）****这个方法中不做身份证校验，请确保传入的是正确身份证
//=============身份证号

//纯数字
+ (BOOL)validateNumber:(NSString *)FUNumber;

+(CGFloat)FULableZSY:(NSString *)str Label:(UILabel *)label;

+(CGFloat)FULableZSY:(NSString *)str Label:(UILabel *)label LabelWidth:(CGFloat)newWidth;

/**打电话
 */
+(void)callTel:(NSString *)number superView:(UIView *) view;

/**字典转data 好像不管用
 */
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;
/**路径文件转dictonary 好像不管用
 */
+(NSDictionary*)returnDictionaryWithDataPath:(NSString*)path;
/** data文件转dictonary 好像不管用
 */
+(NSDictionary*)returnDictionaryWithData:(NSData *)data;


/**
 ios通过经纬度计算两个之间的距离
 返回 距离单位米
 */
+(double)distanceBetweenOrderByLat1:(double)lat1 Lat2:(double)lat2 Lng1:(double)lng1 Lng2:(double)lng2;
/**
 ios通过经纬度计算两个之间的距离
 返回 距离单位千米 KM
 */
+(double)distanceBetweenKMOrderByLat1:(double)lat1 Lat2:(double)lat2 Lng1:(double)lng1 Lng2:(double)lng2;

#pragma mark 画虚线
/**
 *画虚线
 *初始坐标的InitialX,InitialY
 *终点坐标的EndPointX,EndPointY
 *StrokeColor 设置虚线颜色
 */
+(void)DrawDottedLine:(UIView * ) superView
  InitialcoordinatesX:(NSInteger)InitialX
  InitialcoordinatesY:(NSInteger)InitialY
  EndPointCoordinateX:(NSInteger)EndPointX
  EndPointCoordinateY:(NSInteger)EndPointY
       setStrokeColor:(UIColor *)StrokeColor;


/**
 * @brief 当前时间 是否在某个时间段
 * @param fromHour 如fromHour为“8”，就是上午8:00（本地时间）
 * @param toHour 如toHour为“22”，就是晚上午22:00（本地时间）
 */
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;
/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour;


#pragma mark 打开网页
/**
 *打开网页
 */
+(void)openWeb:(NSString *)urlText;

#pragma mark 删除文件 png jpg jpeg
+(void)removeImageFile;
#pragma mark 删除文件_指定后缀名的文件
+(void)removeF:(NSString *) extension;
//判断文件夹总大小
//遍历文件夹获得文件夹大小，返回多少M

+ (float ) folderSizeAtPath:(NSString*) folderPath;
//判断单个文件大小

//单个文件的大小

+ (long long) fileSizeAtPath:(NSString*) filePath;

+(NSString *)getCacheNumberWithStr;

#pragma mark 只能去除数组中存放的是 string 的
#pragma mark 去除数组中重复的 利用NSDictionary的AllKeys（AllValues）方法
+(NSMutableArray *)FUArrayRemovalMethodNSDictionary:(NSArray *)dataArray;
#pragma mark 去除数组中重复的 利用NSSet的AllObjects方法
+(NSMutableArray *)FUArrayRemovalMethodNSSet:(NSArray *)dataArray;
#pragma mark 去除数组中重复的 循环
+(NSMutableArray *)FUArrayRemovalMethodForin:(NSArray *)dataArray;


@end
