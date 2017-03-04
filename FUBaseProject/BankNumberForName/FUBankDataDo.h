//
//  FUBankDataDo.h
//  myBase
//
//  Created by 林强 on 2017/3/4.
//  Copyright © 2017年 FU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUBankDataDo : NSObject
/**通过卡号得到银行名称
 *strBankNumber 卡号
 *return        银行名称
 */
+(NSString *)getBankName:(NSString *)strBankNumber;

/**通过卡号得到银行信息
 *strBankNumber 卡号
 *return        银行信息
 *bank          银行
 *bankInfo      银行卡信息
 *bankName      全部信息
 *bin           开号是什么开头的
 *cardType      什么类型,比如‘借记卡’
 */
+(NSMutableDictionary *)getBankInfo:(NSString *)strBankNumber;
@end
