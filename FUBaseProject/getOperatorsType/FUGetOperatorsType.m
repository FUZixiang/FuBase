//
//  FUGetOperatorsType.m
//  myBase
//
//  Created by 林强 on 2017/3/4.
//  Copyright © 2017年 FU. All rights reserved.
//

#import "FUGetOperatorsType.h"

@implementation FUGetOperatorsType
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
@end
