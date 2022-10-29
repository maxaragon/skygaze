//
//  Report.h
//  skygazeapp
//
//  Created by Riyad Anabtawi on 15/10/22.
//

#import <Foundation/Foundation.h>
#define isNSNull(value) [value isKindOfClass:[NSNull class]]
#define replaceNSNullValue(value) isNSNull(value) ? nil : value

@interface Report : NSObject

@property NSNumber *report_id;
@property NSString *address;
@property NSString *icon_url;
@property NSNumber *latitude;
@property NSNumber *longitude;
@property NSString *altitude;
@property NSString *created_at;
@property NSString *compass_value;
@property NSString *icon;
@property NSString *comment;
@property NSString *user_id;
@property NSString *picture_url;



-(Report *)initWithDictionary:(NSDictionary *)dictionary;



@end
