//
//  Weathericon.h
//  Skyapp
//
//  Created by Riyad Faek Anabtawi Rojas on 22/10/22.
//

#import <Foundation/Foundation.h>


@interface Weathericon : NSObject
@property NSString *name;
@property NSString *icon_url;
@property NSNumber *icon_id;
-(Weathericon *)initWithDictionary:(NSDictionary *)dictionary;
@end

