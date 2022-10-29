//
//  AppDelegate.m
//  Skyapp
//
//  Created by Riyad Anabtawi on 15/10/22.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *pushsettings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:pushsettings];
    [application registerForRemoteNotifications];
    
       [[UIApplication sharedApplication] registerForRemoteNotifications];
    ///-Set badge
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    // Override point for customization after application launch.
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
 
    [[NSUserDefaults standardUserDefaults]setObject:[deviceToken description]forKey:@"tokenPush"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_main"]){
        NSNumber *user_id =[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        
        [Services updateUserToken:user_id andToken:[deviceToken description] AndWithHandler:^(id responseObject) {
            
            
        } orErrorHandler:^(NSError *err) {
            
            
        }];
    
    }
   


}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"tokenPush"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
    
   
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    NSLog( @"Handle push from foreground" );
         [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:nil userInfo:nil];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
    

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:nil userInfo:nil];
    
}


-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void
                                                                                                                               (^)(UIBackgroundFetchResult))completionHandler
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:nil userInfo:userInfo];
    NSLog( @"BACKGROUND" );
    completionHandler( UIBackgroundFetchResultNewData );
 
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
   
 [[NSNotificationCenter defaultCenter] postNotificationName:@"pushNotification" object:nil userInfo:userInfo];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    
  
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - Public method implementation
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    
    
    return YES;
}
@end
