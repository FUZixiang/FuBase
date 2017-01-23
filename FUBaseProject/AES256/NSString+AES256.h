//
//  AES256.h
//  AESCipher
//
//  Created by 林强 on 2016/11/10.
//  Copyright © 2016年 WelkinXie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES256)

-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

@end
