//
//  Report.m
//  skygazeapp
//
//  Created by Riyad Anabtawi on 15/10/22.
//

#import "Report.h"

@implementation Report


-(Report *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        
        if (dictionary){
            self.report_id =  replaceNSNullValue([dictionary objectForKey:@"report_id"]);
            self.created_at =  replaceNSNullValue([dictionary objectForKey:@"created_at"]);
            self.address =  replaceNSNullValue([dictionary objectForKey:@"addres"]);
            self.latitude =  replaceNSNullValue([dictionary objectForKey:@"latitude"]);
            self.longitude =  replaceNSNullValue([dictionary objectForKey:@"longitude"]);
            self.altitude =  replaceNSNullValue([dictionary objectForKey:@"altitude"]);
            self.compass_value =  replaceNSNullValue([dictionary objectForKey:@"compass_value"]);
            self.icon =  replaceNSNullValue([dictionary objectForKey:@"icon"]);
            self.comment =  replaceNSNullValue([dictionary objectForKey:@"comment"]);
            self.user_id =  replaceNSNullValue([dictionary objectForKey:@"user_id"]);
            self.picture_url =  replaceNSNullValue([dictionary objectForKey:@"picture_url"]);
            self.icon_url =  replaceNSNullValue([dictionary objectForKey:@"icon_url"]);
            
            
        }
         
        
        
    }
    return self;
    
}

@end
