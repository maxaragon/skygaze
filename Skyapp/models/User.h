//
//  User.h
//  SIT
//
//  Created by Riyad Faek Anabtawi Rojas on 5/23/20.
//  Copyright © 2020 Riyad Faek Anabtawi Rojas. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface User : NSObject
@property NSNumber *user_id;
@property NSString *macaddres;
@property NSString *unique_val;
@property NSString *device_token;
@property NSString *email;
@property NSString *name;


-(User *)initWithDictionary:(NSDictionary *)dictionary;
@end
