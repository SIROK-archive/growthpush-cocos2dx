//
//  GrowthPushPlugin.mm
//  GrowthPushPlugin
//
//  Created by TSURUDA Ryo on 2013/12/07.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#include "GrowthPushPlugin.h"

#import <GrowthPush/GrowthPush.h>

#import "UIApplication+GrowthPushPlugin.h"

USING_NS_GROWTHPUSH;

GrowthPushPlugin::GrowthPushPlugin(void)
{
}

GrowthPushPlugin::~GrowthPushPlugin(void)
{
}

void GrowthPushPlugin::initialize(int applicationId, const char *secret, growthpush::GPEnvironment environment, bool debug)
{
    CCAssert(secret, "secret should not be NULL");
    
    [GrowthPush setApplicationId:applicationId
                          secret:[NSString stringWithUTF8String:secret]
                     environment:(GPEnvironment)environment
                           debug:debug];
}

void GrowthPushPlugin::initialize(int applicationId, const char *secret, growthpush::GPEnvironment environment, bool debug, growthpush::EGPOption option)
{
    CCAssert(secret, "secret should not be NULL");
    
    [EasyGrowthPush setApplicationId:applicationId
                              secret:[NSString stringWithUTF8String:secret]
                         environment:(GPEnvironment)environment
                               debug:debug
                              option:(EGPOption)option];
}

void GrowthPushPlugin::registerDeviceToken(void)
{
    [GrowthPush requestDeviceToken];
}

void GrowthPushPlugin::trackEvent(const char *name)
{
    CCAssert(name, "name should not be NULL");
    
    [GrowthPush trackEvent:[NSString stringWithUTF8String:name]];
}

void GrowthPushPlugin::trackEvent(const char *name, const char *value)
{
    CCAssert(name, "name should not be  NULL");
    CCAssert(value, "value should not be  NULL");
    
    [GrowthPush trackEvent:[NSString stringWithUTF8String:name] value:[NSString stringWithUTF8String:value]];
}

void GrowthPushPlugin::setTag(const char *name)
{
    CCAssert(name, "name should not be  NULL");
    
    [GrowthPush setTag:[NSString stringWithUTF8String:name]];
}

void GrowthPushPlugin::setTag(const char *name, const char *value)
{
    CCAssert(name, "name should not be  NULL");
    CCAssert(value, "value should not be  NULL");
    
    [GrowthPush setTag:[NSString stringWithUTF8String:name] value:[NSString stringWithUTF8String:value]];
}

void GrowthPushPlugin::setDeviceTags(void)
{
    [GrowthPush setDeviceTags];
}

void GrowthPushPlugin::clearBadge(void)
{
    [GrowthPush clearBadge];
}
