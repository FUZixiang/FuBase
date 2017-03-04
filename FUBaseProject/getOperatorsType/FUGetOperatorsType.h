//
//  FUGetOperatorsType.h
//  myBase
//
//  Created by 林强 on 2017/3/4.
//  Copyright © 2017年 FU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface FUGetOperatorsType : NSObject

// 获取运营商类型
+ (NSString *)getOperatorsType;
@end
