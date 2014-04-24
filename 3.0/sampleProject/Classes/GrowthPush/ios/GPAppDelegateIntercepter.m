//
//  GPAppDelegateIntercepter.m
//  sampleProject
//
//  Created by Kataoka Naoyuki on 2014/04/24.
//
//

#include "CCPlatformConfig.h"
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS

#import "GPAppDelegateIntercepter.h"

#import "GrowthPushCCInternal.h"

@implementation GPAppDelegateIntercepter

- (BOOL) willPerformApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return [GrowthPushCCInternal application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void) didPerformApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [GrowthPushCCInternal application:application didReceiveRemoteNotification:userInfo];
}

- (void) willPerformApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [GrowthPushCCInternal application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void) willPerformApplication:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [GrowthPushCCInternal application:application didFailToRegisterForRemoteNotificationsWithError:error];
}


@end

#endif /* if CC_TARGET_PLATFORM == CC_PLATFORM_IOS */
