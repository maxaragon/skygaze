//
//  Functions.h
//  SkyGaze
//
//  Created by Riyad Anabtawi on 1/11/15.
//  Copyright (c) 2015 Riyad Anabtawi. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface Functions : NSObject
+ (NSMutableAttributedString*)setword:(NSString*)word inText:(NSMutableAttributedString*)mutableAttributedString;


+(BOOL)validateDateFormat:(NSString *)date_string;
+(CLLocationCoordinate2D)getLocationFromAddressString:(NSString*)addressStr;
+(NSDate *)stringToDate:(NSString *)string;
+(NSDate *)stringToDate:(NSString *)string WithFormat:(NSString *)format;
+(NSString *)dateToString:(NSDate *)date WithFormat:(NSString *)format;
+(UIColor*)colorWithHexString:(NSString*)hex;
//+(NSDate *)addDays:(NSInteger)days toDate:(NSDate *)date;
//+(NSDate *)addMinutes:(NSInteger)minutes toDate:(NSDate *)date;
+(void)buttonBounceAnimation:(UIView *)view withFinalScale:(CGFloat)scale;
+(BOOL)isDate:(NSDate *)date inRangeFirstDate:(NSDate *)firstDate lastDate:(NSDate *)lastDate;
+(void)buttonBounceAnimation:(UIView *)view ;
+(BOOL) NSStringIsValidEmail:(NSString *)checkString;
+(void)addView:(UIView *)view ToContainer:(UIView *)container WithTopMargin:(NSNumber *)topMargin LeftMargin:(NSNumber *)leftMargin BottomMargin:(NSNumber *)bottomMargin RightMargin:(NSNumber *)rightMargin Width:(NSNumber *)width Height:(NSNumber *)height;
+ (NSString *)deviceUUID;

+(UIImage *)CreateGradientInView:(CGRect )bounds withStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor;
+(void)fillContainerView:(UIView *)container WithView:(UIView *)view;
+(NSString *)getUUID;
+ (UIImage *)imageWithColor:(UIColor *)color;
+(NSURL *)getFooterAdUrl;
+(NSURL *)getBannerAddUrl;

+ (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
//Shake view

+(void)shakeView:(UIView *)view;


+(BOOL)validaNombre:(NSString *)nombre;
+(BOOL)validaTelefono:(NSString *)telefono;
+(BOOL)validaTelefonoLenght:(NSString *)telefono;


+(NSDate *)getDateFrom2Dates:(NSDate *)dayDate andEndDate:(NSDate *)time_date;

+ (UIImage *) imageFromWebView:(UIWebView *)view;
+(void)createReminderNotificationForMedia:(NSString *)mediaId WithTitle:(NSString *)title onDate:(NSDate *)date UntilDate:(NSDate *)endDate callback:(void(^)(BOOL))handler;
+(void)createReminderNotificationWithBody:(NSString *)mediaId WithTitle:(NSString *)title onDate:(NSDate *)date UntilDate:(NSDate *)endDate;
@end
