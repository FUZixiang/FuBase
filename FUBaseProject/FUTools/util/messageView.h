

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface messageView : NSObject
+(void)message: (NSString*)msg;
+(NSString*)stringTaked:(NSString*)data;
+(void)messageAutoHide: (NSString*)msg;
@end
