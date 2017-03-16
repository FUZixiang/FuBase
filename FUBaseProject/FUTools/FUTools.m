//
//  publicData.m
//  caipiao500
//
//  Created by fu on 15-5-8.
//  Copyright (c) 2015年 3c. All rights reserved.
//

#import "FUTools.h"


NSString* stringJudge(NSString* str)
{
    if(str== nil || str == NULL || [str isEqual:[NSNull null]]||[str isEqual:@"(null)"])
        return @"";
    
    else    return [NSString stringWithFormat:@"%@",str];
}

@implementation FUTools


+(void)loadInit
{

}
+(UIColor*)getSystemBackgroundColor
{
    UIColor* color;
    NSUserDefaults* listData = [NSUserDefaults standardUserDefaults];
    
    if([[listData objectForKey:@"sysBackgroudColor"]isEqualToString:@"day"] || ![listData objectForKey:@"sysBackgroudColor"])
    {
        color = [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
        //systemTextColor = [UIColor blackColor];
    }
    else{
        color = [UIColor colorWithRed:34.0/255.0 green:40.0/255.0 blue:52.0/255.0 alpha:1.0];
        //systemTextColor = [UIColor whiteColor];
    }
    return color;
}
+(UIColor*)getSystemTextColor
{
    UIColor* color;
    NSUserDefaults* listData = [NSUserDefaults standardUserDefaults];
    if([[listData objectForKey:@"sysBackgroudColor"]isEqualToString:@"day"] || ![listData objectForKey:@"sysBackgroudColor"])
    {
        color = [UIColor blackColor];
        //systemTextColor = [UIColor blackColor];
    }
    else{
        color = [UIColor colorWithRed:141.0/255.0  green:154.0/255.0 blue:171.0/255.0 alpha:1.0];
        //systemTextColor = [UIColor whiteColor];
    }
    return color;
}

// 将字典或者数组转化为JSON串
+ (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        //NSLog(@"%@",jsonData);
        
        return jsonData;
    }else{
        return nil;
    }
}
// 将JSON串转化为字典或者数组
+(id)toArrayOrNSDictionary:(NSData *)jsonData{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil&& error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}



+ (CGSize)textSizeWithFont:(UIFont *)font str:(NSString*)name
{
    CGSize textSize;
    if (CGSizeEqualToSize(CGSizeMake(100, 1000), CGSizeZero))
    {
        //            NSDictionary *attributes = @{NSFontAttributeName:font}
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        //            textSize = [self sizeWithAttributes:attributes];
        //            textSize = []
        
        textSize = [name sizeWithAttributes:attributes];
    }
    else
    {
        if([[[UIDevice currentDevice] systemVersion] floatValue]<7.0)
        {
            NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
            CGRect rect = [name boundingRectWithSize:CGSizeMake(100, 1000)
                                             options:option
                                          attributes:attributes
                                             context:nil];
            textSize = rect.size;
 
        }
        else{
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [name boundingRectWithSize:CGSizeMake(100, 1000)
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
        }
    }
    return textSize;
}

+(UILabel*)setPublicLable:(NSString*)title font:(UIFont*)font frame:(CGRect)frame textColor:(UIColor*)textColor
{
    UILabel* lable = [[UILabel alloc]initWithFrame:frame];
    lable.textColor = textColor;
    lable.text = title;
    lable.backgroundColor = [UIColor clearColor];
    lable.font = font;
    return lable;
}
+ (void)showHUD:(NSString *)msg{
	
    
    
    
}
+ (void)showHUD:(NSString *)msg currentView:(UIView*)View{
	
    
}
+ (void)removeHUD
{
	
}


//
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alphaValue];
}

+ (UIColor*) colorWithHex:(NSInteger)hexValue
{
    return [[self class] colorWithHex:hexValue alpha:1.0];
}

+ (NSString *) hexFromUIColor: (UIColor*) color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%x%x%x", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

+(NSString *)HidePhoneNumber:(NSString *)mobile
{
    NSRange range;
    range.length=4;
    range.location=4;
    if (mobile.length<1 ||(mobile==nil) ||[mobile isEqualToString:@""])
    {
        mobile=@"";
    }
    else
    {
        mobile=[mobile stringByReplacingCharactersInRange:range withString:@"****"];
    }
    return mobile;
}

+(UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+(void)fuCity:(NSString *) FUcity
{
    //    NSString * FUcity=placemark.administrativeArea;
    //    NSString * FUlocality=placemark.locality;
    
    
    NSDictionary *provinceAndCity = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fu" ofType:@"plist"]];
    NSMutableArray * proList=[provinceAndCity objectForKey:FUcity];
    NSString *str1=[NSString stringWithFormat:@"%@市",FUcity];
    if ([provinceAndCity objectForKey:str1]) {
        proList=[provinceAndCity objectForKey:str1];
    }
    else
    {
        NSString *str2=[NSString stringWithFormat:@"%@区",FUcity];
        if ([provinceAndCity objectForKey:str2]) {
            proList=[provinceAndCity objectForKey:str2];
        }
        NSString *str3=[NSString stringWithFormat:@"%@地区",FUcity];
        if ([provinceAndCity objectForKey:str3]) {
            proList=[provinceAndCity objectForKey:str3];
        }
        
        NSString *str4=[NSString stringWithFormat:@"%@州",FUcity];
        if ([provinceAndCity objectForKey:str4]) {
            proList=[provinceAndCity objectForKey:str4];
        }
        NSString *str5=[NSString stringWithFormat:@"%@自治州",FUcity];
        if ([provinceAndCity objectForKey:str5]) {
            proList=[provinceAndCity objectForKey:str5];
        }
        NSString *str6=[NSString stringWithFormat:@"%@县",FUcity];
        if ([provinceAndCity objectForKey:str6]) {
            proList=[provinceAndCity objectForKey:str6];
        }
        
        NSString *str7=[NSString stringWithFormat:@"%@特别行政区",FUcity];
        if ([provinceAndCity objectForKey:str7]) {
            proList=[provinceAndCity objectForKey:str7];
        }
    }
    

    if (FUcity==nil || [FUcity isEqualToString:@""] )
    {
        FUcity=@"福州市";
        
        proList=[provinceAndCity objectForKey:FUcity];
    }
    
    
//    NSArray *arr=[[NSArray alloc]init];
//    arr=[proList objectForKey:@"0"];
//    for (NSString *tempKey in [proList allKeys]) {
//        arr=[proList objectForKey:tempKey];
//        
//    }
    [[NSUserDefaults standardUserDefaults] setValue:proList forKey:@"FUcity"];
    
    
}

+(void)fuCityQ:(NSString *) FUcity locality:(NSString *) FUlocality
{
//    NSString * FUcity=placemark.administrativeArea;
//    NSString * FUlocality=placemark.locality;
    
    
    NSDictionary *provinceAndCity = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvinceAndCity" ofType:@"plist"]];
    NSMutableArray * proList=[provinceAndCity objectForKey:FUcity];
    if (FUcity==nil || [FUcity isEqualToString:@""] )
    {
        FUcity=@"福建省";
        FUlocality=@"福州市";
        proList=[provinceAndCity objectForKey:FUcity];
    }
    
    
//    NSArray *arr=[[NSArray alloc]init];
//    for (NSString *tempKey in [proList allKeys]) {
//        NSDictionary *temparr=[proList objectForKey:tempKey];
//        if([temparr objectForKey:FUlocality])
//        {
//            arr=[temparr objectForKey:FUlocality];
//        }
//        
//    }
    [[NSUserDefaults standardUserDefaults] setValue:proList forKey:@"FUcity"];
    
    
}
+(void)fuCityQ:(CLPlacemark *)placemark
{
    NSString * FUcity=placemark.administrativeArea;
    NSString * FUlocality=placemark.locality;
    
    
    NSDictionary *provinceAndCity = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvinceAndCity" ofType:@"plist"]];
    NSDictionary * proList=[provinceAndCity objectForKey:FUcity];
    if (FUcity==nil || [FUcity isEqualToString:@""] )
    {
        FUcity=@"福建省";
        FUlocality=@"福州市";
        proList=[provinceAndCity objectForKey:FUcity];
    }
    
    
    NSArray *arr=[[NSArray alloc]init];
    for (NSString *tempKey in [proList allKeys]) {
        NSDictionary *temparr=[proList objectForKey:tempKey];
        if([temparr objectForKey:FUlocality])
        {
            arr=[temparr objectForKey:FUlocality];
        }
        
    }
    [[NSUserDefaults standardUserDefaults] setValue:arr forKey:@"FUcity"];
    
    
}




+(NSMutableDictionary *)FUDoDicttionary:(NSMutableDictionary *)mDict
{
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc]initWithDictionary:mDict];
    for (NSString *TempKey in [tempDict allKeys])
    {
        if ([tempDict objectForKey:TempKey]==nil ||
            [[tempDict objectForKey:TempKey] isKindOfClass:[NSNull class]] ||
            [tempDict objectForKey:TempKey] ==NULL  ||
            [[tempDict objectForKey:TempKey] isEqual:[NSNull null]] )
        {
            [tempDict setObject:@"" forKey:TempKey];
        }
    }
    return tempDict;
}

+(BOOL)FUDoDicttionaryNULL:(id)mDict
{
    
    if (mDict==nil ||
        [mDict isKindOfClass:[NSNull class]] ||
        mDict ==NULL  ||
        [mDict isEqual:[NSNull null]] )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark 保留有需要的字符
/**保留有需要的字符
 *strNew 要处理的字符串
 *keepStr 要保留的字符串类型
 */
+(NSString *)RetainRequiredCharacters:(NSString *)strNew keepStr:(NSString *)keepStr
{
    strNew = [[strNew componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:keepStr] invertedSet]] componentsJoinedByString:@","];
    //    strNew =[NSString stringWithFormat:@"%@\\n",strNew];
    return strNew;
}
/**判断用户输入的邮箱地址是否合法的代码
 电子邮箱的地址里允许使用的字符是特殊的，我们可以在应用里加入邮箱地址合法性判断功能，防止用户输入错误的字符。
 正确返回YES
 */
+(BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}



//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//检查输入是否为中文 单字符
+(BOOL)CheckForChinese1:(NSString *) str
{
    BOOL isChinese=NO;
    if (str.length > 0)
    {
        int utfCode = 0;
        void *buffer = &utfCode;
        NSRange range = NSMakeRange(str.length - 1, 1);
        NSString *word = [str substringWithRange:range];
        BOOL b = [word getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
        if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        {
            isChinese= YES;
        }
        else
        {
            isChinese= NO;
        }
        
    }
    else
    {
        isChinese=YES;
    }
    return isChinese;
}
//检查输入是否为中文
+(BOOL)CheckForChinese:(NSString *) str
{
    
    BOOL isChinese=NO;
    for (int i=0; i< [str length];i++)
    {
        
        NSRange range=NSMakeRange(i,1);
        
        NSString *subString=[str substringWithRange:range];
        isChinese=[[self class] CheckForChinese1:subString];
    }
    return isChinese;
    
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 14) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(flag)
    {
        if(identityCard.length==18)
        {
            //将前17位加权因子保存在数组里
            NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
            
            //这是除以11后，可能产生的11位余数、验证码，也保存成数组
            NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
            
            //用来保存前17位各自乖以加权因子后的总和
            
            NSInteger idCardWiSum = 0;
            for(int i = 0;i < 17;i++)
            {
                NSInteger subStrIndex = [[identityCard substringWithRange:NSMakeRange(i, 1)] integerValue];
                NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
                
                idCardWiSum+= subStrIndex * idCardWiIndex;
                
            }
            
            //计算出校验码所在数组的位置
            NSInteger idCardMod=idCardWiSum%11;
            
            //得到最后一位身份证号码
            NSString * idCardLast= [identityCard substringWithRange:NSMakeRange(17, 1)];
            
            //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
            if(idCardMod==2)
            {
                if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
                {
                    return flag;
                }else
                {
                    flag =  NO;
                    return flag;
                }
            }else
            {
                //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
                {
                    return flag;
                }
                else
                {
                    flag =  NO;
                    return flag;
                }
            }
        }
        else
        {
            flag =  NO;
            return flag;
        }
    }
    else
    {
        return flag;
    }
}


 //验证身份证
//必须满足以下规则
 //1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
//2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
 //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
 //4. 第17位表示性别，双数表示女，单数表示男
 //5. 第18位为前17位的校验位
 //算法如下：
 //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
 //（2）余数 ＝ 校验和 % 11
 //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
 //6. 出生年份的前两位必须是19或20
+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         if ([value length] != 18) {
                 return NO;
             }
         NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
         NSString *leapMmdd = @"0229";
         NSString *year = @"(19|20)[0-9]{2}";
         NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
         NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
         NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
         NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
         NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
         NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
         NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
         if (![regexTest evaluateWithObject:value]) {
                 return NO;
            }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4+ ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2+ [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6+ [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

//验证军官证或警官证
//必须是下面两种格式中的一种
//格式一：4到20位数字
//格式二：大于或等于10位并且小于等于20位（中文按两位），并满足以下规则
//1）必须有“字第”两字
//2）“字第”前面有至少一个字符
//3）“字第”后是4位以上数字
//+ (BOOL)verifyCardNumberWithSoldier:(NSString *)value
//{
//    NSString *s1 = @"^\\d*$";
//    NSString *s2 = @"^.{1,}字第\\d{4,}$";
//    //NSString *s3 = @"^([A-Za-z0-9\\u4e00-\\u9fa5])*$";
//    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    if ([[self class] verifyText:value withRegex:s1]) {
//        NSString *s11 = @"^\\d{4,20}$";
//                 return [value isMatchedByRegex:s11];
//            } else if ([self lengthUsingChineseCharacterCountByTwo:value] >= 10
//                                         && [self lengthUsingChineseCharacterCountByTwo:value] <= 20) {
//                    return [value isMatchedByRegex:s2];
//                 }
//    return NO;
//}

+ (NSUInteger)lengthUsingChineseCharacterCountByTwo:(NSString *)string{
    NSUInteger count = 0;
    for (NSUInteger i = 0; i< string.length; ++i)
    {
        if ([string characterAtIndex:i] < 256)
        {
            count++;
            
        } else {
                    count += 2;
                }
    }
    return count;
}

//验证身份证是否成年且小于100岁****这个方法中不做身份证校验，请确保传入的是正确身份证
//+ (BOOL)verifyIDCardHadAdult:(NSString *)card
//{
//    NSString *birtday = [[self class] getIDCardBirthday:card];   //****年**月**日
//    //转换为****-**-**
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"日" withString:@""];
//    birtday = [NSString stringWithFormat:@"%@ 00:00",birtday];
//    NSDate *dateBirtday = [NSDate date dateFromString:birtday];
//    NSInteger year = [[NSDate date] getIntervalTime:dateBirtday withDateType:DateTypeYear];   //得到年数
//    
//    if (year >= 18 && year < 100) {
//                return YES;
//           } else {
//                    return NO;
//     }
//    
//}

//验证身份证加上指定天数是否大于指定number的类型
//+ (BOOL)verifyIDCardMoreThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType
//{
//    NSString *birtday = [[self class] getIDCardBirthday:card];   //****年**月**日
//    //转换为****-**-**
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"日" withString:@""];
//    birtday = [NSString stringWithFormat:@"%@ 00:00",birtday];
//    NSDate *dateBirtday = [NSDate dateFromString:birtday];
//    NSDate *today = [NSDate dateFromStringWithoutTime:[[NSDate date] strDate]];
//    NSDate *pointDate = [today dateByAddingTimeInterval:interval];
//    
//    //tempDate为number后的日期
//    NSDate *tempDate = [pointDate dateAddNumber:-number withDateType:dateType];  //临界日期
//    if ([dateBirtday earlierDate:tempDate] == dateBirtday) {  //如果生日＋指定天数大雨tempdate，则通过
//                 return YES;
//             } else {
//                     return NO;
//                 }
//}

//验证身份证加上指定天数是否小于指定number的类型
//+ (BOOL)verifyIDCardLessThanPointDate:(NSString *)card withNumber:(NSInteger)number withAddTimeInterval:(NSTimeInterval)interval withDateType:(DateType)dateType
//{
//    NSString *birtday = [[self class] getIDCardBirthday:card];   //****年**月**日
//    //转换为****-**-**
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    birtday = [birtday stringByReplacingOccurrencesOfString:@"日" withString:@""];
//    birtday = [NSString stringWithFormat:@"%@ 00:00",birtday];
//    NSDate *dateBirtday = [NSDate dateFromString:birtday];
//    NSDate *today = [NSDate dateFromStringWithoutTime:[[NSDate date] strDate]];
//    NSDate *pointDate = [today dateByAddingTimeInterval:interval];
//    
//   
//    //tempDate为number后的日期
//    NSDate *tempDate = [pointDate dateAddNumber:-number withDateType:dateType];  //临界日期
//    if ([tempDate earlierDate:dateBirtday] == tempDate)
//    {  //如果生日＋指定天数小于tempdate，则通过
//        return YES;
//    } else
//    {
//        return NO;
//            
//    }
//}

//得到身份证的生日****这个方法中不做身份证校验，请确保传入的是正确身份证
+ (NSString *)getIDCardBirthday:(NSString *)card
{
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([card length] != 18) {
        return nil;
    }
    NSString *birthady = [NSString stringWithFormat:@"%@-%@-%@",[card substringWithRange:NSMakeRange(6,4)], [card substringWithRange:NSMakeRange(10,2)], [card substringWithRange:NSMakeRange(12,2)]];
    return birthady;
}

//得到身份证的性别（1男0女）****这个方法中不做身份证校验，请确保传入的是正确身份证
+ (NSInteger)getIDCardSex:(NSString *)card
{
    card = [card stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger defaultValue = 0;
    if ([card length] != 18)
    {
        return defaultValue;
    }
    NSInteger number = [[card substringWithRange:NSMakeRange(16,1)] integerValue];
    if (number % 2 == 0) {  //偶数为女
                 return 0;
             } else {
                     return 1;
                 
     }
}

//纯数字
+ (BOOL)validateNumber:(NSString *)FUNumber
{
    NSString *regex2 = @"^[0-9]*$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:FUNumber];
}


+(CGFloat)FULableZSY:(NSString *)str Label:(UILabel *)label
{
    CGSize labelSize = {0, 0};
    CGFloat fontOfSize=label.font.pointSize;
    
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontOfSize] forKey:NSFontAttributeName];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(label.bounds.size.width, 5000)
                                     options:option
                                  attributes:attributes
                                     context:nil];
    labelSize = rect.size;
    
    //14 为UILabel的字体大小
    
    //200为UILabel的宽度，5000是预设的一个高度，表示在这个范围内
    
    label.numberOfLines = 0;//表示label可以多行显示
    
    label.lineBreakMode = NSLineBreakByTruncatingTail;//换行模式，与上面的计算保持一致。
    
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, labelSize.height);
    return label.frame.size.height;
    
}

+(CGFloat)FULableZSY:(NSString *)str Label:(UILabel *)label LabelWidth:(CGFloat)newWidth
{
    CGSize labelSize = {0, 0};
    CGFloat fontOfSize=label.font.pointSize;
    
    NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontOfSize] forKey:NSFontAttributeName];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(newWidth, 5000)
                                    options:option
                                 attributes:attributes
                                    context:nil];
    labelSize = rect.size;
    
    //14 为UILabel的字体大小
    
    //200为UILabel的宽度，5000是预设的一个高度，表示在这个范围内
    
    label.numberOfLines = 0;//表示label可以多行显示
    
    label.lineBreakMode = NSLineBreakByTruncatingTail;//换行模式，与上面的计算保持一致。
    
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, labelSize.height);
    return label.frame.size.height;
    
}

#pragma mark 拨打电话
+(void)callTel:(NSString *)number superView:(UIView *) view
{
    //    NSString *number = @"13696859373";// 此处读入电话号码
    //        //购买记录
    //        NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    
    if (nil == number || [number isKindOfClass:[NSNull class]] || [number isEqualToString:@""])
    {
        //NSLog(@"号码不正确");
        return;
    }
    
    UIWebView *callWebview =[[UIWebView alloc] init];
    
    NSString *telUrl = [NSString stringWithFormat:@"tel:%@",number];
    
    NSURL *telURL =[NSURL URLWithString:telUrl];// 貌似tel:// 或者 tel: 都行
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [view addSubview:callWebview];
    
}


/**字典转data
 */
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict
{
    
    NSMutableData* data = [[NSMutableData alloc]init];
    
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    [archiver encodeObject:dict forKey:@"talkData"];
    
    [archiver finishEncoding];
    
    return data;
    
}

/**路径文件转dictonary
 */
+(NSDictionary*)returnDictionaryWithDataPath:(NSString*)path
{
    
    NSData* data = [[NSMutableData alloc]initWithContentsOfFile:path];
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    //    NSLog(@"%@", myDictionary);
    
    return myDictionary;
    
}
/** data文件转dictonary
 */
+(NSDictionary*)returnDictionaryWithData:(NSData *)data
{
    
    
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    //    NSLog(@"%@", myDictionary);
    
    return myDictionary;
    
}



/**
 ios通过经纬度计算两个之间的距离
 返回 距离单位米
 */
+(double)distanceBetweenOrderByLat1:(double)lat1 Lat2:(double)lat2 Lng1:(double)lng1 Lng2:(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    return   distance;
    
}
/**
 ios通过经纬度计算两个之间的距离
 返回 距离单位千米 KM
 */
+(double)distanceBetweenKMOrderByLat1:(double)lat1 Lat2:(double)lat2 Lng1:(double)lng1 Lng2:(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    distance=distance/1000.0;
    
    //返回KM
    return   distance;
    
}

#pragma mark 画虚线
/**
 *画虚线
 *初始坐标的InitialX,InitialY
 *终点坐标的EndPointX,EndPointY
 *StrokeColor 设置虚线颜色
 */
+(void)DrawDottedLine:(UIView *) superView
  InitialcoordinatesX:(NSInteger)InitialX
  InitialcoordinatesY:(NSInteger)InitialY
  EndPointCoordinateX:(NSInteger)EndPointX
  EndPointCoordinateY:(NSInteger)EndPointY
       setStrokeColor:(UIColor *)StrokeColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:superView.bounds];
    [shapeLayer setPosition:superView.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[StrokeColor CGColor]];
    
    // 1.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 2=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
      [NSNumber numberWithInt:1],nil]];
    
    // Setup the path
    //    CGMutablePathRef path = CGPathCreateMutable();
    //    CGPathMoveToPoint(path, NULL, 0, 89);
    //    CGPathAddLineToPoint(path, NULL, 320,89);
    
    // Setup the path
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, InitialX, InitialY);
    CGPathAddLineToPoint(path2, NULL, EndPointX,EndPointY);
    
    //    [shapeLayer setPath:path];
    //    CGPathRelease(path);
    [shapeLayer setPath:path2];
    CGPathRelease(path2);
    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [[superView layer] addSublayer:shapeLayer];
}

#pragma mark 打开网页
+(void)openWeb:(NSString *)urlText
{
    [ [UIApplication sharedApplication] openURL:[ NSURL URLWithString:urlText]];
}


+ (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *date8 = [[self class] getCustomDateWithHour:fromHour];
    NSDate *date23 = [[self class] getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        //        NSLog(@"该时间在 %d:00-%d:00 之间！", fromHour, toHour);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}

#pragma mark 删除文件 png jpg jpeg
+(void)removeImageFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:@"png"] || [[filename pathExtension] isEqualToString:@"jpg"] ||[[filename pathExtension] isEqualToString:@"jpeg"]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}
#pragma mark 删除文件_指定后缀名的文件
+(void)removeF:(NSString *) extension
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}
//判断文件夹总大小
//遍历文件夹获得文件夹大小，返回多少M

+ (float ) folderSizeAtPath:(NSString*) folderPath
{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [[self class] fileSizeAtPath:fileAbsolutePath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}
//判断单个文件大小

//单个文件的大小

+ (long long) fileSizeAtPath:(NSString*) filePath
{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+(NSString *)getCacheNumberWithStr
{
    NSArray  *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];//
    CGFloat abb=[[self class] folderSizeAtPath:docPath];
    return [NSString stringWithFormat:@"%0.1f KB",abb];
    //    NSLog(@"%lf",abb);
}

#pragma mark 去除数组中重复的 利用NSDictionary的AllKeys（AllValues）方法
+(NSMutableArray *)FUArrayRemovalMethodNSDictionary:(NSArray *)dataArray
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
    for(NSString *str in dataArray)
    {
        [dic setValue:str forKey:str];
    }
    NSMutableArray *listAry =[[NSMutableArray alloc]initWithArray:[dic allKeys]];
    //    NSLog(@"%@",listAry);
    return listAry;
}
#pragma mark 去除数组中重复的 利用NSSet的AllObjects方法
+(NSMutableArray *)FUArrayRemovalMethodNSSet:(NSArray *)dataArray
{
    NSSet *set = [NSSet setWithArray:dataArray];
    
    NSMutableArray *listAry =[[NSMutableArray alloc]initWithArray:[set allObjects]];
    //    NSLog(@"%@",listAry);
    return listAry;
}


#pragma mark 去除数组中重复的 循环
+(NSMutableArray *)FUArrayRemovalMethodForin:(NSArray *)dataArray
{
    NSMutableArray *listAry = [[NSMutableArray alloc]init];
    for (NSString *str in dataArray) {
        if (![listAry containsObject:str]) {
            [listAry addObject:str];
        }
    }
    return listAry;
}



-(void)selectSortWithArray:(NSArray *)aData{
    NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
    for (int i=0; i<[data count]-1; i++) {
        int m =i;
        for (int j =i+1; j<[data count]; j++) {
            if ([data objectAtIndex:j] < [data objectAtIndex:m]) {
                m = j;
            }
        }
        if (m != i) {
            [self swapWithData:data index1:m index2:i];
        }
    }
//    NSLog(@"选择排序后的结果：%@",data );
    
}

-(void)insertSortWithArray:(NSArray *)aData{
    NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
    for (int i = 1; i < [data count]; i++) {
        id tmp = [data objectAtIndex:i];
        int j = i-1;
        while (j != -1 && [data objectAtIndex:j] > tmp) {
            [data replaceObjectAtIndex:j+1 withObject:[data objectAtIndex:j]];
            j--;
        }
        [data replaceObjectAtIndex:j+1 withObject:tmp];
    }
//    NSLog(@"插入排序后的结果：%@",data);
    
}

-(void)quickSortWithArray:(NSArray *)aData{
    NSMutableArray *data = [[NSMutableArray alloc] initWithArray:aData];
    [self quickSortWithArray:data left:0 right:[aData count]-1];
//    NSLog(@"快速排序后的结果：%@",data);
    
    
}

-(void)quickSortWithArray:(NSMutableArray *)aData left:(NSInteger)left right:(NSInteger)right{
    if (right > left) {
        NSInteger i = left;
        NSInteger j = right + 1;
        while (true) {
            while (i+1 < [aData count] && [aData objectAtIndex:++i] < [aData objectAtIndex:left]) ;
            while (j-1 > -1 && [aData objectAtIndex:--j] > [aData objectAtIndex:left]) ;
            if (i >= j) {
                break;
            }
            [self swapWithData:aData index1:i index2:j];
        }
        [self swapWithData:aData index1:left index2:j];
        [self quickSortWithArray:aData left:left right:j-1];
        [self quickSortWithArray:aData left:j+1 right:right];
    }
}



-(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2{
    NSNumber *tmp = [aData objectAtIndex:index1];
    [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
    [aData replaceObjectAtIndex:index2 withObject:tmp];
}

//oc实现排序算法
//下面是我用oc实现的快速排序，冒泡排序，直接插入排序和折半插入排序，希尔排序，堆排序，直接选择排序


//随即取 当前取第一个，首先找到第一个的位置，然后分成left和right两组子集 ，分别对left和right继续执行分割(同上操作)

-(void)QuickSort:(NSMutableArray *)list StartIndex:(NSInteger)startIndex EndIndex:(NSInteger)endIndex{
    
    if(startIndex >= endIndex)return;
    
    NSNumber * temp = [list objectAtIndex:startIndex];
    NSInteger tempIndex = startIndex; //临时索引 处理交换位置(即下一个交换的对象的位置)
    
    for(NSInteger i = startIndex + 1 ; i <= endIndex ; i++){
        
        NSNumber *t = [list objectAtIndex:i];
        
        if([temp intValue] > [t intValue]){
            
            tempIndex = tempIndex + 1;
            
            [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:i];
            
        }
        
    }
    
    [list exchangeObjectAtIndex:tempIndex withObjectAtIndex:startIndex];
    [self QuickSort:list StartIndex:startIndex EndIndex:tempIndex-1];
    [self QuickSort:list StartIndex:tempIndex+1 EndIndex:endIndex];
    
}




//取第一个 与其邻接的对比，若大则交换
-(void)BubbleSort:(NSMutableArray *)list{
    
    for (NSInteger j = 1; j<= [list count]; j++) {
        
        for(NSInteger i = 0 ;i < j ; i++){
            
            if(i == [list count]-1)return;
            
            NSInteger a1 = [[list objectAtIndex:i] intValue];
            NSInteger a2 = [[list objectAtIndex:i+1] intValue];
            
            if(a1 > a2){
                [list exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            }
            
        }
        
    }
    
}



//从无序表中取出第一个元素，插入到有序表的合适位置，使有序表仍然有序
-(void)InsertSort:(NSMutableArray *)list{
    
    for(NSInteger i = 1 ; i < [list count] ; i++){
        
        
        NSInteger j = i;
        NSInteger temp= [[list objectAtIndex:i] intValue];
        
        while (j > 0 && temp < [[list objectAtIndex:j - 1]intValue]) {
            
            [list replaceObjectAtIndex:j withObject:[list objectAtIndex:(j-1)]];
            //list[j] = list[j-1];
            j--;
            
        }
        [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
        //list[j] = temp;
        
    }
    
}



//从无序表中取出第一个元素，利用折半查找插入到有序表的合适位置，使有序表仍然有序
-(void)BinaryInsertSort:(NSMutableArray *)list{
    
    //索引从1开始 默认让出第一元素为默认有序表 从第二个元素开始比较
    for(NSInteger i = 1 ; i < [list count] ; i++){
        
        //binary search start
        NSInteger temp= [[list objectAtIndex:i] intValue];
        
        NSInteger left = 0;
        NSInteger right = i - 1;
        
        while (left <= right) {
            
            NSInteger middle = (left + right)/2;
            
            if(temp < [[list objectAtIndex:middle] intValue]){
                
                right = middle - 1;
                
            }else{
                
                left = middle + 1;
                
            }
            
        }
        //binary search end
        
        //移动3,5,6,[4] 4是当前目标对象 利用binarysearch 找到4应该在有续集{3,5,6}的位置，然后向后移动即{3,5,6,[4]}-->{3,[4],5,6}
        for(NSInteger j = i ; j > left; j--){
            
            [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-1]];
            
        }
        [list replaceObjectAtIndex:left withObject:[NSNumber numberWithInteger:temp]];
        
    }
    
    
}



//对直接插入排序优化，创造一个gap 来对表进行分割，对分割后的每个子集进行直接插入排序 知道gap＝＝1结束
-(void)shellSort:(NSMutableArray *)list{
    NSInteger gap = [list count] / 2;
    
    while (gap >= 1) {
        
        
        for(NSInteger i = gap ; i < [list count]; i++){
            
            NSInteger temp = [[list objectAtIndex:i] intValue];
            NSInteger j = i;
            
            while (j >= gap && temp < [[list objectAtIndex:(j - gap)] intValue]) {
                [list replaceObjectAtIndex:j withObject:[list objectAtIndex:j-gap]];
                j -= gap;
            }
            [list replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
            
            
        }
        
        gap = gap / 2;
    }
    
    
}


//创建最大堆heap 最大／最小优先级队列
-(void)CreateBiggestHeap:(NSMutableArray *)list Count:(NSInteger)count{
    
    //int count = [list count];
    NSInteger lastParentIndex = (count - 2)/2;
    for(NSInteger i = lastParentIndex; i >= 0 ; i--){
        
        NSInteger parentIndex = i;
        NSInteger parentNode = [[list objectAtIndex:parentIndex] intValue];
        
        
        //获取左子结点为当前子结点
        NSInteger currentChildIndex = 2*i + 1;
        //
        
        while (currentChildIndex <= count - 1) {
            
            NSInteger leftChildNode = [[list objectAtIndex:(currentChildIndex)] intValue];
            
            if((currentChildIndex + 1) <= count-1){//表示存在右子结点
                
                //读取右子结点
                NSInteger rightChildIndex =currentChildIndex + 1;
                NSInteger rightChildNode = [[list objectAtIndex:(rightChildIndex)] intValue];
                
                //如果右子结点为最大
                if(rightChildNode > leftChildNode && rightChildNode > parentNode){
                    [list exchangeObjectAtIndex:parentIndex withObjectAtIndex:rightChildIndex];
                    currentChildIndex = rightChildIndex;//右子结点为当前子结点 继续循环
                    //左子结点最大
                }else if(leftChildNode > rightChildNode && leftChildNode > parentNode){
                    [list exchangeObjectAtIndex:parentIndex withObjectAtIndex:currentChildIndex];
                }
                
            }else{
                
                if(leftChildNode > parentNode){
                    [list exchangeObjectAtIndex:parentIndex withObjectAtIndex:currentChildIndex];
                    
                }
                
            }
            
            //更新父结点和下一个子结点
            parentIndex = currentChildIndex;
            currentChildIndex = 2*currentChildIndex + 1;
            
        }
        
    }
    
}

//每次执行最大堆(索引要前移动 即排除已经排好的最大堆头元算 交换到list尾部的这个元素)
-(void)HeapSort:(NSMutableArray *)list{
    
    for(NSInteger i = [list count] ; i > 0; i--){
        
        [self CreateBiggestHeap:list Count:i];
        
        //NSLog(@"%@",list);
        
        [list exchangeObjectAtIndex:(i-1) withObjectAtIndex:0];
        
    }
    
}


//在对象集中选出最小的 若不是第一个 则与第一个交换 在剩余的对象集中选出最小的 执行前面的步骤
-(void)SelectSort:(NSMutableArray *)list{
    
    for(NSInteger i = 0 ; i<[list count]; i++){
        
        NSInteger k = i;
        for(NSInteger j = i+1 ; j<[list count]; j++){
            
            NSInteger jvalue = [[list objectAtIndex:j] intValue];
            NSInteger kvalue = [[list objectAtIndex:k] intValue];
            
            if(jvalue < kvalue){
                k = j;
            }
            
        }
        if(k != i){
            [list exchangeObjectAtIndex:i withObjectAtIndex:k];
        }
        
    }
    
}

@end
