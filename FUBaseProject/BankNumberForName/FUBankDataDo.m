//
//  FUBankDataDo.m
//  myBase
//
//  Created by 林强 on 2017/3/4.
//  Copyright © 2017年 FU. All rights reserved.
//

#import "FUBankDataDo.h"

@implementation FUBankDataDo

+(NSString *)getBankName:(NSString *)strBankNumber
{
    NSString *strBankName = @"";
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FUbankData" ofType:@"plist"];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSMutableDictionary *dic = [dic2 objectForKey:strBankNumber];
    if (nil != dic ) {
        strBankName=[dic objectForKey:@"bank"];
    }
    if (nil == strBankName ) {
        strBankName = @"";
    }
    
    return strBankName;
}
+(NSMutableDictionary *)getBankInfo:(NSString *)strBankNumber
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FUbankData" ofType:@"plist"];
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSString *strTempKey = @"";
    for (NSString *strBin in [dic2 allKeys])
    {
        if ([strBankNumber hasPrefix:strBin])
        {
            strTempKey =strBin;
            break;
        }
    }
    NSMutableDictionary *dic = [dic2 objectForKey:strTempKey];
    return dic;
    
    
}
@end
