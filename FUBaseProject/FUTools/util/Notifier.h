
 /*
 * 文件名:Notifier.h
 * Copyright (c) 2010可比公司技术开发部
 * 描  述:
 * 创建人:lianwengao
 * 日 期:2013-9-24
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "frameworkerHeader.h"
extern BOOL notifierShow;

@interface Notifier : UIView{
    
    
    @protected
    UILabel *_txtLabel;
}
//+(void)notifierShow: (NSString* )title Time:(float)time;

- (id)initWithTitle:(NSString *)title;

- (void)setAccessoryView:(UIView *)view animated:(BOOL)animated;

- (void)setTitle:(id)title animated:(BOOL)animated;

- (void)show;
- (void)showFor:(float)time;

- (void)hide;
- (void)hideIn:(float)seconds;

-(CGSize)stringSizeWithFont:(UIFont *)font str:(NSString*)name;

+(void)notifierShow: (NSString* )title Time:(float)time;

@property (nonatomic, strong) UIView *accessoryView;
@property (nonatomic, strong) NSString *title;

@end

