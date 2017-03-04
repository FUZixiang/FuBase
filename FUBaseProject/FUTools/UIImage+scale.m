//
//  UIImage+scale.m
//  aiyu
//
//  Created by ibokan on 14-6-23.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import "UIImage+scale.h"

@implementation UIImage (scale)
-(UIImage *)scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
    
}
@end
