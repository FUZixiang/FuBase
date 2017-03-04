/*
 * 文件名:Notifier
 *
 * 描  述:
 * 创建人:lianwengao
 * 日 期:2013-9-24
 */

#import "Notifier.h"

#define _displaytime 4.f

BOOL notifierShow = FALSE;
static Notifier* notify;
@implementation Notifier
@synthesize accessoryView, title = _title;

+(void)notifierShow: (NSString* )title Time:(float)time
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         notify = [[Notifier alloc]initWithTitle:title];
        
    });
    notify.title = title;
//    notify->_txtLabel.font.
    //CGSize nSize = [notify  stringSizeWithFont:[UIFont systemFontOfSize:12] str:title];
    
//    CGSize maximumLabelSize = CGSizeMake(9999, 35);
//    CGSize maximumLabelSize = CGSizeMake(9900,9999);
//    CGSize nSize1 = [title sizeWithFont:[UIFont systemFontOfSize:12]
//                     constrainedToSize:maximumLabelSize
//                         lineBreakMode:NSLineBreakByTruncatingTail];
    
    
    CGFloat fontOfSize=notify->_txtLabel.font.pointSize;
//    CGFloat txtLSize=notify->_txtLabel.bounds.size.width;
    CGSize nSize = [title sizeWithFont:[UIFont systemFontOfSize:fontOfSize]
                constrainedToSize:CGSizeMake(200, 5000)
                    lineBreakMode:NSLineBreakByTruncatingTail];
    
    
    if(nSize.width > [UIScreen mainScreen].bounds.size.width/3*2)
    {
//        notify.frame  = CGRectMake(([UIScreen mainScreen].bounds.size.width - nSize.width-20)/2, [UIScreen mainScreen].bounds.size.height-60, nSize.width+20, 35);
        
        notify.frame  = CGRectMake(([UIScreen mainScreen].bounds.size.width - nSize.width)/2, [UIScreen mainScreen].bounds.size.height/3*2, nSize.width, nSize.height);
        
        [notify setLableframe];
    }
    else
    {
        notify.frame  = CGRectMake(([UIScreen mainScreen].bounds.size.width - nSize.width-20)/2, [UIScreen mainScreen].bounds.size.height/3*2, nSize.width+20, nSize.height+20);
        
        [notify setLableframe];
    }

//    notify.frame  = CGRectMake(([UIScreen mainScreen].bounds.size.width - nSize.width)/2, [UIScreen mainScreen].bounds.size.height/3*2, nSize.width, nSize.height);
//    
//    [notify setLableframe];
    [notify showFor:time];
    
   
}


- (id)initWithTitle:(NSString *)title
{
      if(notifierShow) [self hideFrameView];
    
    if (self = [super initWithFrame:CGRectMake(100, [UIScreen mainScreen].bounds.size.height-60, [UIScreen mainScreen].bounds.size.width/3*2, 35)]){
        self.tag =3001;
    
        self.backgroundColor = [UIColor clearColor];
        
        UIColor *whiteColor = [UIColor colorWithRed:0.816 green:0.788 blue:0.788 alpha:1.000];
        
   
        //self.alpha = 0.5;
        
        //UILabel* backgroundLabel = [UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 22)
        
        _txtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , 25)];
#pragma mark 设置字体
        [_txtLabel setFont:[UIFont fontWithName: @"Helvetica" size: 14]];
        _txtLabel.numberOfLines=0;
        //[_txtLabel setBackgroundColor:[UIColor blackColor]];
        //_txtLabel.alpha = 0.4;
    
        _txtLabel.textAlignment = NSTextAlignmentCenter;
        
        [_txtLabel setTextColor:[UIColor whiteColor]];
        
        //_txtLabel.layer.cornerRadius = 5;
        
        //self.layer.borderColor = [UIColor blackColor].CGColor;
        //_txtLabel.layer.borderWidth = 1;//边线
        //_txtLabel.layer.cornerRadius = 7;//圆角
        //阴影
        // _txtLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        // _txtLabel.layer.shadowOffset = CGSizeMake(0,3);
        // _txtLabel.layer.shadowOpacity = 1.0;
        // _txtLabel.layer.shadowRadius = 10.0;
        _txtLabel.clipsToBounds = YES;
        _txtLabel.layer.masksToBounds = YES;
        
        
        _txtLabel.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8f];
        _txtLabel.layer.borderColor = whiteColor.CGColor;
        _txtLabel.layer.borderWidth = 1.2f;
        _txtLabel.layer.cornerRadius = 7.f;
        [self addSubview:_txtLabel];
        
        self.title= title;


        
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    }
    
    return self;
}


-(void)setLableframe
{
//    _txtLabel.frame = CGRectMake(0, 0, self.frame.size.width , 25);
    _txtLabel.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
}

- (void)setAccessoryView:(UIView *)__accessoryView{
        
    [[self viewWithTag:1]removeFromSuperview];
    
    __accessoryView.tag = 1;
    [__accessoryView setFrame:CGRectMake(12, ((self.frame.size.height -__accessoryView.frame.size.height)/2)+1, __accessoryView.frame.size.width, __accessoryView.frame.size.height)];
    
    [self addSubview:__accessoryView];
    
    if (__accessoryView)
        [_txtLabel setFrame:CGRectMake(38, 12, self.frame.size.width - 38, 20)];
    else
        [_txtLabel setFrame:CGRectMake(8, 12, self.frame.size.width - 8, 20)];
}

- (void)setTitle:(NSString *)title{
    
    [_txtLabel setText:title];
}

- (void)show{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    
    CGRect move = self.frame;
    move.origin.y -=40.f;
    self.frame = move;
    
    [UIView commitAnimations];
      
}

- (void)showFor:(float)time{
    
    
    
    notifierShow = TRUE;
    //CGRect move = self.frame;
    //move.origin.y -=40.f;
    //self.frame = move;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    
  
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController)
        topController = topController.presentedViewController;
    
    
    
    [topController.view addSubview:self];
    
    [UIView commitAnimations];
    
    [self hideIn:time];
}

- (void)hideIn:(float)seconds{
    if(!notifierShow) return;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1f];
        [UIView setAnimationDelegate: self]; //or some other object that has necessary method
        [UIView setAnimationDidStopSelector: @selector(removeFromSuperview)];
        
        
        //CGRect move = self.frame;
        //move.origin.y +=40.f;
        //self.frame = move;
        
        [UIView commitAnimations];
         notifierShow = FALSE;
    });
   

}
-(void) hideFrameView
{
    //printf("泥马");
    if(!notifierShow) return;
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController)
        topController = topController.presentedViewController;
    
    
    for(UIView* sview in topController.view.subviews)
    {
        if(sview.tag ==3001)[sview removeFromSuperview];
    }
    
}

- (void)hide{
    if(!notifierShow) return;
    
    //[UIView beginAnimations:nil context:nil];
   // [UIView setAnimationDuration:0.1f];
   // [UIView setAnimationDelegate: self]; //or some other object that has necessary method
   // [UIView setAnimationDidStopSelector: @selector(removeFromSuperview)];
//    NSLog(@"隐藏");
    [self removeFromSuperview];
    //CGRect move = self.frame;
   // move.origin.y +=40.f;
   // self.frame = move;
        
    //[UIView commitAnimations];
    notifierShow = FALSE;
}


- (void)setAccessoryView:(UIView *)view animated:(BOOL)animated{

    if (!animated){
    [[self viewWithTag:1]removeFromSuperview];
    view.tag = 1;
    }
    
    [view setFrame:CGRectMake(12, ((self.frame.size.height -view.frame.size.height)/2)+1, view.frame.size.width, view.frame.size.height)];
    [self addSubview:view];
    
    if (animated) {
        view.alpha = 0.0;
        
        if ([self viewWithTag:1])
            view.tag = 0;
        else
            view.tag = 2;
    [UIView animateWithDuration:0.5
                     animations:^{
                         if ([self viewWithTag:1])
                            [self viewWithTag:1].alpha = 0.0;
                         else
                             view.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         
                         [[self viewWithTag:1]removeFromSuperview];
                         
                         [UIView animateWithDuration:0.5
                                          animations:^{
                                              view.alpha = 1.0;
                                              
                                          }
                                          completion:^(BOOL finished){
                                              
                                              view.tag = 1;
                                          }];
                         
                     }];
    }
    
    if (view)
        [_txtLabel setFrame:CGRectMake(38, 12, self.frame.size.width - 38, 20)];
    else
        [_txtLabel setFrame:CGRectMake(8, 12, self.frame.size.width - 8, 20)];



}

- (void)setTitle:(id)title animated:(BOOL)animated{
    
    float duration = 0.0;
    
    if (animated)
        duration = 0.5;
    
    [UIView animateWithDuration:duration
                     animations:^{
                      
                         _txtLabel.alpha = 0.0f;
                             
                     }
                     completion:^(BOOL finished){
                         
                         _txtLabel.text = title;
                         
                         [UIView animateWithDuration:duration
                                          animations:^{
                                              _txtLabel.alpha = 1.0f;

                                              
                                          }
                                          completion:^(BOOL finished){
                                              
                                          }];
                         
                     }];

}

-(CGSize)stringSizeWithFont:(UIFont *)font str:(NSString*)name
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
            CGSize mLblHieht = [name
                                sizeWithFont:font
                                constrainedToSize:CGSizeMake(100,1000)
                                lineBreakMode:NSLineBreakByWordWrapping];
            textSize = mLblHieht;
            
            
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

- (void)drawRect:(CGRect)rect{
    /*
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    
    CGRect rectangle = CGRectMake(0,4,320,36);
    CGContextAddRect(context, rectangle);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.6f].CGColor);
    CGContextFillRect(context, rectangle);
    
    //First whiteColor
    CGContextSetLineWidth(context, 1.0);
    CGFloat componentsWhiteLine[] = {1.0, 1.0, 1.0, 0.35};
    CGColorRef Whitecolor = CGColorCreate(colorspace, componentsWhiteLine);
    CGContextSetStrokeColorWithColor(context, Whitecolor);
    
    CGContextMoveToPoint(context, 0, 4.5);
    CGContextAddLineToPoint(context, 320, 4.5);
    
    CGContextStrokePath(context);
    CGColorRelease(Whitecolor);
    
    //First whiteColor
    CGContextSetLineWidth(context, 1.0);
    CGFloat componentsBlackLine[] = {0.0, 0.0, 0.0, 1.0};
    CGColorRef Blackcolor = CGColorCreate(colorspace, componentsBlackLine);
    CGContextSetStrokeColorWithColor(context, Blackcolor);
    
    CGContextMoveToPoint(context, 0, 3.5);
    CGContextAddLineToPoint(context, 320, 3.5);
    
    CGContextStrokePath(context);
    CGColorRelease(Blackcolor);
    
    //Draw Shadow
    
    CGRect imageBounds = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 3.f);
	CGRect bounds = CGRectMake(0, 0, 320, 3);
	CGFloat alignStroke;
	CGFloat resolution;
	CGMutablePathRef path;
	CGRect drawRect;
	CGGradientRef gradient;
	NSMutableArray *colors;
	UIColor *color;
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGPoint point;
	CGPoint point2;
	CGAffineTransform transform;
	CGMutablePathRef tempPath;
	CGRect pathBounds;
	CGFloat locations[2];
	resolution = 0.5f * (bounds.size.width / imageBounds.size.width + bounds.size.height / imageBounds.size.height);
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, bounds.origin.x, bounds.origin.y);
	CGContextScaleCTM(context, (bounds.size.width / imageBounds.size.width), (bounds.size.height / imageBounds.size.height));
	
	// Layer 1
	
	alignStroke = 0.0f;
	path = CGPathCreateMutable();
	drawRect = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, 3.0f);
	drawRect.origin.x = (roundf(resolution * drawRect.origin.x + alignStroke) - alignStroke) / resolution;
	drawRect.origin.y = (roundf(resolution * drawRect.origin.y + alignStroke) - alignStroke) / resolution;
	drawRect.size.width = roundf(resolution * drawRect.size.width) / resolution;
	drawRect.size.height = roundf(resolution * drawRect.size.height) / resolution;
	CGPathAddRect(path, NULL, drawRect);
	colors = [NSMutableArray arrayWithCapacity:2];
	color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
	[colors addObject:(id)[color CGColor]];
	locations[0] = 0.0f;
	color = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.18f];
	[colors addObject:(id)[color CGColor]];
	locations[1] = 1.0f;
	gradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, locations);
	CGContextAddPath(context, path);
	CGContextSaveGState(context);
	CGContextEOClip(context);
	transform = CGAffineTransformMakeRotation(-1.571f);
	tempPath = CGPathCreateMutable();
	CGPathAddPath(tempPath, &transform, path);
	pathBounds = CGPathGetPathBoundingBox(tempPath);
	point = pathBounds.origin;
	point2 = CGPointMake(CGRectGetMaxX(pathBounds), CGRectGetMinY(pathBounds));
	transform = CGAffineTransformInvert(transform);
	point = CGPointApplyAffineTransform(point, transform);
	point2 = CGPointApplyAffineTransform(point2, transform);
	CGPathRelease(tempPath);
	CGContextDrawLinearGradient(context, gradient, point, point2, (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
	CGContextRestoreGState(context);
	CGGradientRelease(gradient);
	CGPathRelease(path);
	
	CGContextRestoreGState(context);
	CGColorSpaceRelease(space);

    CGColorSpaceRelease(colorspace);*/
}
    
@end
