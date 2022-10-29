//
//  Functions.m
//  SkyGaze
//
//  Created by Riyad Anabtawi on 1/11/15.
//  Copyright (c) 2015 Riyad Anabtawi. All rights reserved.
//


#import "Functions.h"


#import <EventKit/EventKit.h>
#import <Foundation/Foundation.h>
@implementation Functions{

    
    NSDateFormatter *myDateFormatter;
    
}
+(NSDate *)getDateFrom2Dates:(NSDate *)dayDate andEndDate:(NSDate *)time_date{


    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:dayDate];
    NSDate *day3 = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    
    comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:time_date];
    day3 = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:day3 options:0];
    
    return day3;

}
+(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) addressStr {
    
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

    
    
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    return center;
    
}




+(NSDate *)stringToDate:(NSString *)string {
    return [Functions stringToDate:string WithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
}

+(NSDate *)stringToDate:(NSString *)string WithFormat:(NSString *)format {
    
    if (string == nil || [string isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    return [formatter dateFromString:string];
}

+(NSString *)dateToString:(NSDate *)date WithFormat:(NSString *)format {
    if (date == nil || [date isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}



+(BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate {
    return [date compare:firstDate] == NSOrderedDescending &&
    [date compare:lastDate]  == NSOrderedAscending;
}






+(NSString *)getUUID
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    
    return uuidString;
}

+(NSURL *)getFooterAdUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://54.221.221.249/1024_56.html#%@",[Functions getUUID]]];
}

+(NSURL *)getBannerAddUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://54.221.221.249/1024_78.html#%@",[Functions getUUID]]];
}

+(void)fillContainerView:(UIView *)container WithView:(UIView *)view {
    NSLayoutConstraint *constraintTop = [NSLayoutConstraint constraintWithItem:view
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:container
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint *constraintRight = [NSLayoutConstraint constraintWithItem:view
                                                                       attribute:NSLayoutAttributeLeading
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:container
                                                                       attribute:NSLayoutAttributeLeading
                                                                      multiplier:1.0f constant:0.0f];
    
    
    NSLayoutConstraint *constraintBottom = [NSLayoutConstraint constraintWithItem:view
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:container
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f constant:0.0f];
    
    
    NSLayoutConstraint *constraintLeft = [NSLayoutConstraint constraintWithItem:view
                                                                      attribute:NSLayoutAttributeTrailing
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:container
                                                                      attribute:NSLayoutAttributeTrailing
                                                                     multiplier:1.0f constant:0.0f];
    
    
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [container addSubview:view];
    
    [container addConstraint:constraintTop];
    [container addConstraint:constraintRight];
    [container addConstraint:constraintBottom];
    [container addConstraint:constraintLeft];
}
+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+(void)addView:(UIView *)view ToContainer:(UIView *)container WithTopMargin:(NSNumber *)topMargin LeftMargin:(NSNumber *)leftMargin BottomMargin:(NSNumber *)bottomMargin RightMargin:(NSNumber *)rightMargin Width:(NSNumber *)width Height:(NSNumber *)height {
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [container addSubview:view];
    
    NSLayoutConstraint *top;
    NSLayoutConstraint *bottom;
    NSLayoutConstraint *left;
    NSLayoutConstraint *right;
    
    NSLayoutConstraint *widthConstraint;
    NSLayoutConstraint *heightConstraint;
    
    if ( topMargin != nil ) {
        top = [NSLayoutConstraint constraintWithItem:view
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:container
                                           attribute:NSLayoutAttributeTop
                                          multiplier:1.0
                                            constant:topMargin.floatValue];
        
        [container addConstraint:top];
    }
    
    if ( leftMargin != nil ) {
        left = [NSLayoutConstraint constraintWithItem:view
                                            attribute:NSLayoutAttributeLeading
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:container
                                            attribute:NSLayoutAttributeLeading
                                           multiplier:1.0
                                             constant:leftMargin.floatValue];
        
        [container addConstraint:left];
    }
    
    if ( bottomMargin != nil ) {
        bottom = [NSLayoutConstraint constraintWithItem:view
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:container
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1.0
                                               constant:bottomMargin.floatValue];
        
        [container addConstraint:bottom];
    }
    
    if ( rightMargin != nil ) {
        right = [NSLayoutConstraint constraintWithItem:view
                                             attribute:NSLayoutAttributeTrailing
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:container
                                             attribute:NSLayoutAttributeTrailing
                                            multiplier:1.0
                                              constant:rightMargin.floatValue];
        
        [container addConstraint:right];
    }
    
    if ( width != nil ) {
        widthConstraint = [NSLayoutConstraint constraintWithItem:view
                                                       attribute:NSLayoutAttributeWidth
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:width.floatValue];
        
        [container addConstraint:widthConstraint];
    }
    
    if ( height != nil ) {
        heightConstraint = [NSLayoutConstraint constraintWithItem:view
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:nil
                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                       multiplier:1.0
                                                         constant:height.floatValue];
        
        [container addConstraint:heightConstraint];
    }
}


+(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}



+(BOOL)validateDateFormat:(NSString *)date_string{

//    NSString *dateAsString = date_string; // string from textfield
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd/mm/yyyy"];
//    NSDate * dateFromString = [dateFormatter dateFromString:dateAsString];
//    
//    if (dateFromString != nil){
//    
//        return YES;
//    }else{
//    
//        return  NO;
//    }
 return YES;
}

//BOUNCE

+(void)buttonBounceAnimation:(UIView *)view {
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    [UIView animateWithDuration:0.3 / 1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.6, 1.6);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 / 2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
}

+(void)buttonBounceAnimation:(UIView *)view withFinalScale:(CGFloat)scale {
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
    
    [UIView animateWithDuration:0.3 / 1.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.6, 1.6);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
            }];
        }];
    }];
}


//COLOR

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



//SHAKEIMAGE

+(void)shakeView:(UIView *)view{
    
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    
    shake.fromValue = [NSNumber numberWithFloat:-0.3];
    
    shake.toValue = [NSNumber numberWithFloat:+0.3];
    
    shake.duration = 0.1;
    
    shake.autoreverses = YES;
    
    shake.repeatCount = 4;
    
    [view.layer addAnimation:shake forKey:@"imageView"];
    
    view.alpha = 1.0;
    
    [UIView animateWithDuration:2.0 delay:2.0 options:UIViewAnimationOptionCurveEaseIn animations:nil completion:nil];
    
}


+ (NSString *)deviceUUID
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:[[NSBundle mainBundle] bundleIdentifier]])
        return [[NSUserDefaults standardUserDefaults] objectForKey:[[NSBundle mainBundle] bundleIdentifier]];
    
    @autoreleasepool {
        
        CFUUIDRef uuidReference = CFUUIDCreate(nil);
        CFStringRef stringReference = CFUUIDCreateString(nil, uuidReference);
        NSString *uuidString = (__bridge NSString *)(stringReference);
        [[NSUserDefaults standardUserDefaults] setObject:uuidString forKey:[[NSBundle mainBundle] bundleIdentifier]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        CFRelease(uuidReference);
        CFRelease(stringReference);
        return uuidString;
    }
}



+(UIImage *)CreateGradientInView:(CGRect )bounds withStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = bounds;
    gradient.colors = @[(id)startColor.CGColor,
                        (id)endColor.CGColor];
    gradient.locations = @[@0.0, @0.77, @1.0];
    
    
    UIGraphicsBeginImageContext(gradient.bounds.size);
    [gradient renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    return gradientImage;
    
    
}


+ (NSMutableAttributedString*)setword:(NSString*)word inText:(NSMutableAttributedString*)mutableAttributedString{
    
    NSUInteger count = 0, length = [mutableAttributedString length];
    NSRange range = NSMakeRange(0, length);
    
    while(range.location != NSNotFound)
    {
        range = [[mutableAttributedString string] rangeOfString:word options:0 range:range];
        if(range.location != NSNotFound) {
            [mutableAttributedString addAttribute:NSFontAttributeName value:@"Arial" range:NSMakeRange(range.location, [word length])];
   
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++;
        }
    }
    
    return mutableAttributedString;
}


+ (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}


+(BOOL)validaNombre:(NSString *)nombre{
//    NSString *serieRegex = @"[A-Za-zÁÉÍÓÚÑáéíóúñf. ]";
//    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", serieRegex];
//    return [nameTest evaluateWithObject:nombre];
     return YES;
}


+(BOOL)validaTelefono:(NSString *)telefono{
//    NSString *serieRegex = @"[0-9]";
//    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", serieRegex];
//    return [telTest evaluateWithObject:telefono];
    return YES;

}
+(BOOL)validaTelefonoLenght:(NSString *)telefono{
//    if (telefono.length==10) {
//        return YES;
//    }else{
//        return NO;
//    }
     return YES;
}





+ (UIImage *) imageFromWebView:(UIWebView *)view
{
    // tempframe to reset view size after image was created
    CGRect tmpFrame         = view.frame;
    
    // set new Frame
    CGRect aFrame               = view.frame;
    aFrame.size.height  = [view sizeThatFits:[[UIScreen mainScreen] bounds].size].height;
    view.frame              = aFrame;
    
    // do image magic
    UIGraphicsBeginImageContext([view sizeThatFits:[[UIScreen mainScreen] bounds].size]);
    
    CGContextRef resizedContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:resizedContext];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // reset Frame of view to origin
    view.frame = tmpFrame;
    return image;
}


@end
