
//  AppDelegate.m
//  myBase
//
//  Created by 林强 on 2017/1/23.
//  Copyright © 2017年 FU. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self getBankName];
    return YES;
}
-(void)getBankName
{
//    NSString *jsonStr = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bankData" ofType:@"json"] encoding:0 error:nil];
//    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSMutableArray *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",jsonDic);
    
    
    NSString * jsonPath = [[NSBundle mainBundle]pathForResource:@"bankData" ofType:@"json"];
    NSData * jsonData1 = [[NSData alloc]initWithContentsOfFile:jsonPath];
    NSMutableArray *jsonDic2 = [NSJSONSerialization JSONObjectWithData:jsonData1 options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"%@",jsonDic2);
    
    NSMutableDictionary *FUjsonDic = [[NSMutableDictionary alloc]init];
    
    NSMutableArray *FUjsonArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i=0 ; i<jsonDic2.count; i++) {
        NSString *strBin=[jsonDic2[i] objectForKey:@"bin"];
        NSMutableDictionary *FUDic = [[NSMutableDictionary alloc]initWithDictionary:jsonDic2[i]];
        
        NSString *strAllbankName=[jsonDic2[i] objectForKey:@"bankName"];
        NSArray *bankNameArray =[strAllbankName componentsSeparatedByString:@"-"];
        NSString *strbankName = bankNameArray.firstObject;
        NSString *strbankInfo = bankNameArray[1];
        NSString *strbankType = bankNameArray.lastObject;
        
        NSArray *bankNameArray2 =[strbankName componentsSeparatedByString:@"("];
        NSString *strbankName2 = bankNameArray2.firstObject;
        
        [FUDic setObject:strbankName2 forKey:@"bank"];
        [FUDic setObject:strbankType forKey:@"cardType"];
        [FUDic setObject:strbankInfo forKey:@"bankInfo"];
        [FUjsonDic setObject:FUDic forKey:strBin];
        
        [FUjsonArray addObject:FUDic];
        
    }
    
//    NSLog(@"%@",FUjsonDic);
    
    //创建一个dic，写到plist文件里/Users/linqiang/Desktop/FUbankData.json
//    [FUjsonDic writeToFile:@"/Users/linqiang/Desktop/FUbankData.json" atomically:YES];
    
    // 如果数组或者字典中存储了  NSString, NSNumber, NSArray, NSDictionary, or NSNull 之外的其他对象,就不能直接保存成文件了.也不能序列化成 JSON 数据.
    
    
    // 1.判断当前对象是否能够转换成JSON数据.
    // YES if obj can be converted to JSON data, otherwise NO
    BOOL isYes = [NSJSONSerialization isValidJSONObject:FUjsonArray];
    
    if (isYes) {
        NSLog(@"可以转换");
        
        /* JSON data for obj, or nil if an internal error occurs. The resulting data is a encoded in UTF-8.
         */
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:FUjsonArray options:0 error:NULL];
        
        /*
         Writes the bytes in the receiver to the file specified by a given path.
         YES if the operation succeeds, otherwise NO
         */
        // 将JSON数据写成文件
        // 文件添加后缀名: 告诉别人当前文件的类型.
        // 注意: AFN是通过文件类型来确定数据类型的!如果不添加类型,有可能识别不了! 自己最好添加文件类型.
        [jsonData writeToFile:@"/Users/linqiang/Desktop/FUbankDataArray.json" atomically:YES];
        
        NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        
    } else {
        
        NSLog(@"JSON数据生成失败，请检查数据格式");
        
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
