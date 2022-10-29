//
//  Services.h
//  PBSuite
//
//  Created by Riyad Faek Anabtawi Rojas on 11/6/19.
//  Copyright © 2019 Riyad Faek Anabtawi Rojas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Report.h"
#import "Weathericon.h"

@interface Services : NSObject

+(void)getWeathericonsWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler;

+(void)getUserInfo:(NSNumber *)user_id WithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler;

+(void)UpdateUserInfo:(NSNumber *)user_id andName:(NSString *)name andEmail:(NSString *)email AndWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler;

+(void)updateUserLatLong:(NSNumber *)user_id andLat:(NSString *)latitude andLongitude:(NSString *)longitude AndWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler;


+(void)updateUserToken:(NSNumber *)user_id andToken:(NSString *)device_token AndWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler;

+(void)GetAllImagesWithHandler:(void (^)(id)) handler orErrorHandler:(void (^)(NSError *)) errorHandler;


+(void)registerUser:(NSNumber *)macaddress andUnique_va:(NSString *)unique_va andDeviceToken:(NSString *)device_token andWithHandler:(void (^)(id)) handler orErrorHandler:(void (^)(NSError *)) errorHandler;

+(void)uploadImageByUser:(NSNumber *)user_id andLatitude:(NSString *)latitude andLogitude:(NSString *)longitude andBase64String:(NSString *)base64string andCompasData:(NSString *)compass_value andAltitude:(NSString *)altitude andAddress:(NSString *)address andIcon:(NSNumber *)icon andComment:(NSString *)comment andWithHandler:(void (^)(id)) handler orErrorHandler:(void (^)(NSError *)) errorHandler;




@end
