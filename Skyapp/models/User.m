//
//  User.m
//  SIT
//
//  Created by Riyad Faek Anabtawi Rojas on 5/23/20.
//  Copyright © 2020 Riyad Faek Anabtawi Rojas. All rights reserved.
//
#define isNSNull(value) [value isKindOfClass:[NSNull class]]
#define replaceNSNullValue(value) isNSNull(value) ? nil : value
#import "User.h"

@implementation User
-(User *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        

        
        
        if (dictionary){
            self.user_id =  replaceNSNullValue([dictionary objectForKey:@"id"]);
            self.macaddres =  replaceNSNullValue([dictionary objectForKey:@"macaddres"]);
            self.unique_val =  replaceNSNullValue([dictionary objectForKey:@"unique_val"]);
            self.device_token =  replaceNSNullValue([dictionary objectForKey:@"device_token"]);
            self.email =  replaceNSNullValue([dictionary objectForKey:@"email"]);
            self.name =  replaceNSNullValue([dictionary objectForKey:@"name"]);
            
        }
         
        
        
    }
    return self;
    
}
@end
