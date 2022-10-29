//
//  Weathericon.m
//  Skyapp
//
//  Created by Riyad Faek Anabtawi Rojas on 22/10/22.
//
#define isNSNull(value) [value isKindOfClass:[NSNull class]]
#define replaceNSNullValue(value) isNSNull(value) ? nil : value
#import "Weathericon.h"

@implementation Weathericon
-(Weathericon *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        

        
        
        if (dictionary){
            self.icon_id =  replaceNSNullValue([dictionary objectForKey:@"id"]);
            self.name =  replaceNSNullValue([dictionary objectForKey:@"name"]);
            self.icon_url =  replaceNSNullValue([dictionary objectForKey:@"icon_url"]);
            
            
        }
         
        
        
    }
    return self;
    
}
@end
