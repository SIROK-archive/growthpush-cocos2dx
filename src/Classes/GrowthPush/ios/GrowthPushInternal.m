//
//  GrowthPushInternal.m
//  GrowthPushPlugin
//
//  Created by TSURUDA Ryo on 2013/12/09.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#import "GrowthPushInternal.h"

#import <GrowthPush/GrowthPush.h>

#import "UIApplication+GrowthPushPlugin.h"

@implementation GrowthPushInternal

+ (void)setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug
{
    [GrowthPush setApplicationId:applicationId
                          secret:secret
                     environment:environment
                           debug:debug];
}

+ (void)setApplicationId:(NSInteger)applicationId secret:(NSString *)secret environment:(GPEnvironment)environment debug:(BOOL)debug option:(EGPOption)option
{
    [EasyGrowthPush setApplicationId:applicationId
                              secret:secret
                         environment:environment
                               debug:debug
                              option:option];
}

+ (void)requestDeviceToken
{
    [GrowthPush requestDeviceToken];
}

+ (void)setDeviceToken:(NSData *)deviceToken
{
    [GrowthPush setDeviceToken:deviceToken];
}

+ (void)trackEvent:(NSString *)name
{
    [GrowthPush trackEvent:name];
}

+ (void)trackEvent:(NSString *)name value:(NSString *)value
{
    [GrowthPush trackEvent:name value:value];
}

+ (void)setTag:(NSString *)name
{
    [GrowthPush setTag:name];
}

+ (void)setTag:(NSString *)name value:(NSString *)value
{
    [GrowthPush setTag:name value:value];
}

+ (void)setDeviceTags
{
    [GrowthPush setDeviceTags];
}

+ (void)clearBadge
{
    [GrowthPush clearBadge];
}

@end
