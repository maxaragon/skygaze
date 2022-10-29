//
//  Services.m
//  Skyapp
//
//  Created by Riyad Faek Anabtawi Rojas on 11/6/19.
//  Copyright © 2019 Riyad Faek Anabtawi Rojas. All rights reserved.
//

#import "Services.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFHTTPSessionManager.h>

#define BASE_URL "http://3.144.6.204"
@implementation Services

+(void)updateUserLatLong:(NSNumber *)user_id andLat:(NSString *)latitude andLongitude:(NSString *)longitude AndWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler{
    
    NSDictionary *p = @{@"user_id":user_id,@"mobile_provider":@"ios",@"latitude":latitude,@"longitude":longitude};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    //NSDictionary *params = @{@"prefix":@"param",@"prefix":@"param",@"prefix":@"param"};
    
    [manager POST:[NSString stringWithFormat:@"%s/updateUserLatLong",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             
            handler([responseObject objectForKey:@"Status"]);
             
                
             
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             
                 errorHandler(error);
             
         }];

}
+(void)UpdateUserInfo:(NSNumber *)user_id andName:(NSString *)name andEmail:(NSString *)email AndWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler{
    
    NSDictionary *p = @{@"email":email,@"user_id":user_id,@"name":name};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    //NSDictionary *params = @{@"prefix":@"param",@"prefix":@"param",@"prefix":@"param"};
    
    [manager POST:[NSString stringWithFormat:@"%s/updateUserData",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             
            handler(responseObject);
             
                
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             
                 errorHandler(error);
             
         }];

}


+(void)getWeathericonsWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler{
    
    NSDictionary *p = @{@"":@""};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    //NSDictionary *params = @{@"prefix":@"param",@"prefix":@"param",@"prefix":@"param"};
    
    [manager GET:[NSString stringWithFormat:@"%s/getWeatherIcons",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
             
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *mutarray = [NSMutableArray new];
        for(NSDictionary *dict in responseObject){
            Weathericon *icon = [[Weathericon alloc] initWithDictionary:dict];
            [mutarray addObject:icon];
        }
       
        
        handler(mutarray);
             
                
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             
                 errorHandler(error);
             
         }];

}
+(void)getUserInfo:(NSNumber *)user_id WithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler{
    
    NSDictionary *p = @{@"user_id":user_id};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    //NSDictionary *params = @{@"prefix":@"param",@"prefix":@"param",@"prefix":@"param"};
    
    [manager POST:[NSString stringWithFormat:@"%s/getUserData",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
             
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        User *user = [[User alloc] initWithDictionary:responseObject];
        
        handler(user);
             
                
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             
                 errorHandler(error);
             
         }];

}


+(void)updateUserToken:(NSNumber *)user_id andToken:(NSString *)device_token AndWithHandler:(void (^)(id))handler orErrorHandler:(void (^)(NSError *))errorHandler{
    
    NSDictionary *p = @{@"device_token":device_token,@"user_id":user_id,@"mobile_provider":@"ios"};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    //NSDictionary *params = @{@"prefix":@"param",@"prefix":@"param",@"prefix":@"param"};
    
    [manager POST:[NSString stringWithFormat:@"%s/updateUserToken",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             
            handler([responseObject objectForKey:@"Status"]);
             
                
             
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             
                 errorHandler(error);
             
         }];

}

+(void)GetAllImagesWithHandler:(void (^)(id)) handler orErrorHandler:(void (^)(NSError *)) errorHandler{
    
    NSDictionary *p = @{@"":@""};
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    [manager GET:[NSString stringWithFormat:@"%s/getImagesUploaded",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *mutable = [NSMutableArray new];
        
        for(NSDictionary *dict in responseObject){
            
            [mutable addObject:[[Report alloc] initWithDictionary:dict]];
            
        }
        handler([NSArray arrayWithArray:mutable]);
        
           
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
            errorHandler(error);
        
    }];
    
}




+(void)uploadImageByUser:(NSNumber *)user_id andLatitude:(NSString *)latitude andLogitude:(NSString *)longitude andBase64String:(NSString *)base64string andCompasData:(NSString *)compass_value andAltitude:(NSString *)altitude andAddress:(NSString *)address andIcon:(NSNumber *)icon andComment:(NSString *)comment andWithHandler:(void (^)(id)) handler orErrorHandler:(void (^)(NSError *)) errorHandler{
    
    NSDictionary *p = @{@"user_id":user_id,@"latitude":latitude,@"longitude":longitude,@"base64string":base64string,@"compass_value":compass_value,@"altitude":altitude,@"address":address,@"weathericon_id":icon,@"comment":comment};
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    [manager POST:[NSString stringWithFormat:@"%s/uploadImageByUser",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
  
        handler(responseObject);
        
           
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
            errorHandler(error);
        
    }];
    
}



+(void)registerUser:(NSNumber *)macaddress andUnique_va:(NSString *)unique_va andDeviceToken:(NSString *)device_token andWithHandler:(void (^)(id)) handler orErrorHandler:(void (^)(NSError *)) errorHandler{
    
    NSDictionary *p = @{@"macaddress":macaddress,@"unique_va":unique_va,@"device_token":device_token};
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:p options:0 error:nil];
    
    
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    [manager POST:[NSString stringWithFormat:@"%s/registerUser",BASE_URL] parameters:json headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        User *user = [[User alloc] initWithDictionary:responseObject];
  
        handler(user);
        
           
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
            errorHandler(error);
        
    }];
    
}



@end

