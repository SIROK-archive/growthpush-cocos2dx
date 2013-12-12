//
//  GrowthPush.mm
//  GrowthPushPlugin
//
//  Created by TSURUDA Ryo on 2013/12/07.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#include "GrowthPush.h"

#include "GPJsonHelper.h"
#include "GrowthPushInternal.h"

USING_NS_GROWTHPUSH;

const char *growthpush::kGPDidReceivedNotification = "GPDidReceivedNotification";

GrowthPush::GrowthPush(void)
{
}

GrowthPush::~GrowthPush(void)
{
}

void GrowthPush::initialize(int applicationId, const char *secret, growthpush::GPEnvironment environment, bool debug)
{
    CCAssert(secret, "secret should not be NULL");
    
    setNotificationCallback();
    [GrowthPushInternal setApplicationId:applicationId
                                  secret:[NSString stringWithUTF8String:secret]
                             environment:environment
                                   debug:debug];
}

void GrowthPush::registerDeviceToken(void)
{
    [GrowthPushInternal requestDeviceToken];
}

void GrowthPush::registerDeviceToken(const char *senderId)
{
    CC_UNUSED_PARAM(senderId);  // ignore senderID
    registerDeviceToken();
}

void GrowthPush::trackEvent(const char *name)
{
    CCAssert(name, "name should not be NULL");
    
    [GrowthPushInternal trackEvent:[NSString stringWithUTF8String:name]];
}

void GrowthPush::trackEvent(const char *name, const char *value)
{
    CCAssert(name, "name should not be  NULL");
    CCAssert(value, "value should not be  NULL");
    
    [GrowthPushInternal trackEvent:[NSString stringWithUTF8String:name]
                             value:[NSString stringWithUTF8String:value]];
}

void GrowthPush::setTag(const char *name)
{
    CCAssert(name, "name should not be  NULL");
    
    [GrowthPushInternal setTag:[NSString stringWithUTF8String:name]];
}

void GrowthPush::setTag(const char *name, const char *value)
{
    CCAssert(name, "name should not be  NULL");
    CCAssert(value, "value should not be  NULL");
    
    [GrowthPushInternal setTag:[NSString stringWithUTF8String:name]
                         value:[NSString stringWithUTF8String:value]];
}

void GrowthPush::setDeviceTags(void)
{
    [GrowthPushInternal setDeviceTags];
}

void GrowthPush::clearBadge(void)
{
    [GrowthPushInternal clearBadge];
}

void GrowthPush::setNotificationCallback(void)
{
    [GrowthPushInternal setDidReceivedNotificationBlock:^(NSString *json) {
        CCLOG("************************");
        CCLOG("DidReceivedNotification");
        CCLOG("************************");
        CCObject *jsonObject = GPJsonHelper::parseJson2CCObject([json UTF8String]);
        CCNotificationCenter::sharedNotificationCenter()->postNotification(kGPDidReceivedNotification, jsonObject);
    }];
}

