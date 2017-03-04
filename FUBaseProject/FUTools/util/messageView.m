

#import "messageView.h"
//#import "frameworkerHeader.h"

@implementation messageView
+(void)message: (NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"消息"
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil];
    [alert show];
}

+(NSString*)stringTaked:(NSString*)data
{
    NSRange rang1 = [data rangeOfString:@":"];
    NSRange rang2 = [data rangeOfString:@"}"];
    if(rang1.length && rang2.length){
 
        NSRange rang = NSMakeRange(rang1.location+1, rang2.location-rang1.location-1);
    

        NSString* code = [data substringWithRange:rang];
        return code;}
    return nil;
}
+(void)messageAutoHide: (NSString*)msg
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:nil
                          message:msg
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:nil];
    [alert show];
    [messageView messagehideIn:0.75 view:alert];
}
+ (void)messagehideIn:(float)seconds view: (UIAlertView*)alert{
    //if(!notifierShow) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1f];
        [UIView setAnimationDelegate: self]; //or some other object that has necessary method
       // [UIView setAnimationDidStopSelector: @selector(removeFromSuperview)];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        //CGRect move = self.frame;
        //move.origin.y +=40.f;
        //self.frame = move;
        
        [UIView commitAnimations];
        //notifierShow = FALSE;
    });
    
    
}
@end
